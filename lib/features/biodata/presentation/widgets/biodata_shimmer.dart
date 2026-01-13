import 'package:flutter/material.dart';

class BiodataShimmer extends StatefulWidget {
  final bool isGridView;
  
  const BiodataShimmer({
    super.key,
    this.isGridView = true,
  });
  
  @override
  State<BiodataShimmer> createState() => _BiodataShimmerState();
}

class _BiodataShimmerState extends State<BiodataShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
    
    _animation = Tween<double>(begin: -2, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return widget.isGridView ? _buildGridShimmer() : _buildListShimmer();
  }
  
  Widget _buildGridShimmer() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _getCrossAxisCount(context),
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: 6,
      itemBuilder: (context, index) => _buildShimmerCard(),
    );
  }
  
  Widget _buildListShimmer() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 4,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: _buildShimmerCard(),
      ),
    );
  }
  
  Widget _buildShimmerCard() {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header shimmer
              Container(
                height: 140,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.grey[300]!,
                      Colors.grey[100]!,
                      Colors.grey[300]!,
                    ],
                    stops: const [0.0, 0.5, 1.0],
                    begin: Alignment(_animation.value, 0),
                    end: Alignment(_animation.value + 1, 0),
                  ),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
              ),
              // Content shimmer
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildShimmerBox(width: 120, height: 14),
                    const SizedBox(height: 10),
                    _buildShimmerBox(width: double.infinity, height: 10),
                    const SizedBox(height: 6),
                    _buildShimmerBox(width: double.infinity, height: 10),
                    const SizedBox(height: 6),
                    _buildShimmerBox(width: 140, height: 10),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  
  Widget _buildShimmerBox({required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
  
  int _getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 1200) return 4;
    if (width > 800) return 3;
    return 2;
  }
}

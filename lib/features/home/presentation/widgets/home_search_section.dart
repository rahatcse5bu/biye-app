import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../biodata/presentation/pages/biodata_list_page.dart';

class HomeSearchSection extends StatefulWidget {
  const HomeSearchSection({super.key});

  @override
  State<HomeSearchSection> createState() => _HomeSearchSectionState();
}

class _HomeSearchSectionState extends State<HomeSearchSection> {
  String? _selectedGender;
  String? _selectedMaritalStatus;

  final List<String> _genderOptions = ['পুরুষ', 'মহিলা'];
  final List<String> _maritalStatusOptions = ['অবিবাহিত', 'বিবাহিত', 'ডিভোর্সড', 'বিধবা/বিপত্নীক'];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'বায়োডাটা খুঁজুন',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildDropdown(
                  label: 'আমি খুঁজছি',
                  value: _selectedGender,
                  items: _genderOptions,
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDropdown(
                  label: 'বৈবাহিক অবস্থা',
                  value: _selectedMaritalStatus,
                  items: _maritalStatusOptions,
                  onChanged: (value) {
                    setState(() {
                      _selectedMaritalStatus = value;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const BiodataListPage(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'খুঁজুন',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              hint: Text(
                'সকল',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 14,
                ),
              ),
              isExpanded: true,
              icon: const Icon(Icons.arrow_drop_down),
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(fontSize: 14),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}

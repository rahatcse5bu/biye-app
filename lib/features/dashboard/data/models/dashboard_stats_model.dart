class DashboardStatsModel {
  final double points;
  final int pendingProposals;
  final int totalProposals;
  final int likesCount;
  final int viewsCount;
  final int favoriteCount;
  final int unFavoriteCount;
  final int contactPurchaseCount;
  final double approvedPercentage;
  final double rejectedPercentage;

  DashboardStatsModel({
    required this.points,
    required this.pendingProposals,
    required this.totalProposals,
    required this.likesCount,
    required this.viewsCount,
    required this.favoriteCount,
    required this.unFavoriteCount,
    required this.contactPurchaseCount,
    required this.approvedPercentage,
    required this.rejectedPercentage,
  });

  factory DashboardStatsModel.fromJson(Map<String, dynamic> json) {
    return DashboardStatsModel(
      points: _toDouble(json['points']),
      pendingProposals: _toInt(json['pending']),
      totalProposals: _toInt(json['total']),
      likesCount: _toInt(json['likes_count']),
      viewsCount: _toInt(json['views_count']),
      favoriteCount: _toInt(json['favorite_count']),
      unFavoriteCount: _toInt(json['unFavorite_count']),
      contactPurchaseCount: _toInt(json['contact_purchase_count']),
      approvedPercentage: _toDouble(json['approvedPercentage']),
      rejectedPercentage: _toDouble(json['rejectedPercentage']),
    );
  }

  // Helper method to safely convert to double
  static double _toDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  // Helper method to safely convert to int
  static int _toInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  factory DashboardStatsModel.empty() {
    return DashboardStatsModel(
      points: 0.0,
      pendingProposals: 0,
      totalProposals: 0,
      likesCount: 0,
      viewsCount: 0,
      favoriteCount: 0,
      unFavoriteCount: 0,
      contactPurchaseCount: 0,
      approvedPercentage: 0.0,
      rejectedPercentage: 0.0,
    );
  }
}

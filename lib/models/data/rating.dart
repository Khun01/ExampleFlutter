class Rating {
  final double? averageRating;
  final double? excellent;
  final double? good;
  final double? average;
  final double? belowAverage;
  final double? poor;
  final int? totalUser;

  Rating(
      {required this.averageRating,
      required this.excellent,
      required this.good,
      required this.average,
      required this.belowAverage,
      required this.poor,
      this.totalUser});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
        averageRating: (json['average_rating'] ?? 0.0) is num
            ? (json['average_rating'] as num).toDouble()
            : 0.0,
        excellent: (json['excellent'] ?? 0.0) is num
            ? (json['excellent'] as num).toDouble()
            : 0.0,
        good: (json['good'] ?? 0.0) is num
            ? (json['good'] as num).toDouble()
            : 0.0,
        average: (json['average'] ?? 0.0) is num
            ? (json['average'] as num).toDouble()
            : 0.0,
        belowAverage: (json['below_average'] ?? 0.0) is num
            ? (json['below_average'] as num).toDouble()
            : 0.0,
        poor: (json['poor'] ?? 0.0) is num
            ? (json['poor'] as num).toDouble()
            : 0.0,
        totalUser: json['total_users'] ?? 0);
  }

  @override
  String toString() {
    return 'Rating(averageRating: $averageRating, excellent: $excellent, good: $good, average: $average, belowAverage: $belowAverage, poor: $poor, total user: $totalUser)';
  }
}

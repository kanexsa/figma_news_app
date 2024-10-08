class DoctorModel {
  final String name;
  final String specialty;
  final double rating;
  final double hourlyRate;
  final bool isLive;
  final bool isFavorite;

  DoctorModel({
    required this.name,
    required this.specialty,
    required this.rating,
    required this.hourlyRate,
    required this.isLive,
    required this.isFavorite,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      name: json['name'],
      specialty: json['specialty'],
      rating: json['rating'].toDouble(),
      hourlyRate: json['hourlyRate'].toDouble(),
      isLive: json['isLive'],
      isFavorite: json['isFavorite'],
    );
  }
}

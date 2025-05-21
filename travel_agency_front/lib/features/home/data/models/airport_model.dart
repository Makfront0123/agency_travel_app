class AirportModel {
  final String airportId;
  final String name;
  final String code;
  final String city;
  final String country;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;

  AirportModel({
    required this.airportId,
    required this.name,
    required this.code,
    required this.city,
    required this.country,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AirportModel.fromJson(Map<String, dynamic> json) {
    return AirportModel(
      airportId: json['airportId'] as String,
      name: json['name'] as String,
      code: json['code'] as String,
      city: json['city'] as String,
      country: json['country'] as String,
      image: json['image'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
}

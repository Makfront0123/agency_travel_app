class AirportModel {
  final String airportId;
  final String name;
  final String city;
  final String country;
  final String? image;
  final double? cheapestFlightPrice;

  AirportModel({
    required this.airportId,
    required this.name,
    required this.city,
    required this.country,
    this.image,
    this.cheapestFlightPrice,
  });

  factory AirportModel.fromJson(Map<String, dynamic> json) {
    return AirportModel(
      airportId: json['airportId'] ?? '',
      name: json['name'] ?? '',
      city: json['city'] ?? '',
      country: json['country'] ?? '',
      image: json['image'],
      cheapestFlightPrice: json['cheapestFlightPrice'] != null
          ? double.tryParse(json['cheapestFlightPrice'].toString())
          : null,
    );
  }
}

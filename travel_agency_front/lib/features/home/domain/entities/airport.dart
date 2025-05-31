class Airport {
  final String name;
  final String code;
  final String city;
  final String country;
  final String image;

  Airport({
    required this.name,
    required this.code,
    required this.city,
    required this.country,
    required this.image,
  });

  factory Airport.toJson(Map<String, dynamic> json) {
    return Airport(
      name: json['name'] as String,
      code: json['code'] as String,
      city: json['city'] as String,
      country: json['country'] as String,
      image: json['image'] as String,
    );
  }
}

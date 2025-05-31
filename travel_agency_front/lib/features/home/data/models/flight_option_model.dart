class FlightOptionsModel {
  final List<String> origins;
  final List<String> destinations;

  FlightOptionsModel({required this.origins, required this.destinations});

  factory FlightOptionsModel.fromJson(Map<String, dynamic> json) {
    return FlightOptionsModel(
      origins: List<String>.from(json['origins']),
      destinations: List<String>.from(json['destinations']),
    );
  }
}

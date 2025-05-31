import 'package:travel_agency_front/features/home/domain/entities/flight.dart';

class FlightModel extends Flight {
  FlightModel({
    required super.id,
    required super.flightId,
    required super.duration,
    required super.airline,
    required super.flightNumber,
    required super.seatsAvailable,
    required super.price,
    required super.destinationId,
    required super.originId,
    required super.dateInitial,
    required super.dateFinal,
  });

  factory FlightModel.fromJson(Map<String, dynamic> json) {
    return FlightModel(
      id: json['id'],
      flightId: json['flightId'],
      duration: json['duration'],
      airline: json['airline'],
      flightNumber: json['flightNumber'],
      seatsAvailable: json['seatsAvailable'],
      price: (json['price'] as num).toDouble(),
      destinationId: json['destinationId'],
      originId: json['originId'],
      dateInitial: DateTime.parse(json['dateInitial']),
      dateFinal: DateTime.parse(json['dateFinal']),
    );
  }
}

import 'package:travel_agency_front/features/reservation/data/models/passenger_model.dart';
import 'package:travel_agency_front/features/reservation/domain/entities/reservation.dart';

class ReservationModel extends Reservation {
  ReservationModel({
    required super.reservationId,
    required super.reservedBy,
    required super.originCity,
    super.price,
    required super.destinationCity,
    super.flightId,
    super.dateInitial,
    super.dateFinal,
    required super.passengers,
  });

  factory ReservationModel.fromJson(Map<String, dynamic> json) {
    return ReservationModel(
      reservationId: json['reservationId'],
      price: json['price'] as double,
      reservedBy: json['reservedBy'],
      originCity: json['originCity'],
      dateFinal: DateTime.parse(json['dateFinal']),
      dateInitial: DateTime.parse(json['dateInitial']),
      destinationCity: json['destinationCity'],
      flightId: json['flightNumber'] != null
          ? (json['flightNumber'] as num).toInt()
          : null,
      passengers: (json['passengers'] as List<dynamic>)
          .map((e) => PassengerModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reservationId': reservationId,
      'reservedBy': reservedBy,
      'originCity': originCity,
      'destinationCity': destinationCity,
      'flightNumber': flightId,
      'dateInitial': dateInitial?.toIso8601String(),
      'dateFinal': dateFinal?.toIso8601String(),
      'passengers':
          passengers.map((p) => (p as PassengerModel).toJson()).toList(),
    };
  }
}

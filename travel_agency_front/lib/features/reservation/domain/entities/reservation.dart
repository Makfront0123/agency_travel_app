import 'package:travel_agency_front/features/reservation/domain/entities/passenger.dart';

class Reservation {
  final String reservationId;
  final String reservedBy;
  final String originCity;
  final String destinationCity;
  final int? flightId;
  final double? price;
  final DateTime? dateInitial;
  final DateTime? dateFinal;

  final List<Passenger> passengers;

  const Reservation({
    required this.reservationId,
    required this.reservedBy,
    required this.originCity,
    required this.destinationCity,
    this.price,
    this.flightId,
    this.dateInitial,
    this.dateFinal,
    required this.passengers,
  });
}

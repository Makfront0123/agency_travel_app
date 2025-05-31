import 'package:travel_agency_front/features/reservation/data/models/passenger_model.dart';
import 'package:travel_agency_front/features/reservation/domain/entities/passenger.dart';

class ReservationRequestModel {
  final int flightId;
  final List<Passenger> passengers;
  final String? paymentMethod;

  ReservationRequestModel({
    required this.passengers,
    required this.flightId,
    this.paymentMethod,
  });

  Map<String, dynamic> toJson() {
    return {
      'passengers':
          passengers.map((p) => (p as PassengerModel).toJson()).toList(),
      if (paymentMethod != null) 'paymentMethod': paymentMethod,
    };
  }
}

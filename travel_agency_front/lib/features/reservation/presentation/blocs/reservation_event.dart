// events
import 'package:travel_agency_front/features/reservation/data/models/reservation_request_model.dart';
import 'package:travel_agency_front/features/reservation/domain/entities/passenger.dart';
import 'package:travel_agency_front/features/reservation/domain/entities/reservation.dart';

abstract class ReservationEvent {}

class SubmitReservation extends ReservationEvent {
  final ReservationRequestModel request;
  final String token;

  SubmitReservation({required this.request, required this.token});
}

class AddPassenger extends ReservationEvent {
  final Passenger passenger;
  final String token;
  AddPassenger(this.passenger, this.token);
}

class RemovePassenger extends ReservationEvent {
  final Passenger passenger;

  RemovePassenger(this.passenger);
}

class SelectPaymentMethod extends ReservationEvent {
  final String method;
  SelectPaymentMethod(this.method);
}

class GetReservationEvent extends ReservationEvent {
  final String id;
  final String token;

  GetReservationEvent(this.id, this.token);
}

class ConfirmAndPayWithStripe extends ReservationEvent {
  final Reservation reservation;
  final List<Passenger> passengers;
  final String paymentMethod;
  final String token;

  ConfirmAndPayWithStripe(
      this.reservation, this.passengers, this.paymentMethod, this.token);
}

class ConfirmAndPayWithPayPal extends ReservationEvent {
  final Reservation reservation;
  final List<Passenger> passengers;
  final String paymentMethod;
  final String token;

  ConfirmAndPayWithPayPal(
      this.reservation, this.passengers, this.paymentMethod, this.token);
}

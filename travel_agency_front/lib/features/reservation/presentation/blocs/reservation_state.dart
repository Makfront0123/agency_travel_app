import 'package:equatable/equatable.dart';
import 'package:travel_agency_front/features/reservation/domain/entities/passenger.dart';
import 'package:travel_agency_front/features/reservation/domain/entities/reservation.dart';

abstract class ReservationState extends Equatable {
  final List<Passenger> passengers;

  const ReservationState({this.passengers = const []});

  @override
  List<Object> get props => [passengers];
}

class ReservationInitial extends ReservationState {
  ReservationInitial() : super(passengers: []);
}

class ReservationLoading extends ReservationState {
  const ReservationLoading({super.passengers});
}

class ReservationSuccess extends ReservationState {
  @override
  // ignore: overridden_fields
  final List<Passenger> passengers;
  final String? paymentMethod;
  final int? flightId;
  final Reservation? reservation;

  const ReservationSuccess(
      {this.passengers = const [],
      this.paymentMethod,
      this.flightId,
      this.reservation});

  ReservationSuccess copyWith({
    List<Passenger>? passengers,
    String? paymentMethod,
    int? flightId,
    Reservation? reservation,
  }) {
    return ReservationSuccess(
      passengers: passengers ?? this.passengers,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      flightId: flightId ?? this.flightId,
      reservation: reservation ?? this.reservation,
    );
  }

  @override
  List<Object> get props => [
        passengers,
        paymentMethod ?? '',
        flightId ?? -1,
        reservation?.reservationId ?? '',
        reservation?.reservedBy ?? '',
        reservation?.originCity ?? '',
        reservation?.destinationCity ?? '',
        reservation?.flightId ?? '',
        reservation?.price ?? 0,
        reservation?.dateInitial?.toIso8601String() ?? '',
        reservation?.dateFinal?.toIso8601String() ?? '',
      ];
}

class ReservationFailure extends ReservationState {
  final String message;
  const ReservationFailure(this.message, {super.passengers});

  @override
  List<Object> get props => [message, ...super.passengers];
}

class PaymentInProgress extends ReservationState {}

class PaymentSuccess extends ReservationState {}

class PaymentFailed extends ReservationState {
  final String message;
  const PaymentFailed(this.message);
}

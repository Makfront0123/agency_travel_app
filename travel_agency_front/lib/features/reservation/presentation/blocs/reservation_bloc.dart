import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_agency_front/features/payment/domain/entities/payment.dart';
import 'package:travel_agency_front/features/payment/domain/repository/payment_repository.dart';
import 'package:travel_agency_front/features/reservation/domain/entities/passenger.dart';
import 'package:travel_agency_front/features/reservation/domain/usecase/get_reservation.dart';
import 'package:travel_agency_front/features/reservation/domain/usecase/submit_reservation.dart';
import 'package:travel_agency_front/features/reservation/presentation/blocs/reservation_event.dart';
import 'package:travel_agency_front/features/reservation/presentation/blocs/reservation_state.dart';
import 'package:travel_agency_front/main.dart';

class ReservationBloc extends Bloc<ReservationEvent, ReservationState> {
  final SubmitReservationUsecase _submitReservationUsecase;
  final GetReservationUseCase _getReservationUseCase;
  final PaymentRepository paymentRepository;

  ReservationBloc({
    required SubmitReservationUsecase submitReservationUsecase,
    required GetReservationUseCase getReservationUseCase,
    required this.paymentRepository,
  })  : _submitReservationUsecase = submitReservationUsecase,
        _getReservationUseCase = getReservationUseCase,
        super(ReservationInitial()) {
    on<SubmitReservation>(_onSubmitReservation);
    on<AddPassenger>(_addPassenger);
    on<RemovePassenger>(_removePassenger);
    on<SelectPaymentMethod>(_onSelectPaymentMethod);
    on<GetReservationEvent>(_onGetReservation);

    on<ConfirmAndPayWithStripe>(_onStripePayment);
    on<ConfirmAndPayWithPayPal>(_onPaypalPayment);
  }

  void _onSelectPaymentMethod(
      SelectPaymentMethod event, Emitter<ReservationState> emit) {
    final currentState = state;
    if (currentState is ReservationSuccess) {
      emit(ReservationSuccess(
        passengers: currentState.passengers,
        paymentMethod: event.method,
      ));
    } else {
      emit(ReservationSuccess(
        passengers: const [],
        paymentMethod: event.method,
      ));
    }
  }

  Future<void> _onSubmitReservation(
      SubmitReservation event, Emitter<ReservationState> emit) async {
    emit(const ReservationLoading());
    try {
      // 🛫 1. Crear la reserva y obtener el ID
      final createdReservation =
          await _submitReservationUsecase.call(event.request, event.token);

      // 🛬 2. Luego obtener la reserva completa desde el backend
      final reservation = await _getReservationUseCase.execute(
          createdReservation.reservationId, event.token);

      emit(ReservationSuccess(
        passengers: reservation.passengers,
        flightId: reservation.flightId,
        reservation: reservation,
        paymentMethod: event.request.paymentMethod,
      ));
    } catch (e) {
      emit(ReservationFailure(e.toString()));
    }
  }

  Future<void> _addPassenger(
      AddPassenger event, Emitter<ReservationState> emit) async {
    final updatedPassengers = List<Passenger>.from(state.passengers)
      ..add(event.passenger);

    emit(ReservationSuccess(passengers: updatedPassengers));
  }

  Future<void> _removePassenger(
      RemovePassenger event, Emitter<ReservationState> emit) async {
    final updatedPassengers = List<Passenger>.from(state.passengers)
      ..remove(event.passenger);
    emit(ReservationSuccess(passengers: updatedPassengers));
  }

  Future<void> _onGetReservation(
      GetReservationEvent event, Emitter<ReservationState> emit) async {
    emit(const ReservationLoading());
    try {
      final reservation = await _getReservationUseCase.execute(
        event.id,
        event.token,
      );
      emit(ReservationSuccess(
        reservation: reservation,
        flightId: reservation.flightId,
        passengers: reservation.passengers,
      ));
    } catch (e) {
      emit(ReservationFailure(e.toString()));
    }
  }

  Future<void> _onStripePayment(
    ConfirmAndPayWithStripe event,
    Emitter<ReservationState> emit,
  ) async {
    emit(PaymentInProgress());
    try {
      final price = event.reservation.price ?? 0.0;

      await paymentRepository.processPayment(
        price.toStringAsFixed(2),
        "USD",
      );

      // 2. Enviar los datos del pago a tu backend
      final paymentRequest = Payment(
        currency: "USD",
        paymentDate: DateTime.now().toIso8601String(),
        status: "PAID",
        amount: price,
        paymentMode: "Stripe",
        reservationId: event.reservation.reservationId,
      );

      await paymentRepository.addPayment(paymentRequest, event.token);

      emit(PaymentSuccess());
    } catch (e) {
      emit(PaymentFailed("Stripe payment failed: ${e.toString()}"));
    }
  }

  Future<void> _onPaypalPayment(
    ConfirmAndPayWithPayPal event,
    Emitter<ReservationState> emit,
  ) async {
    emit(PaymentInProgress());
    try {
      final price = event.reservation.price ?? 0.0;
      final context = navigatorKey.currentContext!;

      await paymentRepository.processPaymentWithPayPal(
        context,
        price.toStringAsFixed(2),
        "USD",
      );

      // 2. Enviar los datos del pago a tu backend
      final paymentRequest = Payment(
        currency: "USD",
        paymentDate: DateTime.now().toIso8601String(),
        status: "PAID",
        amount: price,
        paymentMode: "PayPal", // 👈 corregido aquí
        reservationId: event.reservation.reservationId,
      );

      await paymentRepository.addPayment(paymentRequest, event.token);
      emit(PaymentSuccess());
    } catch (e) {
      emit(PaymentFailed("PayPal payment failed: ${e.toString()}"));
    }
  }
}

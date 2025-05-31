import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_agency_front/features/payment/domain/usecase/get_payment_user.dart';
import 'package:travel_agency_front/features/payment/presentation/blocs/payment_event.dart';
import 'package:travel_agency_front/features/payment/presentation/blocs/payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final GetPaymentUserUsecase _getPaymentUserUsecase;

  PaymentBloc({
    required GetPaymentUserUsecase getPaymentUserUsecase,
  })  : _getPaymentUserUsecase = getPaymentUserUsecase,
        super(PaymentInitialState()) {
    on<GetPaymentEvent>(_onGetPayment);
  }

  Future<void> _onGetPayment(
      GetPaymentEvent event, Emitter<PaymentState> emit) async {
    emit(PaymentLoading());
    try {
      final payments = await _getPaymentUserUsecase.execute(event.token);
      emit(PaymentLoaded(payments));
    } catch (e) {
      emit(PaymentFailureState('Error loading payments: ${e.toString()}'));
    }
  }
}

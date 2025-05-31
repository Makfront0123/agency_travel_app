abstract class PaymentEvent {}

class GetPaymentEvent extends PaymentEvent {
  final String token;

  GetPaymentEvent(this.token);
}

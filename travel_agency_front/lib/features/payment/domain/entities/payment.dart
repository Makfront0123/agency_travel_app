class Payment {
  final double amount;
  final String? currency;
  final String paymentDate;
  final String status;

  final String paymentMode;
  final String reservationId;

  Payment({
    required this.amount,
    this.currency,
    required this.paymentDate,
    required this.status,
    required this.paymentMode,
    required this.reservationId,
  });

  Map<String, dynamic> toJson() {
    return {
      'total': amount,
      'currency': currency,
      'paymentDate': paymentDate,
      'status': status,
      'paymentMode': paymentMode,
      'reservationId': reservationId,
    };
  }
}

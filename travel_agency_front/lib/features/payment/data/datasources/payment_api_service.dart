import 'package:dio/dio.dart';
import 'package:travel_agency_front/features/payment/data/models/payment_model.dart';
import 'package:travel_agency_front/features/payment/domain/entities/payment.dart';

class PaymentApiService {
  final Dio _dio;
  final String baseUrl;

  PaymentApiService(this._dio, this.baseUrl);

  Future<Payment> registerPayment(Payment request, String token) async {
    final response = await _dio.post('$baseUrl/payment',
        data: request.toJson(),
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }));

    return PaymentModel.fromJson(response.data);
  }

  Future<List<Payment>> getPaymentUser(String token) async {
    final response = await _dio.get('$baseUrl/payment/user',
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }));

    final List<dynamic> data = response.data;
    return data.map((json) => PaymentModel.fromJson(json)).toList();
  }
}

import 'package:dio/dio.dart';
import 'package:travel_agency_front/features/reservation/data/models/passenger_model.dart';
import 'package:travel_agency_front/features/reservation/data/models/reservation_model.dart';
import 'package:travel_agency_front/features/reservation/data/models/reservation_request_model.dart';
import 'package:travel_agency_front/features/reservation/domain/entities/reservation.dart';

class ReservationApiService {
  final Dio _dio;
  final String baseUrl;

  ReservationApiService(this._dio, this.baseUrl);

  Future<Reservation> addReservation(
      ReservationRequestModel reservation, String token) async {
    try {
      final response = await _dio.post('$baseUrl/reservation',
          data: {
            'flightId': reservation.flightId,
            'passengers': reservation.passengers
                .map((p) => (p as PassengerModel).toJson())
                .toList(),
          },
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));

      return ReservationModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Reservation> getReservation(String id, String token) async {
    try {
      final response = await _dio.get('$baseUrl/reservation/$id',
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));

      return ReservationModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addPassenger(PassengerModel request) async {
    try {
      final response = await _dio.post('$baseUrl/passenger', data: {
        'fullName': request.fullName,
        'email': request.email,
      });

      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}

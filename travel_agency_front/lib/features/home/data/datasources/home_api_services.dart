import 'package:dio/dio.dart';
import 'package:travel_agency_front/features/home/data/models/airport_model.dart';
import 'package:travel_agency_front/features/home/data/models/flight_model.dart';
import 'package:travel_agency_front/features/home/data/models/flight_option_model.dart';

class HomeApiService {
  final Dio _dio;
  final String baseUrl;

  HomeApiService(this._dio, this.baseUrl);
  Future<List<AirportModel>> getAllAirports(String token) async {
    final response = await _dio.get(
      '$baseUrl/airport/with-prices',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    final List<dynamic> data = response.data;
    return data.map((json) => AirportModel.fromJson(json)).toList();
  }

  Future<List<FlightModel>> searchFlights(
      String from, String to, String date, String token) async {
    try {
      final response = await _dio.get(
        '$baseUrl/flight/search',
        queryParameters: {
          'from': from,
          'to': to,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      final List<dynamic> data = response.data;
      return data.map((json) => FlightModel.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<FlightOptionsModel> loadFlightCities(String token) async {
    final response = await _dio.get(
      '$baseUrl/flight/search/options',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    return FlightOptionsModel.fromJson(response.data);
  }
}

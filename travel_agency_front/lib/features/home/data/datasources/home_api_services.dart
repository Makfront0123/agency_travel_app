import 'package:dio/dio.dart';
import 'package:travel_agency_front/features/home/domain/entities/airport.dart';

class HomeApiService {
  final Dio _dio;
  final String baseUrl;

  HomeApiService(this._dio, this.baseUrl);
  Future<List<Airport>> getAllAirports() async {
    final response = await _dio.get('$baseUrl/airports');

    return response.data;
  }
}

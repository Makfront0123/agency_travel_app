import 'package:dio/dio.dart';
import 'package:travel_agency_front/features/home/data/models/airport_model.dart';

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

    final List<dynamic> data = response.data; // ✅ ya es la lista directamente
    return data.map((json) => AirportModel.fromJson(json)).toList();
  }
}

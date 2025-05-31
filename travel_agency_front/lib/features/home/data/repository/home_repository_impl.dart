import 'package:travel_agency_front/features/home/data/datasources/home_api_services.dart';
import 'package:travel_agency_front/features/home/data/models/airport_model.dart';
import 'package:travel_agency_front/features/home/data/models/flight_model.dart';
import 'package:travel_agency_front/features/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeApiService homeApiService;

  HomeRepositoryImpl(this.homeApiService);
  @override
  Future<List<AirportModel>> getAllAirports(String token) {
    return homeApiService.getAllAirports(token);
  }

  @override
  Future<List<FlightModel>> searchFlights(
      String from, String to, String date, String token) {
    return homeApiService.searchFlights(from, to, date, token);
  }

  @override
  Future<void> loadFlightCities(String token) async {
    await homeApiService.loadFlightCities(token);
  }
}

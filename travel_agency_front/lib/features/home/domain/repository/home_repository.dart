import 'package:travel_agency_front/features/home/data/models/airport_model.dart';

abstract class HomeRepository {
  Future<List<AirportModel>> getAllAirports(String token);
  Future<List<AirportModel>> searchFlights(
      String from, String to, String date, String token);
  Future<void> loadFlightCities(String token);
}

import 'package:travel_agency_front/features/home/data/models/airport_model.dart';

abstract class HomeRepository {
  Future<List<AirportModel>> getAllAirports(String token);
}

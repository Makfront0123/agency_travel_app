import 'package:travel_agency_front/features/home/domain/entities/airport.dart';

abstract class HomeRepository {
  Future<List<Airport>> getAllAirports();
}

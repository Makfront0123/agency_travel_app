import 'package:travel_agency_front/features/home/data/datasources/home_api_services.dart';
import 'package:travel_agency_front/features/home/domain/entities/airport.dart';
import 'package:travel_agency_front/features/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeApiService homeApiService;

  HomeRepositoryImpl(this.homeApiService);
  @override
  Future<List<Airport>> getAllAirports() {
    return homeApiService.getAllAirports();
  }
}

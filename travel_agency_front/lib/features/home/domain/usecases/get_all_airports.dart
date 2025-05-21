import 'package:travel_agency_front/features/home/domain/entities/airport.dart';
import 'package:travel_agency_front/features/home/domain/repository/home_repository.dart';

class GetAllAirportsUsecase {
  final HomeRepository homeRepository;

  GetAllAirportsUsecase(this.homeRepository);

  Future<List<Airport>> call() async {
    return homeRepository.getAllAirports();
  }
}

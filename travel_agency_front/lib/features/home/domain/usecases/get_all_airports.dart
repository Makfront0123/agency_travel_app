import 'package:travel_agency_front/features/home/data/models/airport_model.dart';
import 'package:travel_agency_front/features/home/domain/repository/home_repository.dart';

class GetAllAirportsUsecase {
  final HomeRepository homeRepository;

  GetAllAirportsUsecase(this.homeRepository);

  Future<List<AirportModel>> call(String token) async {
    return homeRepository.getAllAirports(token);
  }
}

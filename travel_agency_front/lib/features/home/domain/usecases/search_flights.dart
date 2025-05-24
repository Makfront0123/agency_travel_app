import 'package:travel_agency_front/features/home/data/models/flight_model.dart';
import 'package:travel_agency_front/features/home/domain/repository/home_repository.dart';

class SearchFlightsUsecase {
  final HomeRepository _homeRepository;
  SearchFlightsUsecase(this._homeRepository);

  Future<List<FlightModel>> call(
      String from, String to, String date, String token) async {
    return _homeRepository.searchFlights(from, to, date, token);
  }
}

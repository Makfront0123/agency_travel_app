import 'package:travel_agency_front/features/home/data/datasources/home_api_services.dart';
import 'package:travel_agency_front/features/home/data/models/flight_option_model.dart';

class LoadFlightCitiesUsecase {
  final HomeApiService api;

  LoadFlightCitiesUsecase(this.api);

  Future<FlightOptionsModel> call(String token) async {
    return await api.loadFlightCities(token);
  }
}

import 'package:travel_agency_front/features/home/data/models/airport_model.dart';
import 'package:travel_agency_front/features/home/data/models/flight_model.dart';

class HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<AirportModel> airports;

  HomeLoaded(this.airports);
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}

class HomeInitial extends HomeState {}

class SearchFlightsLoading extends HomeState {}

class SearchFlightsLoaded extends HomeState {
  final List<FlightModel> flights;

  SearchFlightsLoaded(this.flights);
}

class SearchFlightsError extends HomeState {
  final String message;

  SearchFlightsError(this.message);
}

class LoadFlightCitiesLoading extends HomeState {}

class LoadFlightCitiesLoaded extends HomeState {
  final List<String> origins;
  final List<String> destinations;

  LoadFlightCitiesLoaded(this.origins, this.destinations);
}

class LoadFlightCitiesError extends HomeState {
  final String message;

  LoadFlightCitiesError(this.message);
}

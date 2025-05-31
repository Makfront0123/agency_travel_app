abstract class HomeEvent {}

class GetAllAirportsEvent extends HomeEvent {
  final String token;
  GetAllAirportsEvent({required this.token});
}

class SearchFlightsEvent extends HomeEvent {
  final String from;
  final String to;
  final String date;
  final String token;
  SearchFlightsEvent(
      {required this.from,
      required this.to,
      required this.date,
      required this.token});
}

class LoadFlightCitiesEvent extends HomeEvent {
  final String token;
  LoadFlightCitiesEvent({required this.token});
}

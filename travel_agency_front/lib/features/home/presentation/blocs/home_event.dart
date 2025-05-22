abstract class HomeEvent {}

class GetAllAirportsEvent extends HomeEvent {
  final String token;
  GetAllAirportsEvent({required this.token});
}

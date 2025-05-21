import 'package:travel_agency_front/features/home/domain/entities/airport.dart';

class HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Airport> airports;

  HomeLoaded(this.airports);
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}

class HomeInitial extends HomeState {}

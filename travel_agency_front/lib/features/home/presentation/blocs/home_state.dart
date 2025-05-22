import 'package:travel_agency_front/features/home/data/models/airport_model.dart';

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

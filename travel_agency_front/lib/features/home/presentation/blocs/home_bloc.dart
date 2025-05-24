import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_agency_front/features/home/domain/usecases/get_all_airports.dart';
import 'package:travel_agency_front/features/home/domain/usecases/load_flight_cities.dart';
import 'package:travel_agency_front/features/home/domain/usecases/search_flights.dart';
import 'package:travel_agency_front/features/home/presentation/blocs/home_event.dart';
import 'package:travel_agency_front/features/home/presentation/blocs/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetAllAirportsUsecase _getAllAirportsUsecase;
  final SearchFlightsUsecase _searchFlightsUsecase;
  final LoadFlightCitiesUsecase _loadFlightCitiesUsecase;
  HomeBloc({
    required GetAllAirportsUsecase getAllAirportsUsecase,
    required SearchFlightsUsecase searchFlightsUsecase,
    required LoadFlightCitiesUsecase loadFlightCitiesUsecase,
  })  : _getAllAirportsUsecase = getAllAirportsUsecase,
        _searchFlightsUsecase = searchFlightsUsecase,
        _loadFlightCitiesUsecase = loadFlightCitiesUsecase,
        super(HomeInitial()) {
    on<GetAllAirportsEvent>(_onGetAllAirportsEvent);
    on<SearchFlightsEvent>(_onSearchFlightsEvent);
    on<LoadFlightCitiesEvent>(_onLoadFlightCitiesEvent);
  }

  Future<void> _onGetAllAirportsEvent(
      GetAllAirportsEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final airports = await _getAllAirportsUsecase(event.token);
      emit(HomeLoaded(airports));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> _onSearchFlightsEvent(
      SearchFlightsEvent event, Emitter<HomeState> emit) async {
    emit(SearchFlightsLoading());
    try {
      final flights = await _searchFlightsUsecase(
          event.from, event.to, event.date, event.token);
      emit(SearchFlightsLoaded(flights));
    } catch (e) {
      emit(SearchFlightsError(e.toString()));
    }
  }

  Future<void> _onLoadFlightCitiesEvent(
      LoadFlightCitiesEvent event, Emitter<HomeState> emit) async {
    emit(LoadFlightCitiesLoading());
    try {
      final options = await _loadFlightCitiesUsecase(event.token);
      emit(LoadFlightCitiesLoaded(options.origins, options.destinations));
    } catch (e) {
      emit(LoadFlightCitiesError(e.toString()));
    }
  }
}

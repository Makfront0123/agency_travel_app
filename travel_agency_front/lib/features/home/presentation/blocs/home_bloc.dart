import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_agency_front/features/home/domain/usecases/get_all_airports.dart';
import 'package:travel_agency_front/features/home/presentation/blocs/home_event.dart';
import 'package:travel_agency_front/features/home/presentation/blocs/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetAllAirportsUsecase _getAllAirportsUsecase;
  HomeBloc({
    required GetAllAirportsUsecase getAllAirportsUsecase,
  })  : _getAllAirportsUsecase = getAllAirportsUsecase,
        super(HomeInitial()) {
    on<GetAllAirportsEvent>(_onGetAllAirportsEvent);
  }

  Future<void> _onGetAllAirportsEvent(
      GetAllAirportsEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final airports = await _getAllAirportsUsecase();
      emit(HomeLoaded(airports));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}

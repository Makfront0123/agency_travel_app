import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_agency_front/features/application/presentation/blocs/application_event.dart';
import 'package:travel_agency_front/features/application/presentation/blocs/application_state.dart';
import 'package:travel_agency_front/features/home/presentation/screen/home_screen.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  ApplicationBloc()
      : super(
          const ApplicationState(
            currentIndex: 0,
            pages: [
              HomeScreen(),
              HomeScreen(),
              HomeScreen(),
              HomeScreen(),
              HomeScreen(),
            ],
          ),
        ) {
    on<TabChangedEvent>(_onTabChanged);
  }

  void _onTabChanged(TabChangedEvent event, Emitter<ApplicationState> emit) {
    emit(state.copyWith(currentIndex: event.newIndex));
  }
}

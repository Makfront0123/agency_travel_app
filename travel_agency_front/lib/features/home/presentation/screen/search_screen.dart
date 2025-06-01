// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_agency_front/features/auth/presentation/widgets/auth_button.dart';
import 'package:travel_agency_front/features/auth/services/storage_services.dart';
import 'package:travel_agency_front/features/home/data/models/airport_model.dart';
import 'package:travel_agency_front/features/home/presentation/blocs/home_bloc.dart';
import 'package:travel_agency_front/features/home/presentation/blocs/home_event.dart';
import 'package:travel_agency_front/features/home/presentation/blocs/home_state.dart';
import 'package:travel_agency_front/features/home/presentation/widget/dropdown_button.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<AirportModel> airports = [];
  List<String> origins = [];
  List<String> destinations = [];
  String? selectedFrom;
  String? selectedTo;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    final token = await StorageService().getToken();
    if (token != null) {
      final bloc = context.read<HomeBloc>();
      bloc.add(GetAllAirportsEvent(token: token));
      bloc.add(LoadFlightCitiesEvent(token: token));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.search),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: BlocListener<HomeBloc, HomeState>(
            listener: (context, state) {
              if (state is HomeLoaded) {
                setState(() => airports = state.airports);
              } else if (state is LoadFlightCitiesLoaded) {
                setState(() {
                  origins = state.origins;
                  destinations = state.destinations;
                });
              }
            },
            child: _buildSearchFlights(),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchFlights() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          DropdownItem(
            title: 'From',
            items: origins,
            selectedItem: selectedFrom,
            onChanged: (value) {
              setState(() {
                selectedFrom = value;
              });
            },
          ),
          const SizedBox(height: 15),
          DropdownItem(
            title: 'To',
            items: destinations,
            selectedItem: selectedTo,
            onChanged: (value) {
              setState(() {
                selectedTo = value;
              });
            },
          ),
          const SizedBox(height: 15),
          AuthButton(
            onTap: _onSearchFlights,
            text: 'Search Flights',
          )
        ],
      ),
    );
  }

  void _onSearchFlights() async {
    final token = await StorageService().getToken();

    if (token != null) {
      context.read<HomeBloc>().add(
            SearchFlightsEvent(
              from: selectedFrom ?? '',
              to: selectedTo ?? '',
              token: token,
              date: DateTime.now().toString(),
            ),
          );

      Navigator.pushNamed(context, '/flightResults');
    }
  }
}

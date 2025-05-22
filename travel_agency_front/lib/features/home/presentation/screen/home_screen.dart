// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_agency_front/features/auth/presentation/widgets/auth_button.dart';
import 'package:travel_agency_front/features/auth/services/storage_services.dart';
import 'package:travel_agency_front/features/home/presentation/blocs/home_bloc.dart';
import 'package:travel_agency_front/features/home/presentation/blocs/home_event.dart';
import 'package:travel_agency_front/features/home/presentation/blocs/home_state.dart';
import 'package:travel_agency_front/features/home/presentation/widget/dropdown_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _loadAirports();
  }

  Future<void> _loadAirports() async {
    final token = await StorageService().getToken();

    if (token != null) {
      context.read<HomeBloc>().add(GetAllAirportsEvent(token: token));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No hay sesión iniciada"),
          backgroundColor: Colors.red,
        ),
      );
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
          child: BlocConsumer<HomeBloc, HomeState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is HomeLoaded) {
                return Column(
                  children: [
                    _buildSearchFlights(),
                    _buildHomeList(state),
                  ],
                );
              }

              if (state is HomeError) {
                print(state.message);
                return _buildHomeError(state);
              }

              return _buildHomeLoad();
            },
          ),
        ),
      ),
    );
  }

  Center _buildHomeLoad() => const Center(child: CircularProgressIndicator());

  Center _buildHomeError(HomeError state) =>
      Center(child: Text('Error: ${state.message}'));

  Widget _buildHomeList(HomeLoaded state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Popular Destinations',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
          ),
          const SizedBox(height: 40),
          ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: state.airports.length,
            itemBuilder: (context, index) {
              return _buildListCard(state, index);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildListCard(HomeLoaded state, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.3),
                    offset: const Offset(0, 10))
              ]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              state.airports[index].image ?? '',
              fit: BoxFit.cover,
              height: 100,
            ),
          ),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${state.airports[index].city}, ${state.airports[index].country}',
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            Text('\$${state.airports[index].cheapestFlightPrice}'),
          ],
        ),
      ],
    );
  }

  Widget _buildSearchFlights() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          const DropdownItem(),
          const SizedBox(height: 15),
          const DropdownItem(),
          const SizedBox(height: 15),
          const DropdownItem(),
          const SizedBox(height: 30),
          AuthButton(
            onTap: () {},
            text: 'Search Flights',
          )
        ],
      ),
    );
  }
}

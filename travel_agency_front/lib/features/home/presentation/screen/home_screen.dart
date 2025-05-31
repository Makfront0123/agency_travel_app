// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_agency_front/features/auth/domain/entities/user.dart';
import 'package:travel_agency_front/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:travel_agency_front/features/auth/presentation/blocs/auth_state.dart';
import 'package:travel_agency_front/features/auth/presentation/widgets/auth_button.dart';
import 'package:travel_agency_front/features/auth/services/storage_services.dart';
import 'package:travel_agency_front/features/home/data/models/airport_model.dart';
import 'package:travel_agency_front/features/home/presentation/blocs/home_bloc.dart';
import 'package:travel_agency_front/features/home/presentation/blocs/home_event.dart';
import 'package:travel_agency_front/features/home/presentation/blocs/home_state.dart';
import 'package:travel_agency_front/features/home/presentation/widget/dropdown_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  List<AirportModel> airports = [];
  List<String> origins = [];
  List<String> destinations = [];
  String? selectedFrom;
  String? selectedTo;

  late final AnimationController _controller;
  late final Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
    _loadAnimation();
  }

  Future<void> _loadInitialData() async {
    final token = await StorageService().getToken();

    if (token != null) {
      final bloc = context.read<HomeBloc>();
      bloc.add(GetAllAirportsEvent(token: token));
      bloc.add(LoadFlightCitiesEvent(token: token));
    }
  }

  void _loadAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
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

  @override
  Widget build(BuildContext context) {
    final user = context.select<AuthBloc, User?>((bloc) {
      final state = bloc.state;
      if (state is Authenticated) {
        return state.user;
      }
      return null;
    });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: user != null
              ? Text('Welcome, ${user.name}')
              : const Text('Welcome'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications),
            )
          ],
        ),
        body: BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is HomeLoaded) {
              setState(() => airports = state.airports);
              _controller.forward();
            } else if (state is LoadFlightCitiesLoaded) {
              setState(() {
                origins = state.origins;
                destinations = state.destinations;
              });
            } else if (state is HomeError || state is LoadFlightCitiesError) {
              final message = (state as dynamic).message;
              print('Error: $message');
            }
          },
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            children: [
              AnimatedOpacity(
                opacity: airports.isEmpty ? 0 : 1,
                duration: const Duration(milliseconds: 1200),
                child: _buildSearchFlights(),
              ),
              const SizedBox(height: 20),
              const Text(
                'Popular Destinations',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
              ),
              const SizedBox(height: 20),
              ...List.generate(
                  airports.length,
                  (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: _buildListCard(index),
                      )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchFlights() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
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

  Widget _buildHomeList() {
    print('airports: ${airports.length}');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
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
            itemCount: airports.length,
            itemBuilder: (context, index) {
              return _buildListCard(index);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildListCard(int index) {
    final airport = airports[index];
    return SlideTransition(
      position: _offsetAnimation,
      child: FadeTransition(
        opacity: _controller,
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.3),
                    offset: const Offset(0, 10),
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: airport.image ??
                      'https://cdn.wallpapersafari.com/88/24/sAfEUB.jpeg',
                  fit: BoxFit.cover,
                  height: 150,
                  width: 150,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${airport.city}, ${airport.country}',
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text('\$${airport.cheapestFlightPrice}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

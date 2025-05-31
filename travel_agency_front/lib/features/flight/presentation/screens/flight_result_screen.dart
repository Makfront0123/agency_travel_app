import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_agency_front/core/theme/app_colors.dart';
import 'package:travel_agency_front/core/utils/date_formatted.dart';
import 'package:travel_agency_front/features/flight/presentation/widget/custom_appbar.dart';
import 'package:travel_agency_front/features/home/presentation/blocs/home_bloc.dart';
import 'package:travel_agency_front/features/home/presentation/blocs/home_state.dart';

class FlightResultScreen extends StatefulWidget {
  const FlightResultScreen({super.key});

  @override
  State<FlightResultScreen> createState() => _FlightResultScreenState();
}

class _FlightResultScreenState extends State<FlightResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Flight Result',
        showUser: true,
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is SearchFlightsLoaded) {
            if (state.flights.isEmpty) {
              return const Center(
                child: Text(
                  'No se encontraron vuelos para esta búsqueda',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: Colors.black),
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
              child: _buildFlithList(state),
            );
          }

          if (state is SearchFlightsError) {
            return const Center(child: Text('Error al buscar resultados'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  ListView _buildFlithList(SearchFlightsLoaded state) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: state.flights.length,
      itemBuilder: (context, index) {
        return _buildFlightListContent(state, index);
      },
    );
  }

  Widget _buildFlightListContent(SearchFlightsLoaded state, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/flightDetails',
          arguments: state.flights[index],
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
            border: Border(
                bottom:
                    BorderSide(color: AppColors.borderLightColor, width: 1))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.flights[index].airline,
                  style: const TextStyle(fontSize: 23, color: Colors.black),
                ),
                const SizedBox(height: 10),
                Text(
                  DateFormatter.formatTime(state.flights[index].dateInitial),
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                Text(
                  DateFormatter.formatDate(state.flights[index].dateInitial),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w200),
                )
              ],
            ),
            const Icon(Icons.arrow_forward, color: AppColors.primaryColor),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${DateFormatter.formatTime(state.flights[index].dateFinal)} ',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  const Text(
                    'Details',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

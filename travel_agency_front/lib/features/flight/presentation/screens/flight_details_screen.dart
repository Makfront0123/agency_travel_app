import 'package:flutter/material.dart';
import 'package:travel_agency_front/features/auth/presentation/widgets/auth_button.dart';
import 'package:travel_agency_front/features/flight/presentation/widget/custom_appbar.dart';
import 'package:travel_agency_front/features/home/domain/entities/flight.dart';

class FlightDetailsScreen extends StatelessWidget {
  const FlightDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final flight = ModalRoute.of(context)!.settings.arguments as Flight;

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Flight Details',
        showUser: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildFlightDetailsContainer(context, flight),
            const Spacer(),
            AuthButton(
              text: 'Book Now',
              onTap: () {
                Navigator.pushNamed(context, '/reservation', arguments: flight);
              },
            )
          ],
        ),
      ),
    );
  }

  Container _buildFlightDetailsContainer(BuildContext context, Flight flight) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.39,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white54,
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            color: Colors.black.withOpacity(0.3),
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(flight.airline, style: const TextStyle(fontSize: 20)),
          Text('Flight Number: ${flight.flightNumber}',
              style: const TextStyle(fontSize: 20)),
          Text('Duration: ${flight.duration}',
              style: const TextStyle(fontSize: 20)),
          Text('Origin: ${flight.originId}',
              style: const TextStyle(fontSize: 20)),
          Text('Destination: ${flight.destinationId}',
              style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 40),
          Text(
            'Price: \$${flight.price}',
          ),
          Text('Seats Available: ${flight.seatsAvailable}'),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_agency_front/core/theme/app_colors.dart';
import 'package:travel_agency_front/features/auth/presentation/widgets/auth_button.dart';
import 'package:travel_agency_front/features/auth/services/storage_services.dart';
import 'package:travel_agency_front/features/flight/presentation/widget/custom_appbar.dart';
import 'package:travel_agency_front/features/home/domain/entities/flight.dart';
import 'package:travel_agency_front/features/reservation/data/models/passenger_model.dart';
import 'package:travel_agency_front/features/reservation/data/models/reservation_request_model.dart';
import 'package:travel_agency_front/features/reservation/presentation/blocs/reservation_bloc.dart';
import 'package:travel_agency_front/features/reservation/presentation/blocs/reservation_event.dart';
import 'package:travel_agency_front/features/reservation/presentation/blocs/reservation_state.dart';
import 'package:travel_agency_front/features/reservation/presentation/widget/entity_form_content.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({super.key, this.flight});
  final Flight? flight;

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  final adultController = TextEditingController();
  final childController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final flightArg = ModalRoute.of(context)!.settings.arguments as Flight?;
    if (flightArg != null && widget.flight == null) {
      setState(() {
        // Guardar localmente o usar directamente
        _flight = flightArg;
      });
    }
  }

  Flight? _flight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Reservation',
        showUser: true,
      ),
      body: BlocConsumer<ReservationBloc, ReservationState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is ReservationLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ReservationSuccess || state is ReservationInitial) {
              context.watch<ReservationBloc>().state is ReservationSuccess
                  ? (context.watch<ReservationBloc>().state
                          as ReservationSuccess)
                      .paymentMethod
                  : null;
            }

            final passengers =
                state is ReservationSuccess ? state.passengers : [];

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EntityFormContent(
                      name: 'Add Passenger',
                      inputTitle01: 'Name',
                      inputTitle02: 'Email',
                      controller02: childController,
                      controller01: adultController,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                      ),
                      onPressed: _addPassenger,
                      child: const Text(
                        'Add Passenger',
                        style: TextStyle(color: AppColors.secondaryColor),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Passenger List:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    ...passengers.map(
                      (p) => ListTile(
                        title: Text(p.fullName),
                        subtitle: Text(p.email),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            context
                                .read<ReservationBloc>()
                                .add(RemovePassenger(p));
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/payment');
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Payment Method',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.arrow_forward,
                            color: AppColors.primaryColor,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    AuthButton(
                      text: 'Continue',
                      onTap: _addReservation,
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }

  void _addPassenger() async {
    final token = await StorageService().getToken();
    if (token != null) {}
    final name = adultController.text;
    final email = childController.text;
    if (name.isNotEmpty && email.isNotEmpty) {
      context.read<ReservationBloc>().add(
            AddPassenger(
                PassengerModel(fullName: name, email: email), token ?? ''),
          );
      adultController.clear();
      childController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Complete all fields'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _addReservation() async {
    final token = await StorageService().getToken();

    final state = context.read<ReservationBloc>().state;
    if (state is ReservationSuccess && state.passengers.isNotEmpty) {
      context.read<ReservationBloc>().add(
            SubmitReservation(
              request: ReservationRequestModel(
                flightId: _flight?.id ??
                    0, // si 0 tiene sentido como valor por defecto

                passengers: state.passengers,
                paymentMethod: state.paymentMethod,
              ),
              token: token ?? '',
            ),
          );

      Navigator.pushNamed(
        context,
        '/reservationConfirm',
        arguments: {
          'paymentMethod': state.paymentMethod ?? 'None',
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please add at least one passenger'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

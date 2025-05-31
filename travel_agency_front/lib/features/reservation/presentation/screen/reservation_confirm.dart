import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_agency_front/core/theme/app_colors.dart';
import 'package:travel_agency_front/core/utils/date_formatted.dart';
import 'package:travel_agency_front/features/auth/presentation/widgets/auth_button.dart';
import 'package:travel_agency_front/features/auth/services/storage_services.dart';
import 'package:travel_agency_front/features/flight/presentation/widget/custom_appbar.dart';
import 'package:travel_agency_front/features/reservation/domain/entities/reservation.dart';
import 'package:travel_agency_front/features/reservation/presentation/blocs/reservation_bloc.dart';
import 'package:travel_agency_front/features/reservation/presentation/blocs/reservation_event.dart';
import 'package:travel_agency_front/features/reservation/presentation/blocs/reservation_state.dart';

// ReservationConfirmScreen.dart
class ReservationConfirmScreen extends StatelessWidget {
  const ReservationConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReservationBloc, ReservationState>(
      listener: (context, state) {
        if (state is PaymentInProgress) {
          showDialog(
            context: context,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        } else if (state is PaymentSuccess) {
          Navigator.pop(context); // cerrar loading
          Navigator.pushReplacementNamed(context, "/paymentSuccess");
        } else if (state is PaymentFailed) {
          Navigator.pop(context); // cerrar loading
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        appBar: const CustomAppBar(
          title: 'Reservation Confirm',
          showUser: true,
        ),
        body: BlocBuilder<ReservationBloc, ReservationState>(
          builder: (context, state) {
            if (state is ReservationSuccess) {
              final reservation = state.reservation;
              final dateInitial =
                  DateFormatter.formatTime(reservation!.dateInitial!);
              final dateFinal =
                  DateFormatter.formatTime(reservation.dateFinal!);

              return Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          dateFinal,
                          style: const TextStyle(fontSize: 20),
                        ),
                        const Icon(Icons.linear_scale,
                            color: AppColors.primaryColor),
                        Text(
                          dateInitial,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildDetailsTop(reservation, state),
                    const SizedBox(height: 30),
                    _buildDetailsBottom(reservation, state),
                    const Spacer(),
                    AuthButton(
                      text: 'Confirm and Pay',
                      onTap: () async {
                        final bloc = context.read<ReservationBloc>();
                        final paymentMethod = state.paymentMethod;
                        final token = await StorageService().getToken();

                        if (paymentMethod == 'Stripe') {
                          bloc.add(ConfirmAndPayWithStripe(
                            reservation,
                            state.passengers,
                            paymentMethod ?? '',
                            token ?? '',
                          ));
                        } else if (paymentMethod == 'PayPal') {
                          bloc.add(
                            ConfirmAndPayWithPayPal(
                              reservation,
                              state.passengers,
                              paymentMethod ?? '',
                              token ?? '',
                            ),
                          );
                        }
                      },
                    )
                  ],
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Container _buildDetailsTop(
      Reservation reservation, ReservationSuccess state) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
            bottom: BorderSide(color: AppColors.lightTextColor, width: 1.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                reservation.originCity.toUpperCase(),
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const Icon(Icons.arrow_forward, color: AppColors.primaryColor),
              Text(
                reservation.destinationCity.toUpperCase(),
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              )
            ],
          ),
          const SizedBox(height: 20),
          const Text('Passengers',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ...state.passengers.map((p) {
            return ListTile(
              title: Text(
                p.fullName,
                style: const TextStyle(
                  fontSize: 18,
                  color: AppColors.primaryColor,
                ),
              ),
              subtitle: Text(p.email),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildDetailsBottom(
      Reservation reservation, ReservationSuccess state) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
            bottom: BorderSide(color: AppColors.lightTextColor, width: 1.8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Price',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text('\$${reservation.price.toString()}'),
        ],
      ),
    );
  }
}

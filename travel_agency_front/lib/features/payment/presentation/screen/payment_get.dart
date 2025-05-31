import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_agency_front/core/theme/app_colors.dart';
import 'package:travel_agency_front/features/auth/presentation/widgets/auth_container.dart';
import 'package:travel_agency_front/features/auth/services/storage_services.dart';
import 'package:travel_agency_front/features/payment/domain/entities/payment.dart';
import 'package:travel_agency_front/features/payment/presentation/blocs/payment_bloc.dart';
import 'package:travel_agency_front/features/payment/presentation/blocs/payment_event.dart';
import 'package:travel_agency_front/features/payment/presentation/blocs/payment_state.dart';

class PaymentGet extends StatefulWidget {
  const PaymentGet({super.key});

  @override
  State<PaymentGet> createState() => _PaymentGetState();
}

class _PaymentGetState extends State<PaymentGet> {
  @override
  void initState() {
    super.initState();
    getPaymentsUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PaymentBloc, PaymentState>(
        builder: (context, state) {
          if (state is PaymentLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PaymentLoaded) {
            return _buildPaymentList(state);
          } else if (state is PaymentFailureState) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('No data'));
        },
      ),
    );
  }

  Widget _buildPaymentList(PaymentLoaded state) {
    if (state.payments.isEmpty) {
      return const Center(
        child: Text(
          'No tienes pagos registrados.',
          style: TextStyle(fontSize: 18),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        separatorBuilder: (context, index) => const SizedBox(
          height: 25,
        ),
        itemCount: state.payments.length,
        itemBuilder: (context, index) {
          final payment = state.payments[index];
          return _buildPaymentCard(payment);
        },
      ),
    );
  }

  Widget _buildPaymentCard(Payment payment) {
    return AuthContainer(
        color: AppColors.primaryColor,
        height: 200,
        padding: const EdgeInsets.only(left: 20),
        width: MediaQuery.of(context).size.width * .8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total: \$${payment.amount}',
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
            Text(
              'Mode: ${payment.paymentMode}\nStatus: ${payment.status}',
              style: const TextStyle(fontSize: 15, color: Colors.white),
            ),
            Text(
              payment.paymentDate.toString(),
              style: const TextStyle(fontSize: 15, color: Colors.white),
            ),
          ],
        ));
  }

  void getPaymentsUser() async {
    final token = await StorageService().getToken();
    if (mounted) {
      context.read<PaymentBloc>().add(GetPaymentEvent(token ?? ''));
    }
  }
}

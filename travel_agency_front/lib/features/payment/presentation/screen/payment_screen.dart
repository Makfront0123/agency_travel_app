import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_agency_front/features/auth/presentation/widgets/auth_button.dart';
import 'package:travel_agency_front/features/reservation/presentation/blocs/reservation_bloc.dart';
import 'package:travel_agency_front/features/reservation/presentation/blocs/reservation_event.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? selectedMethod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Payment Method')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            ListTile(
              title: const Text('Stripe'),
              leading: Radio<String>(
                value: 'Stripe',
                groupValue: selectedMethod,
                onChanged: (value) {
                  setState(() {
                    selectedMethod = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('PayPal'),
              leading: Radio<String>(
                value: 'PayPal',
                groupValue: selectedMethod,
                onChanged: (value) {
                  setState(() {
                    selectedMethod = value;
                  });
                },
              ),
            ),
            const Spacer(),
            AuthButton(
              text: 'Continue',
              onTap: () {
                if (selectedMethod != null) {
                  context
                      .read<ReservationBloc>()
                      .add(SelectPaymentMethod(selectedMethod!));
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select a payment method'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

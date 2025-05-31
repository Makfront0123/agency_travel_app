import 'package:flutter/material.dart';
import 'package:travel_agency_front/core/theme/app_colors.dart';
import 'package:travel_agency_front/features/auth/presentation/widgets/auth_button.dart';
import 'package:travel_agency_front/features/flight/presentation/widget/custom_appbar.dart';

class PaymentSuccess extends StatefulWidget {
  const PaymentSuccess({super.key});

  @override
  State<PaymentSuccess> createState() => _PaymentSuccessState();
}

class _PaymentSuccessState extends State<PaymentSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Success',
        showUser: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 80),
                child: Column(
                  children: [
                    Icon(Icons.check_circle_outline,
                        size: 200, color: Colors.green),
                    SizedBox(height: 20),
                    Text('Payment Successful', style: TextStyle(fontSize: 20)),
                    SizedBox(height: 20),
                    Text('Your Reservation has been confirmed',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                            color: AppColors.borderLightColor)),
                  ],
                ),
              ),
              const Spacer(),
              AuthButton(
                onTap: () {
                  Navigator.pushNamed(context, '/application');
                },
                text: 'Done',
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AuthContainer extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? color;

  const AuthContainer({
    super.key,
    required this.child,
    this.height,
    this.width,
    this.margin,
    this.padding, this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height??0,
      width: width??0,
      margin: margin?? EdgeInsets.zero,
      padding: padding?? EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color??Theme.of(context).primaryColor,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 1),
            spreadRadius: 1,
            blurRadius: 1,
            color: Colors.black.withOpacity(.2),
          )
        ],
      ),
      child: child,
    );
  }
}

import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  final double width;

  const LogoWidget({
    super.key,
    this.width = 170,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/logos/logoo.png",
      width: width,
      fit: BoxFit.contain,
    );
  }
}
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          Theme.of(context).brightness == Brightness.light
              ? 'assets/images/logo_light.png'
              : 'assets/images/logo_dark.png',
          scale: 4,
        ),
      ),
    );
  }
}

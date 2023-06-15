import 'package:flutter/material.dart';
import 'package:maos/pages/home.dart';
import 'package:maos/pages/news.dart';
import 'package:maos/pages/notification.dart';
import 'package:maos/screens/splash.dart';

void main() => runApp(const Maos());

class Maos extends StatelessWidget {
  const Maos({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomePage(),
        '/notif': (context) => const NotificationPage(),
        '/news': (context) => const NewsPage(),
      },
    );
  }
}

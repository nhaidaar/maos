import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maos/blocs/auth/auth_bloc.dart';
import 'package:maos/blocs/news/news_bloc.dart';
import 'package:maos/firebase_options.dart';
import 'package:maos/pages/home.dart';
import 'package:maos/pages/landing.dart';
import 'package:maos/pages/notification.dart';
import 'package:maos/repositories/auth_repository.dart';
import 'package:maos/screens/checker.dart';
import 'package:maos/screens/splash.dart';
import 'package:maos/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  runApp(const Maos());
}

class Maos extends StatelessWidget {
  const Maos({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              auth: RepositoryProvider.of<AuthRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => NewsBloc(),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(
            scaffoldBackgroundColor: whiteBackground,
            fontFamily: 'PlusJakartaSans',
          ),
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (context) => const SplashScreen(),
            '/checker': (context) => const Checker(),
            '/login': (context) => const LoginPage(),
            '/register': (context) => const RegisterPage(),
            '/uploadpp': (context) => const UploadProfilePicture(),
            '/home': (context) => const HomePage(),
            '/notif': (context) => const NotificationPage(),
          },
        ),
      ),
    );
  }
}

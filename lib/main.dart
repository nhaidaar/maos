import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maos/blocs/auth/auth_bloc.dart';
import 'package:maos/blocs/news/news_bloc.dart';
import 'package:maos/firebase_options.dart';
import 'package:maos/repositories/auth_repository.dart';
import 'package:maos/screens/splash.dart';
import 'package:maos/shared/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
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
          title: 'maos - Daily News',
          theme: ThemeData(
            scaffoldBackgroundColor: whiteBackground,
            fontFamily: 'PlusJakartaSans',
            appBarTheme: const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.dark,
              ),
            ),
          ),
          home: const SplashScreen(),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/common/themes.dart';
import 'core/common/widgets/custom_snackbar.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/pages/auth_page.dart';
import 'features/home/presentation/pages/main_screen.dart';
import 'features/home/presentation/pages/splash_screen.dart';
import 'init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  runApp(const Maos());
}

class Maos extends StatelessWidget {
  const Maos({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => serviceLocator<AuthBloc>()..add(AuthCheckSession())),
      ],
      child: MaterialApp(
        title: 'maos',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        home: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthError) showSnackbar(context, message: state.message, isError: true);
          },
          builder: (context, state) {
            if (state is AuthInitial) {
              return SplashScreen();
            } else if (state is Authenticated) {
              return MainScreen();
            }
            return const AuthPage();
          },
        ),
      ),
    );
  }
}

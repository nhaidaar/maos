import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:maos/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository auth;
  AuthBloc({required this.auth}) : super(UnAuthenticated()) {
    on<AuthSignIn>((event, emit) async {
      emit(AuthLoading());
      try {
        await auth.userSignIn(event.email, event.password);
        emit(Authenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });
    on<AuthSignUp>((event, emit) async {
      emit(AuthLoading());
      try {
        await auth.userSignUp(event.email, event.password);
        emit(Authenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });
    on<AuthSignOut>((event, emit) async {
      emit(AuthLoading());
      await auth.userSignOut();
      emit(UnAuthenticated());
    });
  }
}

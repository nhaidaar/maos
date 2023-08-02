part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {}

class AuthLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

class UnAuthenticated extends AuthState {
  @override
  List<Object?> get props => [];
}

class Authenticated extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthError extends AuthState {
  final String e;
  AuthError(this.e);

  @override
  List<Object?> get props => [e];
}

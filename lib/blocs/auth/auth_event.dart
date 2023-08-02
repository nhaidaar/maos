part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthSignUp extends AuthEvent {
  final String email, password;
  AuthSignUp(this.email, this.password);
}

class AuthSignIn extends AuthEvent {
  final String email, password;
  AuthSignIn(this.email, this.password);
}

class AuthSignOut extends AuthEvent {}

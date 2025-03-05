part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

//..................................................... login event
class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  LoginRequested({required this.email, required this.password});

  @override
  List<Object> get props => [super.props, email, password];
}

//..................................................... register event
class RegisterRequested extends AuthEvent {
  final String fullName;
  final String email;
  final String password;

  RegisterRequested({
    required this.fullName,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [super.props, fullName, email, password];
}

//..................................................... forgot password event
class ForgotPasswordRequested extends AuthEvent {
  final String email;

  ForgotPasswordRequested({required this.email});

  @override
  List<Object> get props => [super.props, email];
}

//..................................................... logout event
class LogoutRequested extends AuthEvent {}

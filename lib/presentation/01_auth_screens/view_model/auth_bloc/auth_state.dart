part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

//................................................ login states
final class LoginLoading extends AuthState {}

final class LoginSuccess extends AuthState {
  final AuthenticationEntity authObj;

  const LoginSuccess(this.authObj);

  @override
  List<Object> get props => [super.props, authObj];
}

final class LoginError extends AuthState {
  final String errMessage;

  const LoginError(this.errMessage);

  @override
  List<Object> get props => [super.props, errMessage];
}

//................................................ register states
final class RegisterLoading extends AuthState {}

final class RegisterSuccess extends AuthState {}

final class RegisterError extends AuthState {
  final String errMessage;

  const RegisterError(this.errMessage);

  @override
  List<Object> get props => [super.props, errMessage];
}

//................................................ forgot password states
final class ForgotPasswordLoading extends AuthState {}

final class ForgotPasswordSuccess extends AuthState {}

final class ForgotPasswordError extends AuthState {
  final String errMessage;

  const ForgotPasswordError(this.errMessage);

  @override
  List<Object> get props => [super.props, errMessage];
}

//................................................ logout states
final class LogoutLoading extends AuthState {}

final class LogoutSuccess extends AuthState {}

final class LogoutError extends AuthState {
  final String errMessage;

  const LogoutError(this.errMessage);

  @override
  List<Object> get props => [super.props, errMessage];
}

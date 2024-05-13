part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

final class LoginUser extends UserEvent {
  const LoginUser({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

final class RegisterUser extends UserEvent {
  const RegisterUser(
      {required this.username, required this.email, required this.password});

  final String username;
  final String email;
  final String password;

  @override
  List<Object> get props => [username, email, password];
}

final class ForgotPasswordUser extends UserEvent {
  const ForgotPasswordUser(
      {required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

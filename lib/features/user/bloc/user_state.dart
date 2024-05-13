part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();
  
  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

final class UserUnknown extends UserState {}

final class UserAuthenticated extends UserState {}

final class UserUnauthenticated extends UserState {}

final class UserRegistered extends UserState {}

final class UserUnregistered extends UserState {}

final class UserOtpCodeSent extends UserState {}

final class UserOtpCodeNotSent extends UserState {}

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:matule/features/user/data/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(UserInitial()) {
    on<LoginUser>(_login);
    on<RegisterUser>(_register);
    on<ForgotPasswordUser>(_forgotPassword);
  }

  final UserRepository _userRepository;

  Future<void> _login(event, emit) async {
    emit(UserUnknown());
    try {
      await _userRepository.login(event.email, event.password);
      emit(UserAuthenticated());
    } catch (e) {
      emit(UserUnauthenticated());
    }
  }

  Future<void> _register(event, emit) async {
    emit(UserUnknown());
    try {
      await _userRepository.register(event.username, event.email, event.password);
      emit(UserRegistered());
    } catch (e) {
      emit(UserUnregistered());
    }
  }

  Future<void> _forgotPassword(event, emit) async {
    emit(UserUnknown());
    try {
      await _userRepository.forgotPassword(event.email);
      emit(UserOtpCodeSent());
    } catch (e) {
      emit(UserOtpCodeNotSent());
    }
  }
}

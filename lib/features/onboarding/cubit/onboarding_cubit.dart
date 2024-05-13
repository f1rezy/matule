import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matule/features/onboarding/data/onboarding_repository.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit({required OnboardingRepository onboardingRepository})
      : _onboardingRepository = onboardingRepository,
        super(const OnboardingState(0)) {
          _checkOnboardingInitialPage();
        }

  final OnboardingRepository _onboardingRepository;

  Future<void> setOnboardingInitialPage(int initialPage) async {
    emit(OnboardingState(initialPage));
    await _onboardingRepository.setInitialPage(initialPage);
  }

  void _checkOnboardingInitialPage() {
    final initialPage = _onboardingRepository.getInitialPage();
    emit(OnboardingState(initialPage));
  }
}

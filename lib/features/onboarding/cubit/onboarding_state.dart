// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'onboarding_cubit.dart';

class OnboardingState extends Equatable {
  const OnboardingState(
    this.initialPage,
  );

  final int initialPage;

  @override
  List<Object> get props => [initialPage];
}

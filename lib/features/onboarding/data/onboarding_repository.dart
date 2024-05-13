// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingRepository {
  OnboardingRepository({
    required this.prefs,
  });
  
  final SharedPreferences prefs;

  static const _initialPageKey = 'initial_page';

  int getInitialPage() {
    final initialPage = prefs.getInt(_initialPageKey);
    return initialPage ?? 0;
  }

  Future<void> setInitialPage(int initialPage) async {
    await prefs.setInt(_initialPageKey, initialPage);
  }
}

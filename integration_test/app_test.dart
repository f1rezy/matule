import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'test_main.dart' as test_app;

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Login test', (WidgetTester tester) async {
    test_app.main();
    await tester.pumpAndSettle();
    expect(find.text('Привет!'), findsWidgets);

    await tester.enterText(find.byType(TextField).first, 'bad_email');
    await tester.pumpAndSettle();
    expect(find.text('Плохой email'), findsWidgets);

    await tester.enterText(find.byType(TextField).first, 'danil.fire@bk.ru');
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).last, 'qwerty');
    await tester.pumpAndSettle();

    await tester.tap(find.text('Войти'));

    await Future.delayed(const Duration(seconds: 5));
    await tester.pumpAndSettle();

    expect(find.text('Ошибка авторизации'), findsWidgets);

    await tester.enterText(find.byType(TextField).last, '123456');
    await tester.pumpAndSettle();

    await tester.tap(find.text('Войти'));

    await Future.delayed(const Duration(seconds: 5));
    await tester.pumpAndSettle();

    expect(find.text('Привет!'), findsNothing);
  });
}

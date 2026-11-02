import 'package:flutter_test/flutter_test.dart';
import 'package:kitalk/main.dart';

void main() {
  testWidgets('onboarding offers sign up and log in', (tester) async {
    await tester.pumpWidget(const KiTalkApp());
    expect(find.text('Sign up'), findsOneWidget);
    expect(find.text('Log in'), findsOneWidget);
  });
}

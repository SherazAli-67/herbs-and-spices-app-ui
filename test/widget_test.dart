import 'package:flutter_test/flutter_test.dart';
import 'package:herbs_and_spices_app/constants/string_const.dart';
import 'package:herbs_and_spices_app/main.dart';

void main() {
  testWidgets('Welcome screen shows onboarding headline', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.textContaining(StringConst.onboardingHeadlineBlast), findsOneWidget);
  });
}

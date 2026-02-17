import 'package:flutter_test/flutter_test.dart';
import 'package:ios/main.dart';

void main() {
  testWidgets('App builds and displays main layout', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the app builds without crashing.
    expect(find.byType(MyApp), findsOneWidget);
  });
}

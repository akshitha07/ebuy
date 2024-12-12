import 'package:ebuy/nav%20bar/Nav_bar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';


void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Full workflow: add, remove, and persist cart items', (WidgetTester tester) async {
    // await tester.pumpWidget(MyApp());

    // Add an item to the cart
    await tester.tap(find.text('Add to Cart')); // Simulate tapping "Add to Cart"
    await tester.pump();

    expect(find.text('Cart (1)'), findsOneWidget);

    // Remove the item
    await tester.tap(find.text('Remove')); // Simulate tapping "Remove"
    await tester.pump();

    expect(find.text('Cart (0)'), findsOneWidget);

    // Ensure cart persists after restarting app
    tester.binding.reassembleApplication();
    await tester.pumpAndSettle();

    expect(find.text('Cart (0)'), findsOneWidget); // Cart remains empty
  });
}

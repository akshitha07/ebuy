import 'package:ebuy/nav%20bar/cart.dart';
import 'package:ebuy/providers/cartprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  late CartProvider cartProvider;

  setUp(() {
    cartProvider = CartProvider();
  });

  Widget createWidgetForTesting(Widget child) {
    return ChangeNotifierProvider<CartProvider>.value(
      value: cartProvider,
      child: MaterialApp(home: child),
    );
  }

  testWidgets('Cart screen displays added items', (WidgetTester tester) async {
    cartProvider.addToCart(
      ProductProvider(
        title: 'Product 1',
        thumbnail: 'url1',
        description: 'Description 1',
        price: 10.0,
        discountPercentage: 5.0,
        rating: 4.5,
      ),
    );

    await tester.pumpWidget(createWidgetForTesting(CartScreen()));
    expect(find.text('Product 1'), findsOneWidget);
  });

  testWidgets('Cart screen shows empty message if no items', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(CartScreen()));
    expect(find.text('Your cart is empty'), findsOneWidget);
  });

  testWidgets('Adding items updates the cart screen', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(CartScreen()));

    cartProvider.addToCart(
      ProductProvider(
        title: 'Product 1',
        thumbnail: 'url1',
        description: 'Description 1',
        price: 10.0,
        discountPercentage: 5.0,
        rating: 4.5,
      ),
    );
    await tester.pump(); // Update the widget tree

    expect(find.text('Product 1'), findsOneWidget);
  });

  testWidgets('Removing items updates the cart screen', (WidgetTester tester) async {
    final product = ProductProvider(
      title: 'Product 1',
      thumbnail: 'url1',
      description: 'Description 1',
      price: 10.0,
      discountPercentage: 5.0,
      rating: 4.5,
    );
    cartProvider.addToCart(product);

    await tester.pumpWidget(createWidgetForTesting(CartScreen()));
    expect(find.text('Product 1'), findsOneWidget);

    cartProvider.removeFromCart(product);
    await tester.pump();

    expect(find.text('Product 1'), findsNothing);
  });

  testWidgets('Clear cart button removes all items', (WidgetTester tester) async {
    cartProvider.addToCart(
      ProductProvider(
        title: 'Product 1',
        thumbnail: 'url1',
        description: 'Description 1',
        price: 10.0,
        discountPercentage: 5.0,
        rating: 4.5,
      ),
    );

    await tester.pumpWidget(createWidgetForTesting(CartScreen()));
    expect(find.text('Product 1'), findsOneWidget);

    await tester.tap(find.text('Clear Cart'));
    await tester.pump();

    expect(find.text('Product 1'), findsNothing);
  });
}

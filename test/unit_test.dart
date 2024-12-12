import 'package:ebuy/providers/cartprovider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late CartProvider cartProvider;

  setUp(() {
    cartProvider = CartProvider();
  });

  test('Adding an item to the cart increases its size', () async {
    final product = ProductProvider(
      title: 'Product 1',
      thumbnail: 'url1',
      description: 'Description 1',
      price: 10.0,
      discountPercentage: 5.0,
      rating: 4.5,
    );
    await cartProvider.addToCart(product);

    expect(cartProvider.cartItems.length, 1);
    expect(cartProvider.cartItems[0].title, 'Product 1');
  });

  test('Removing an item from the cart decreases its size', () async {
    final product = ProductProvider(
      title: 'Product 1',
      thumbnail: 'url1',
      description: 'Description 1',
      price: 10.0,
      discountPercentage: 5.0,
      rating: 4.5,
    );
    await cartProvider.addToCart(product);
    await cartProvider.removeFromCart(product);

    expect(cartProvider.cartItems.isEmpty, true);
  });

  test('Clearing the cart empties it', () async {
    final product1 = ProductProvider(
      title: 'Product 1',
      thumbnail: 'url1',
      description: 'Description 1',
      price: 10.0,
      discountPercentage: 5.0,
      rating: 4.5,
    );
    final product2 = ProductProvider(
      title: 'Product 2',
      thumbnail: 'url2',
      description: 'Description 2',
      price: 20.0,
      discountPercentage: 10.0,
      rating: 4.0,
    );
    await cartProvider.addToCart(product1);
    await cartProvider.addToCart(product2);
    await cartProvider.clearCart();

    expect(cartProvider.cartItems.isEmpty, true);
  });

  test('Cart saves and restores data from shared_preferences', () async {
    SharedPreferences.setMockInitialValues({});
    final product = ProductProvider(
      title: 'Product 1',
      thumbnail: 'url1',
      description: 'Description 1',
      price: 10.0,
      discountPercentage: 5.0,
      rating: 4.5,
    );
    await cartProvider.addToCart(product);

    final restoredCartProvider = CartProvider();
    await restoredCartProvider.loadCartFromSharedPreferences();

    expect(restoredCartProvider.cartItems.length, 1);
    expect(restoredCartProvider.cartItems[0].title, 'Product 1');
  });

  test('Removing an item not in the cart does nothing', () async {
    final product = ProductProvider(
      title: 'Product 1',
      thumbnail: 'url1',
      description: 'Description 1',
      price: 10.0,
      discountPercentage: 5.0,
      rating: 4.5,
    );
    await cartProvider.removeFromCart(product);

    expect(cartProvider.cartItems.isEmpty, true);
  });
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductProvider {
  String title;
  String thumbnail;
  String description;
  double price;
  double discountPercentage;
  double rating;
  int quantity;

  ProductProvider({
    required this.title,
    required this.thumbnail,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    this.quantity = 1,
  });

  // Convert a product to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'thumbnail': thumbnail,
      'description': description,
      'price': price,
      'discountPercentage': discountPercentage,
      'rating': rating,
      'quantity': quantity,
    };
  }

  // Create a product from a JSON object
  factory ProductProvider.fromJson(Map<String, dynamic> json) {
    return ProductProvider(
      title: json['title'],
      thumbnail: json['thumbnail'],
      description: json['description'],
      price: json['price'],
      discountPercentage: json['discountPercentage'],
      rating: json['rating'],
      quantity: json['quantity'] ?? 1,
    );
  }
}

class CartProvider with ChangeNotifier {
  List<ProductProvider> _cartItems = [];

  List<ProductProvider> get cartItems => _cartItems;

  // Add or update item in the cart
  Future<void> addToCart(ProductProvider product) async {
    int index = _cartItems.indexWhere((item) => item.title == product.title);
    if (index >= 0) {
      _cartItems[index].quantity += product.quantity;
    } else {
      _cartItems.add(product);
    }
    await saveCartToSharedPreferences();
    notifyListeners();
  }

  // Remove item from the cart
  Future<void> removeFromCart(ProductProvider product) async {
    _cartItems.removeWhere((item) => item.title == product.title);
    await saveCartToSharedPreferences();
    notifyListeners();
  }

  // Update product quantity
  Future<void> updateProductQuantity(String title, int quantity) async {
    int index = _cartItems.indexWhere((item) => item.title == title);
    if (index >= 0) {
      if (quantity > 0) {
        _cartItems[index].quantity = quantity;
      } else {
        _cartItems.removeAt(index);
      }
      await saveCartToSharedPreferences();
      notifyListeners();
    }
  }

  // Clear all items in the cart
  Future<void> clearCart() async {
    _cartItems.clear();
    await saveCartToSharedPreferences();
    notifyListeners();
  }

  // Save cart items to shared preferences
  Future<void> saveCartToSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = _cartItems.map((item) => item.toJson()).toList();
    prefs.setString('cart', jsonEncode(cartData));
  }

  // Load cart items from shared preferences
  Future<void> loadCartFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = prefs.getString('cart');
    if (cartData != null) {
      final List<dynamic> decodedData = jsonDecode(cartData);
      _cartItems =
          decodedData.map((item) => ProductProvider.fromJson(item)).toList();
      notifyListeners();
    }
  }
}

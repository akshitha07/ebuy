//import 'package:ebuy/apicalling/modelclass.dart';
//import 'package:ebuy/apicalling/tab1.dart';
//import 'package:flutter/material.dart';

// class ProductProvider extends ChangeNotifier {
//   List<ProductElement>? _products = [];

//   List<ProductElement>? get products => _products;

//   void initializeData(List<ProductElement> data) {
//     _products = data;
//     notifyListeners();
//   }

//   void addToCart(ProductElement product) {
//   _products!.add(product);
//   notifyListeners();
//   print("item added");
//   print(_products);
// }

//   List<Map<String, dynamic>> getProductData() {
//     return _products?.map((product) {
//       return {
//         'image': product.thumbnail,
//         'title': product.title,
//         'price': product.price,
//       };
//     }).toList() ?? [];
//   }
// }
/*
class ProductProvider extends ChangeNotifier {
  List<ProductItem> _products = [];

  List<ProductItem> get products => _products;

  void initializeData(List<ProductItem> data) {
    _products = data;
    notifyListeners();
  }

  void addToCart(ProductItem product) {
    _products.add(product);
    notifyListeners();
    print("Item added to cart: ${product.title}");
  }

  List<Map<String, dynamic>> getProductData() {
    return _products.map((product) {
      return {
        'image': product.title,
        'title': product.title,
        'price': product.price,
      };
    }).toList();
  }
}*/


import 'package:flutter/material.dart';

class ProductProvider {
  String title;
  String thumbnail;
  String description;
  double price;
  double discountPercentage;
 double rating;

  ProductProvider({
    required this.title,
    required this.thumbnail,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
  });
}

class CartProvider with ChangeNotifier {
  List<ProductProvider> _cartItems = [];

  List<ProductProvider> get cartItems => _cartItems;

  void addToCart(ProductProvider product, {required int quantity}) {
    _cartItems.add(product);
    notifyListeners();
  }

  void removeFromCart(ProductProvider product) {
    _cartItems.remove(product);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}


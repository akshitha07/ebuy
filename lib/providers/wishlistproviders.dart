import 'package:flutter/material.dart';

class Products {
  String title;
  String thumbnail;
  String description;
  double price;
  double discountPercentage;
 double rating;

  Products({
    required this.title,
    required this.thumbnail,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
  });
}

class WishlistProvider with ChangeNotifier {
  List<Products> _wishlistItems = [];

  List<Products> get wishlistItems => _wishlistItems;

  void addToWishlist(Products product) {
    _wishlistItems.add(product);
    notifyListeners();
  }

  void removeFromWishlist(Products product) {
    _wishlistItems.remove(product);
    notifyListeners();
  }

  void clearWishlist() {
    _wishlistItems.clear();
    notifyListeners();
  }
}


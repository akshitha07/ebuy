import 'package:ebuy/nav%20bar/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cartprovider.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    int quantity = cartProvider.cartItems.firstWhere(
      (item) => item.title == product.title,
      orElse: () => ProductProvider(
        title: product.title,
        thumbnail: product.imageurl,
        description: product.description,
        price: product.price,
        discountPercentage: 0.0,
        rating: 0.0,
      ),
    ).quantity ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.width * 0.6,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(product.imageurl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              product.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Price: ₹${product.price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Text(
              product.description,
              style: const TextStyle(fontSize: 16),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    if (quantity > 1) {
                      cartProvider.updateProductQuantity(product.title, quantity - 1);
                    } else {
                      cartProvider.removeFromCart(
                        ProductProvider(
                          title: product.title,
                          thumbnail: product.imageurl,
                          description: product.description,
                          price: product.price,
                          discountPercentage: 0.0,
                          rating: 0.0,
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.remove),
                ),
                Text(
                  quantity.toString(),
                  style: const TextStyle(fontSize: 20),
                ),
                IconButton(
                  onPressed: () {
                    cartProvider.updateProductQuantity(product.title, quantity + 1);
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (quantity > 0) {
                    cartProvider.addToCart(ProductProvider(
                      title: product.title,
                      thumbnail: product.imageurl,
                      description: product.description,
                      price: product.price,
                      discountPercentage: 0.0,
                      rating: 0.0,
                    ));

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${product.title} updated in the cart!'),
                      ),
                    );
                  } else {
                    cartProvider.removeFromCart(
                      ProductProvider(
                        title: product.title,
                        thumbnail: product.imageurl,
                        description: product.description,
                        price: product.price,
                        discountPercentage: 0.0,
                        rating: 0.0,
                      ),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${product.title} removed from the cart!'),
                      ),
                    );
                  }
                },
                child: const Text('Update Cart'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

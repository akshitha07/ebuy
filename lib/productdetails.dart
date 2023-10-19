import 'package:ebuy/apicalling/api.dart';
import 'package:ebuy/providers/cartprovider.dart';
import 'package:ebuy/providers/wishlistproviders.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ProductDetailPage extends StatefulWidget {
  final ProductElement product;

  const ProductDetailPage({required this.product});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int selectedQuantity = 1;
  Color _iconColor = Colors.black;
  ProductProvider convertProductElementToProductProvider(ProductElement productElement) {
    return ProductProvider(
      title: productElement.title ?? '',
      thumbnail:  productElement.thumbnail??'',
      description: productElement.description ?? '',
      price:  0.0,
      discountPercentage: 0.0,
      rating: 0.0,
    );
  }

  Products convertProductElementToProducts(ProductElement productElement) {
    return Products(
      title: productElement.title ?? '',
      thumbnail:  productElement.thumbnail??'',
      description: productElement.description ?? '',
      price:  0.0,
      discountPercentage: 0.0,
      rating: 0.0,
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Product Detail',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Center(
              child: Image.network(
                widget.product.images![0],
                height: 350,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    widget.product.title ?? '',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text('Price: ${widget.product.price ?? 0}',
                  style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text('Brand: ${widget.product.brand ?? ''}',
                  style: const TextStyle(color: Colors.black)),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text('Category: ${widget.product.category ?? ''}',
                  style: const TextStyle(color: Colors.black)),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                  'Description: ${widget.product.description ?? ''}',
                  style: const TextStyle(color: Colors.black)),
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                width: 500,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            _iconColor = Colors.red; 
                          });
                          Products products = convertProductElementToProducts(widget.product);
                          Provider.of<WishlistProvider>(context, listen: false).addToWishlist(products);
                        },
                        icon: Icon(
                          Icons.favorite_rounded,
                          color: _iconColor, 
                        ),
                        label: const Text(
                          "Wishlist",
                          style: TextStyle(color: Colors.black),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side:
                                const BorderSide(color: Colors.black87, width: 1.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.share, color: Colors.black),
                        label: const Text("Share",
                            style: TextStyle(color: Colors.black)),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side:
                                const BorderSide(color: Colors.black87, width: 1.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    DecoratedBox(
                        decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black87, width: 1.0),
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton<int>(
                      value: selectedQuantity,
                      items: List.generate(5, (index) => index + 1)
                      .map((quantity) => DropdownMenuItem<int>(
                      value: quantity,
                      child: Text('$quantity'),
                     ))
                      .toList(),
                      onChanged: (value) {
                      setState(() {
                      selectedQuantity = value!;
                     });
                   },
                 ),
               ),
             )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 88.0),
                child: Row(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            ProductProvider productProvider = convertProductElementToProductProvider(widget.product);
                            Provider.of<CartProvider>(context, listen: false).addToCart(productProvider, quantity: selectedQuantity);
                          },
                          child: const Text('Add to Cart',
                              style: TextStyle(color: Colors.black)),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                side:
                                    const BorderSide(color: Colors.black87, width: 1.0),
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('Buy Now',
                              style: TextStyle(color: Colors.black)),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                side:
                                    const BorderSide(color: Colors.black87, width: 1.0),
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
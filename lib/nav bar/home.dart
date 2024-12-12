import 'package:ebuy/productdetails.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// Product Model
class Product {
  final String title;
  final double price;
  final String description;
  final String imageurl;

  Product({
    required this.title,
    required this.price,
    required this.description,
    required this.imageurl,
  });

  // Create a Product object from a JSON map
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      title: json['title'] ?? 'No Title',
      price: (json['price'] ?? 0).toDouble(),
      description: json['description'] ?? 'No Description',
      imageurl:
          json['image'] ?? 'https://via.placeholder.com/150', // Default image
    );
  }

  // Create a list of Product objects from a JSON list
  static List<Product> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Product.fromJson(json)).toList();
  }
}

// Product Screen
class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<Product> productResponse = [];
  bool isLoading = false;

  // Fetch product data from the API
  Future<void> _productData() async {
    setState(() {
      isLoading = true;
    });
    try {
      String url = "https://fakestoreapi.com/products";
      var res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(res.body);
        setState(() {
          productResponse = Product.fromJsonList(jsonList);
        });
      } else {
        print("Failed to load products. Status code: ${res.statusCode}");
      }
    } catch (e) {
      print(e.toString());
      print("Error occurred while fetching products.");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _productData();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Trending Deals',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : productResponse.isEmpty
              ? Center(child: Text('No products found.'))
              : ListView.builder(
                  itemCount: productResponse.length,
                  itemBuilder: (context, index) {
                    final product = productResponse[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailScreen(product: product),
                          ),
                        );
                      },
                      child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      width: 1, color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(1, 2),
                                        color: Colors.grey.shade200,
                                        spreadRadius: 2,
                                        blurRadius: 3)
                                  ]),
                              child: Row(
                                children: [
                                  Container(
                                    width: width * 0.4,
                                    height: width * 0.4,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Stack(
                                      alignment: AlignmentDirectional.topStart,
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.all(15),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                image: DecorationImage(
                                                  image: product
                                                          .imageurl.isNotEmpty
                                                      ? NetworkImage(
                                                          product.imageurl)
                                                      : const NetworkImage(
                                                          'https://via.placeholder.com/150'),
                                                  fit: BoxFit.fitHeight,
                                                ),
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: width * 0.4,
                                    // height: width * 0.25,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 5),
                                        Text(
                                          product.title,
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.040,
                                              color: Colors.black,
                                              fontFamily: "Quicksand",
                                              fontWeight: FontWeight.w900),
                                        ),
                                        Text(
                                          "₹${product.price.toStringAsFixed(2)}')",
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.032,
                                              color: Colors.grey.shade600,
                                              fontFamily: "Quicksand",
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ))),
                    );
                  },
                ),
    );
  }
}

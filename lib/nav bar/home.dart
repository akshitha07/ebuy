import 'package:ebuy/account.dart';
import 'package:ebuy/apicalling/api.dart';
import 'package:ebuy/productdetails.dart';
import 'package:ebuy/main.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Apicalls extends StatefulWidget {
  const Apicalls({super.key});

  @override
  State<Apicalls> createState() => _ApicallsState();
}

class _ApicallsState extends State<Apicalls> {
  Product? productResponse;

  @override
  void initState() {
    super.initState();
    _productData();
  }

  Future<void> _productData() async {
    try {
      String url = "https://dummyjson.com/products";
      var res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        // print(res.body);
        setState(() {
          productResponse = Product.fromJson(json.decode(res.body));
        });
      }
    } catch (e) {
      print(e.toString());
      print("erorr");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Ebuy',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            color: Colors.black,
            onPressed: () {},
          ),
        ],
        iconTheme: const IconThemeData(
          color: Colors.black, 
        ),
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 15),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[200],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search...',
                  icon: Icon(Icons.search),
                  suffixIcon: Icon(Icons.qr_code),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildProductGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildProductGrid() {
    final Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: size.width<600?2:4,
          childAspectRatio: size.width < 600 ? 1 : 1.3,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
        ),
        itemCount: productResponse?.products?.length ?? 0,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailPage(
                    product: productResponse?.products?[index] ?? ProductElement(),  
                  ),
                ),
              );
            },
            child: Card(
              color: Theme.of(context).colorScheme.surfaceVariant,
              margin: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    "${productResponse?.products?[index]?.images?[0] ?? ''}",
                    height: 50
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            "${productResponse?.products?[index]?.title ?? ''}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        // Center(child: Text('price: ${productResponse?.products?[index]?.price ?? ''}')),
                        Center(child: Text('Brand: "${productResponse?.products?[index]?.brand ?? ''}"')),
                        Center(child: Text('category: ${productResponse?.products?[index]?.category ?? ''}')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text("Poojitha"),
            accountEmail: Text("motapotulapoojitha@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.black26,
              radius: 50,
              backgroundImage: NetworkImage(
                'https://static.vecteezy.com/system/resources/thumbnails/009/734/564/small/default-avatar-profile-icon-of-social-media-user-vector.jpg',
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Account"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Account()),
              );
            },
          ),
          const ListTile(
            leading: Icon(Icons.location_searching_rounded),
            title: Text("Track"),
          ),
          const ListTile(
            leading: Icon(Icons.card_giftcard),
            title: Text("Orders"),
          ),
          const ListTile(
            leading: Icon(Icons.circle_rounded),
            iconColor: Colors.yellow,
            title: Text("Coins"),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("LogOut"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Splash()),
              );
            },
          ),
        ],
      ),
    );
  }
}
/*
class Product {
  List<ProductItem>? products;

  Product({this.products});

  factory Product.fromJson(Map<String, dynamic> json) {
    List<dynamic> productList = json['products'];
    List<ProductItem> productsList = productList
        .map((e) => ProductItem.fromJson(e as Map<String, dynamic>))
        .toList();

    return Product(products: productsList);
  }
}

class ProductItem {
  String? title;
  double? price;
  String? brand;
  String? category;
  String? description;
  String? rating;
  List<String>? images;

  ProductItem({this.title, this.price, this.brand, this.images, this.category, this.description, this.rating});

  factory ProductItem.fromJson(Map<String, dynamic> json) {
    List<dynamic> imageList = json['images'];
    List<String> imagesList = imageList.map((e) => e.toString()).toList();

    return ProductItem(
      title: json['title'],
      price: json['price']?.toDouble(),
      brand: json['brand'],
      rating: json['rating']?.toDouble(),
      // rating: json['rating'],
      category: json['category'],
      description: json['description'],
      images: imagesList,
    );
  }
}*/

import 'package:ebuy/account.dart';
import 'package:ebuy/providers/cartprovider.dart';
import 'package:ebuy/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<ProductProvider> cartItems = Provider.of<CartProvider>(context).cartItems;

    return Scaffold(
      
      body: cartItems.isEmpty
          ? Center(
              child: Text('Your cart is empty.'),
            )
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3, // Add elevation for a card-like appearance
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: Image.network(cartItems[index].thumbnail),
                    title: Text(cartItems[index].title),
                    subtitle:
                        Text('\$${cartItems[index].price.toStringAsFixed(2)}'),
                    trailing: IconButton(
                      icon: Icon(Icons.remove_shopping_cart),
                      onPressed: () {
                        Provider.of<CartProvider>(context, listen: false)
                            .removeFromCart(cartItems[index]);
                      },
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
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => Account()),
              // );
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
                MaterialPageRoute(builder: (context) => MyApp()),
              );
            },
          ),
        ],
      ),
    );
  }
}

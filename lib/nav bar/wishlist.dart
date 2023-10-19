import 'package:ebuy/account.dart';
import 'package:ebuy/main.dart';
import 'package:ebuy/providers/wishlistproviders.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wishlist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Products> wishlistItems = Provider.of<WishlistProvider>(context).wishlistItems;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Wishlist',
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
      body: wishlistItems.isEmpty
          ? Center(
              child: Text('Your Wishlist is empty.'),
            )
          : ListView.builder(
              itemCount: wishlistItems.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3, // Add elevation for a card-like appearance
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: Image.network(wishlistItems[index].thumbnail),
                    title: Text(wishlistItems[index].title),
                    subtitle:
                        Text('\$${wishlistItems[index].price.toStringAsFixed(2)}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        Provider.of<WishlistProvider>(context, listen: false)
                            .removeFromWishlist(wishlistItems[index]);
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

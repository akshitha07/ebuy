import 'dart:async';
import 'package:ebuy/providers/cartprovider.dart';
import 'package:ebuy/providers/wishlistproviders.dart';
import 'package:ebuy/nav%20bar/homescreen.dart';
import 'package:ebuy/authentication/welcome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => WishlistProvider()),
      ],
      child: Splash(),
    ),
    );
}


class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState() {
    super.initState();
    Timer( 
      Duration(seconds: 5),
      () => Navigator.pushReplacement(
        context as BuildContext,
        MaterialPageRoute(
          builder: (context) => Welcome(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Image(
                  width: 450,
                  image: NetworkImage(
                      'https://scontent.fhyd7-1.fna.fbcdn.net/v/t1.18169-9/14591852_1830686733811192_8657596699657526717_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=CedUG6Nmhe0AX9gO_bL&_nc_ht=scontent.fhyd7-1.fna&oh=00_AfBTJzGSmcu98RkjEKDiJ-0pREAPX6xFrSfSMP3INRKZyw&oe=65362E7A'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:ebuy/nav%20bar/homescreen.dart';
import 'package:ebuy/main.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Account());
}

class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Function to handle the onTap event of the Icon
  void handleIconTap() {
    // Add your desired action here
    //print('Icon tapped!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            handleIconTap();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyApp()),
            );
          }, // Assign the onTap function here
          child: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: Text(
          'Account',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Tab1(),
    );
  }
}



class Tab1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),

          ListTile(
            leading: Icon(Icons.person_outlined),
            title: Text('Profile'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
            },
          ),

          ListTile(
            leading: Icon(Icons.security_outlined),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Security'),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
            onTap: () {},
          ),

          ListTile(
            leading: Icon(Icons.location_city),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Address'),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
            onTap: () {},
          ),

          ListTile(
            leading: Icon(Icons.account_balance),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Bank Details'),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
            onTap: () {},
          ),

          ListTile(
            leading: Icon(Icons.payment),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Payment & Refund'),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
            onTap: () {},
          ),

          ListTile(
            leading: Icon(Icons.language),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Language'),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
            onTap: () {},
          ),

          ListTile(
            leading: Icon(Icons.rule_sharp),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Terms & Conditions'),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
            onTap: () {},
          ),

           ListTile(
            leading: Icon(Icons.business),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('About Us'),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
            onTap: () {},
          ),

          ListTile(
            leading: Icon(Icons.star_border_outlined),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Rate Us'),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
            onTap: () {},
          ),

          ListTile(
            leading: Icon(Icons.logout_rounded),
            onTap:() {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Splash()),
            );
            },
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Log Out'),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
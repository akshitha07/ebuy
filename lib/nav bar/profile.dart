import 'package:ebuy/authentication/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late String _name;
  late String _email;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    } catch (e) {
      print("Error logging out: $e");
    }
  }

  Future<void> _loadUserData() async {
    User? user = _auth.currentUser;

    if (user != null) {
      // Fetch user data from Firestore
      DocumentSnapshot snapshot =
          await _firestore.collection('users').doc(user.uid).get();

      if (snapshot.exists) {
        setState(() {
          _name = snapshot['name'] ?? 'No name available';
          _email = user.email ?? 'No email available';
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$_name',
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.06,
                              color: Colors.black,
                              fontFamily: "League-SemiBold",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            
                            "$_email",
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.040,
                              color: Colors.grey.shade600,
                              fontFamily: "League-Regular",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      // if (userData!['photoURL'].toString() == '')
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: CircleAvatar(
                            radius: MediaQuery.of(context).size.width * 0.08,
                            backgroundColor:
                                Colors.grey.shade200.withOpacity(0.8),
                            child: Icon(Icons.person_outline,
                                color: Colors.black,
                                size: MediaQuery.of(context).size.width * 0.1),
                          ),
                        ),
                      
                    ],
                  ),
                ),
                
                  const SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.2,
                    decoration: BoxDecoration(
                      color: const Color(0xffFFEFD4),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.55,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 15),
                                Text(
                                  "Gold Membership ",
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.06,
                                      color: const Color(0xff65668D),
                                      fontFamily: "Quicksand",
                                      fontWeight: FontWeight.w900),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  "Free Delivery for all orders",
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.035,
                                      color: const Color(0xff65668D),
                                      fontFamily: "Quicksand",
                                      fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  alignment: Alignment.center,
                                  width: 100,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      color: const Color(0xff65668D),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    "Know more",
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.040,
                                        color: Colors.white,
                                        fontFamily: "MonaSans",
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Lottie.asset(
                            "assests/gift_card.json",
                            fit: BoxFit.fitHeight,
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: MediaQuery.of(context).size.height * 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  const SizedBox(height: 20),
                  ReusableItemWidget(
                    onTap: () {},
                    icon: Ionicons.bag_check_outline,
                    text: "My Orders",
                  ),
                  const SizedBox(height: 20),
                  ReusableItemWidget(
                    onTap: () {},
                    icon: Ionicons.heart_outline,
                    text: "Favourites",
                  ),
                  const SizedBox(height: 20),
                  ReusableItemWidget(
                    onTap: () {
                      openAppSettings();
                    },
                    icon: Ionicons.settings_outline,
                    text: "Settings",
                  ),
                  const SizedBox(height: 20),
                  ReusableItemWidget(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => Accounts_page(),
                      //   ),
                      // );
                    },
                    icon: Ionicons.help_circle_outline,
                    text: "Help",
                  ),
                  const SizedBox(height: 20),
                  ReusableItemWidget(
                    onTap: () {
                      logout(context);
                    },
                    icon: Ionicons.log_out_outline,
                    text: "Logout",
                  ),
                ],
              ),
            ),
    );
  }
}

class ReusableItemWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function()? onTap;

  const ReusableItemWidget({
    Key? key,
    required this.icon,
    required this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 20),
            Text(
              text,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.06,
                color: Colors.black,
                fontFamily: "League-Regular",
                fontWeight: FontWeight.w500,
              ),
            ),
            const Expanded(
              child: SizedBox(),
            ),
            const Icon(
              Ionicons.chevron_forward_outline,
              size: 30,
            )
          ],
        ),
      ),
    );
  }
}

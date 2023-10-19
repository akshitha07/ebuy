import 'package:ebuy/authentication/login.dart';
import 'package:ebuy/authentication/signup.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Welcome());
}

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 90),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                  child: Container(
                    child: Image(
                      width: 250,
                      image: NetworkImage(
                          'https://scontent.fhyd7-1.fna.fbcdn.net/v/t1.18169-9/14591852_1830686733811192_8657596699657526717_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=CedUG6Nmhe0AX9gO_bL&_nc_ht=scontent.fhyd7-1.fna&oh=00_AfBTJzGSmcu98RkjEKDiJ-0pREAPX6xFrSfSMP3INRKZyw&oe=65362E7A'),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                AnimatedOpacity(
                  opacity: 1.0, 
                  duration: Duration(seconds: 5), 
                  child: Image(
                    width: 250,
                    image: NetworkImage(
                        'https://mma.prnewswire.com/media/1982584/Welcome_Homes_Logo.jpg?p=facebook'), 
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 90, right: 50),
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Register()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          fixedSize: Size(100, 30),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60),
                          ),
                        ),
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      SizedBox(width: 40),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Login()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            fixedSize: Size(100, 30),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(60),
                            ),
                          ),
                          child: Text(
                            'Log In',
                            style: TextStyle(color: Colors.black),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

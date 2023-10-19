import 'package:ebuy/nav%20bar/homescreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Login());
}

class Login extends StatelessWidget {
  const Login({Key? key});

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
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                  child: Container(
                    child: Image(
                      width: 200,
                      image: NetworkImage(
                          'https://scontent.fhyd7-1.fna.fbcdn.net/v/t1.18169-9/14591852_1830686733811192_8657596699657526717_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=CedUG6Nmhe0AX9gO_bL&_nc_ht=scontent.fhyd7-1.fna&oh=00_AfBTJzGSmcu98RkjEKDiJ-0pREAPX6xFrSfSMP3INRKZyw&oe=65362E7A'),
                    ),
                  ),
                ),
                Signin(), // Add the SignUp widget here
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Add form key
  bool _isPasswordVisible = false;

  Container buildInputBox(Widget child) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(10.0),
    ),
    padding: EdgeInsets.symmetric(horizontal: 14.0),
    margin: EdgeInsets.symmetric(vertical: 10.0),
    child: child,
  );
}
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey, // Assign the form key
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildInputBox(
               TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.mail),
                  labelText: 'Email',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 20.0),
            

 buildInputBox(
   TextFormField(
    decoration: InputDecoration(
      prefixIcon: Icon(Icons.lock),
      labelText: 'Password',
      suffixIcon: GestureDetector(
        onTap: () {
          setState(() {
            _isPasswordVisible = !_isPasswordVisible;
          });
        },
        child: Icon(
          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
        ),
      ),
    ),
    obscureText: !_isPasswordVisible,
    validator: (value) {
      if (value!.isEmpty || value.length < 6) {
        return 'Please enter a password with at least 6 characters';
      }
      return null;
    },
  ),
),
  
            SizedBox(height: 30.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                              context,
                              MaterialPageRoute(builder: (contetx) => MyApp() )
                            );
                    // Form is valid, implement your signup logic here
                  }
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(150, 30),
                  backgroundColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60.0),
                  ),
                ),
                child: Text('LogIn'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

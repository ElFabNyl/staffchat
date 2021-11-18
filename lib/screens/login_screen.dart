import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String staffCode;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        color: const Color(0xff060606),
        progressIndicator: const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 100.0),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'GlobexCam Staff Chat',
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 25),
                    ),
                  ),
                  const SizedBox(height: 13.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            letterSpacing: 12.0,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 50.0,
                        width: 50.0,
                        child: Image.asset('assets/images/splash.PNG'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30.0),
                  TextFormField(
                    onChanged: (value) {
                      //Do something with the user input.
                      email = value;
                    },
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Colors.grey,
                    decoration: const InputDecoration(
                      hintText: 'example@globexcam.com',
                      labelStyle: TextStyle(color: Colors.black),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  TextFormField(
                    onChanged: (value) {
                      //Do something with the user input.
                      staffCode = value;
                    },
                    obscureText: true,
                    cursorColor: Colors.grey,
                    decoration: const InputDecoration(
                      hintText: 'Enter your Staff code',
                      labelStyle: TextStyle(color: Colors.black),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            primary: Colors.grey, elevation: 0.0),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            showSpinner = true;
                          });
                          //Sign in with firebase using email and password
                          try {
                            final user = await _auth.signInWithEmailAndPassword(
                                email: email, password: staffCode);

                            if (user != null) {
                              Navigator.pushNamed(context, 'chat_screen');
                            }
                            setState(() {
                              showSpinner = false;
                            });
                          } catch (e) {
                            print(e.toString());
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.green, elevation: 0.0),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Get access',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 100.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: 50.0,
                        width: 50.0,
                        child: Image.asset('assets/images/cloudhost.png'),
                      ),
                      SizedBox(
                        height: 50.0,
                        width: 50.0,
                        child: Image.asset('assets/images/pixelLogo.png'),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: SizedBox(
                          height: 50.0,
                          width: 50.0,
                          child: Image.asset('assets/images/payam.png'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

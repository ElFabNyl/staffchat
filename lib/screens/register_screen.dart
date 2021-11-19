import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
// on creait ici une nouvelle instance d'authentification
  final _auth = FirebaseAuth.instance;
//
  bool showSpinner = false;
  late String employeeName;
  late String employeeEmail;
  late String employeeStaffCode;
  late String employeeRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        color : const Color(0xff060606),
        inAsyncCall: showSpinner,
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
                        'New Staff',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            letterSpacing: 12.0,
                            fontWeight: FontWeight.w800),
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
                      employeeName = value;
                    },
                    cursorColor: Colors.grey,
                    decoration: const InputDecoration(
                      hintText: 'Employee name',
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
                      employeeEmail = value;
                    },
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Colors.grey,
                    decoration: const InputDecoration(
                      hintText: 'Employee professional email',
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
                      employeeStaffCode = value;
                    },
                    cursorColor: Colors.grey,
                    decoration: const InputDecoration(
                      hintText: 'Employee Staff code',
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
                      employeeRole = value;
                    },
                    cursorColor: Colors.grey,
                    decoration: const InputDecoration(
                      hintText: 'Employee role',
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
                          //on utilise l'instance d'authentification de firebase ici pour créer un enregistrement
                          try {
                            final result =
                                await _auth.createUserWithEmailAndPassword(
                                    email: employeeEmail,
                                    password: employeeStaffCode);

                            User? user = result.user;
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(user!.uid)
                                .set({
                              'employeeUID': user.uid,
                              'employeeName': employeeName,
                              'employeeEmail': employeeEmail,
                              'employeeStaffCode': employeeStaffCode,
                              'employeeRole': employeeRole
                            });

                             Navigator.pushReplacementNamed(
                          context, 'login_screen');
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
                            'Register',
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

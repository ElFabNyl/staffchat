import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:staffchat/constants.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  late Map loggedInUser;
  late String name;
  late String staffCode;
  late String messageText;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

//method to check if there's a current user who signed in
  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;

      if (user != null) {
        final result = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        loggedInUser = result.data()!;
        name = loggedInUser['employeeName'];
        staffCode = loggedInUser['employeeStaffCode'];

        print(staffCode);
      }
    } catch (e) {
      print(e);
    }
  }

// cette fonction recupère les données en stream dans la BD
  void getMessagesStream() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          //this button appears if the current user is an admin

          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                //Implement add staff
                Navigator.pushNamed(context, 'register_screen');
              }),
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                // //Implement logout functionality
                _auth.signOut();
                Navigator.pop(context);
                
              }),
        ],
        title: const Text('Globexcam Staff Chat'),
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        //Do something with the user input.
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //messageText + loggedInUser['employeeName']

                      _firestore
                          .collection('messages')
                          .add({'text': messageText, 'sender': name});
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

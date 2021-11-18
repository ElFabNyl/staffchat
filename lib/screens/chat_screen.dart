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
  List<Widget> messagesWidgets = [];
  String messageText = "";

  @override
  void initState() {
    super.initState();
  }

//method to check if there's a current user who signed in
  Future<Map<String, dynamic>> getCurrentUser() async {
    final user = _auth.currentUser;

    if (user != null) {
      var snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (snapshot.exists) {
        return snapshot.data()!;
      } else {
        throw "donne pas trouve dans firebase";
      }
    } else {
      throw "pas d'utilisateur";
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
    return FutureBuilder<Map<String, dynamic>>(
        future: getCurrentUser(),
        builder: (context, snapshot) {
          bool ready = snapshot.hasData;
          return Scaffold(
            appBar: AppBar(
              leading: null,
              actions: <Widget>[
                //this button appears if the current user is an admin
                if (ready && snapshot.data!["employeeStaffCode"] == "admin1234")
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
            body: Builder(builder: (context) {
              if (!ready) {
                return const CircularProgressIndicator();
              }
              Map<String, dynamic> userData = snapshot.data!;
              String name = userData["employeeName"];
              return SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    //here we transform the streams into widgets
                    Expanded(
                      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: _firestore.collection('messages').snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, i) {
                                  final message = snapshot.data!.docs[i];
                                  Map<String, dynamic> data = message.data();
                                  final messageText = data["text"];
                                  final messageSender = data['sender'];

                                  return Center(
                                    child: Text(
                                        '$messageText from $messageSender'),
                                  );
                                });
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                    ),
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
              );
            }),
          );
        });
  }
}

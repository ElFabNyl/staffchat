import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:staffchat/constants.dart';

User loggedInUser = FirebaseAuth.instance.currentUser!;

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
  final messageTextController = TextEditingController();

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
        throw "Data not found";
      }
    } else {
      throw "no user found";
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
                        Navigator.pushReplacementNamed(
                            context, 'register_screen');
                      }),
                IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      // //Implement logout functionality
                      _auth.signOut();
                      Navigator.pushReplacementNamed(context, 'login_screen');
                    }),
              ],
              title: const Text('Globexcam Staff Chat'),
              backgroundColor: Colors.green,
            ),
            body: Builder(builder: (context) {
              if (!ready) {
                return const Center(
                    child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                ));
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
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 20.0),
                              child: ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  reverse : true,
                                  itemBuilder: (context, i) {
                                    final message = snapshot.data!.docs[i];
                                    
                                    Map<String, dynamic> data = message.data();
                                    final messageText = data["text"];
                                    final messageSender = data['sender'];
                                    //on recupere l'email de l'utilisateur connecté
                                    return TextBubble(
                                      messageText: messageText,
                                      messageSender: messageSender,
                                      isMe: messageSender ==
                                          userData['employeeName'],
                                    );
                                  }),
                            );
                          } else {
                            return const CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.green),
                            );
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
                              controller: messageTextController,
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

                              messageTextController.clear();
                              _firestore.collection('messages').add({
                                'text': messageText,
                                'sender': name,
                              });
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

class TextBubble extends StatelessWidget {
  final String messageText;
  final String messageSender;
  final bool isMe;
  const TextBubble({
    Key? key,
    required this.isMe,
    required this.messageText,
    required this.messageSender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              messageSender,
              style: const TextStyle(color: Colors.black54),
            ),
            Material(
              elevation: 5.0,
              borderRadius: isMe
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))
                  : const BorderRadius.only(
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
              color: isMe ? Colors.blueGrey : Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Text(
                  messageText,
                  style: TextStyle(
                      color: isMe ? Colors.white : Colors.black54,
                      fontSize: 17.0,
                      fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ],
        ));
  }
}

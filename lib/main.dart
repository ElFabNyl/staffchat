import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:staffchat/screens/chat_screen.dart';
import 'package:staffchat/screens/login_screen.dart';
import 'package:staffchat/screens/register_screen.dart';
import 'package:staffchat/screens/splash_screen.dart';
 void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'splash_screen',
        routes: {
          'login_screen': (context) => const LoginScreen(),
          'register_screen': (context) => const RegisterScreen(),
          'chat_screen': (context) => const ChatScreen(),
          'splash_screen': (context) => const SplashScreen(),
        });
  }
}

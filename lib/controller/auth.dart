import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

    final FirebaseAuth _auth = FirebaseAuth.instance;

    //create a user objet base on firebase user
    // Users _userFromFirebaseUser(User user){

    //   return null
    // }

    // Sign in anonymously

    Future signInAnon()  async {
      try {
           UserCredential  result = await _auth.signInAnonymously();
           User ? user = result.user;
           return user;

      }catch(e){
        print(e.toString());
        return null;
      }
    }


}
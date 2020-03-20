import '../models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseAuth getAuth() {

    return _auth;

  }

  void setUser(FirebaseUser user) {

    _userFromFirebaseUser(user);

  }

  // create user obj based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
      //.map((FirebaseUser user) => _userFromFirebaseUser(user));
      .map(_userFromFirebaseUser);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInWithGoogle() async {
    try {
      
      GoogleSignIn goog = new GoogleSignIn(scopes: ["email"]);
      
      GoogleSignInAccount googleUser = await goog.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      FirebaseUser user = (await _auth.signInWithCredential(credential)).user;


      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInWithFacebook() async {
    try {
      
      FacebookLogin facebookLogin = FacebookLogin();
      FacebookLoginResult facebookLoginResult = await facebookLogin.logIn(["email", "public_profile"]);

      print(facebookLoginResult);

      final accessToken = facebookLoginResult.accessToken.token;

      AuthCredential facebookAuthCred = FacebookAuthProvider.getCredential(accessToken: accessToken);

      FirebaseUser user = (await _auth.signInWithCredential(facebookAuthCred)) as FirebaseUser;


      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future signInPhone(
    String phone,
    PhoneCodeSent codeSent,
    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout,
    PhoneVerificationFailed verificationFailed,
    PhoneVerificationCompleted verificationCompleted
  ) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout
      );
      // FirebaseUser user = result.user;
      // return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    } 
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    } 
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

}
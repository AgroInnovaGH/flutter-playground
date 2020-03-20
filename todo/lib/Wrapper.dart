import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/services/auth.dart';
import 'SignIn.dart';
import './models/user.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {

  AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    // print(user);

    if (user != null){

      return RaisedButton(
        onPressed: () async {

          await auth.signOut();
            
            // await auth.signInPhone(
            //   phoneNumber,
            //   this.codeSent,
            //   this.codeAutoRetrievalTimeout,
            //   this.verificationFailed,
            //   this.verificationCompleted
            // );

        },
        child: Text('Sign out')
      );

    } else {

      return SignIn();

    }

  }
}
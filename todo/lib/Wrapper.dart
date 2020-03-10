import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'SignIn.dart';
import './models/user.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    // print(user);

    if (user != null){

      return Text('Logged In');

    } else {

      return SignIn();

    }

  }
}
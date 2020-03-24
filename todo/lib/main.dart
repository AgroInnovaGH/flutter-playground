import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import './services/auth.dart';
import './models/user.dart';

import 'Wrapper.dart';

void main() => runApp(MaterialApp(
  home: Home(),
));

class Home extends StatefulWidget{

  const Home({
    Key key
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();

}

class _HomeState extends State<Home>{


  @override
  Widget build(BuildContext context){

    return StreamProvider<User>.value(
      value: AuthService().user,
      child: Wrapper()
    );

  }

}




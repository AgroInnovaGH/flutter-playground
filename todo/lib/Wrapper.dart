import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/services/auth.dart';
import 'SignIn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'FloatButton.dart';
import 'Task.dart';
import 'ListWidget.dart';
import './models/user.dart';
import 'package:firestore_ui/firestore_ui.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {

  AuthService auth = AuthService();

  final List<Task> tasks = [];
  int currentIndex = 0;

  static onPressed(doc) {

    doc.reference.delete();

  }

  static onChanged(doc, completed){

      doc.reference.updateData({
        'completed': completed
      });

  }

  final tabs = [
    // FirestoreAnimatedList(
    //   key: ValueKey("list"),
    //   query: Firestore.instance.collection('tasks').snapshots(),
    //   onLoaded: (snapshot) =>
    //       print("Received on list: ${snapshot.documents.length}"),
    //   itemBuilder: (
    //     BuildContext context,
    //     DocumentSnapshot snapshot,
    //     Animation<double> animation,
    //     int index,
    //   ) =>
    //       FadeTransition(
    //     opacity: animation,
    //     child: ListWidget.listItem(snapshot, onChanged, onPressed),
    //   ),
    // ),
    FirestoreAnimatedList(
      key: ValueKey("list"),
      query: Firestore.instance.collection('tasks').where('completed', isEqualTo: false).snapshots(),
      onLoaded: (snapshot) =>
          print("Received on list: ${snapshot.documents.length}"),
      itemBuilder: (
        BuildContext context,
        DocumentSnapshot snapshot,
        Animation<double> animation,
        int index,
      ) =>
          FadeTransition(
        opacity: animation,
        child: ListWidget.listItem(snapshot, onChanged, onPressed),
      ),
    ),
    FirestoreAnimatedList(
      key: ValueKey("list"),
      query: Firestore.instance.collection('tasks').where('completed', isEqualTo: true).snapshots(),
      onLoaded: (snapshot) =>
          print("Received on list: ${snapshot.documents.length}"),
      itemBuilder: (
        BuildContext context,
        DocumentSnapshot snapshot,
        Animation<double> animation,
        int index,
      ) =>
          FadeTransition(
        opacity: animation,
        child: ListWidget.listItem(snapshot, onChanged, onPressed),
      ),
    ),
    Text('Hello World')
  ];

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    // print(user);


    if (user != null){

      return Scaffold(
        appBar: AppBar(
          title: Text('TODO App'),
          backgroundColor: Colors.green[600],
        ),
        body: tabs[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.green[600],
          currentIndex: currentIndex,
          onTap: (index){

            setState(() {
              
              currentIndex = index;

            });

          },
          items: [
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.list, color: Colors.white),
            //   activeIcon: Icon(Icons.list, color: Colors.green[800]),
            //   title: Text('All', style: TextStyle(
            //     color: Colors.white
            //   ))
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.format_list_bulleted, color: Colors.white),
              activeIcon: Icon(Icons.format_list_bulleted, color: Colors.green[800]),
              title: Text('Not Completed', style: TextStyle(
                color: Colors.white
              ))
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.playlist_add_check, color: Colors.white),
              activeIcon: Icon(Icons.playlist_add_check, color: Colors.green[800]),
              title: Text('Completed', style: TextStyle(
                color: Colors.white
              ))
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.table_chart, color: Colors.white),
              activeIcon: Icon(Icons.table_chart, color: Colors.green[800]),
              title: Text('DataTables', style: TextStyle(
                color: Colors.white
              ))
            )
          ],
        ),
        floatingActionButton: FloatButton(
          onCallback: (String text) async {

            if (tasks.indexWhere((task) => task.text == text) > -1) {

              print('Task already exists');

            } else {

              await Firestore.instance.collection('tasks').add(<String, dynamic>{
                'text': text,
                'completed': false,
                'created_at': FieldValue.serverTimestamp(),
              });

            }

            print(tasks.length);

          }
        ),
      );

    } else {

      return SignIn();

    }

  }
}
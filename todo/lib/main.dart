import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'FloatButton.dart';
import 'Task.dart';
import 'ListWidget.dart';
// import 'Wrapper.dart';
import 'SignIn.dart';

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

  final List<Task> tasks = [];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context){

    final tabs = [
      StreamBuilder(
        stream: Firestore.instance.collection('tasks').snapshots(),
        builder: (context, snapshot){

          return ListWidget(
            tasks: snapshot.data.documents,
            onPressed: (doc) {

              doc.reference.delete();

            },
            onChanged: (doc, completed){

                doc.reference.updateData({
                  'completed': completed
                });

            }
          );

        }
      ),
      StreamBuilder(
        stream: Firestore.instance.collection('tasks').where('completed', isEqualTo: false).snapshots(),
        builder: (context, snapshot){

          return ListWidget(
            tasks: snapshot.data.documents,
            onPressed: (doc) {

              doc.reference.delete();

            },
            onChanged: (doc, completed){

                doc.reference.updateData({
                  'completed': completed
                });

            }
          );

        }
      ),
      StreamBuilder(
        stream: Firestore.instance.collection('tasks').where('completed', isEqualTo: true).snapshots(),
        builder: (context, snapshot){

          return ListWidget(
            tasks: snapshot.data.documents,
            onPressed: (doc) {

              doc.reference.delete();

            },
            onChanged: (doc, completed){

                doc.reference.updateData({
                  'completed': completed
                });

            }
          );

        }
      )
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('TODO App'),
        backgroundColor: Colors.green[600],
      ),
      body: SignIn(),
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Colors.green[600],
      //   currentIndex: currentIndex,
      //   onTap: (index){

      //     setState(() {
            
      //       currentIndex = index;

      //     });

      //   },
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.list, color: Colors.white),
      //       activeIcon: Icon(Icons.list, color: Colors.green[800]),
      //       title: Text('All', style: TextStyle(
      //         color: Colors.white
      //       ))
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.format_list_bulleted, color: Colors.white),
      //       activeIcon: Icon(Icons.format_list_bulleted, color: Colors.green[800]),
      //       title: Text('Not Completed', style: TextStyle(
      //         color: Colors.white
      //       ))
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.playlist_add_check, color: Colors.white),
      //       activeIcon: Icon(Icons.playlist_add_check, color: Colors.green[800]),
      //       title: Text('Completed', style: TextStyle(
      //         color: Colors.white
      //       ))
      //     )
      //   ],
      // ),
      // floatingActionButton: FloatButton(
      //   onCallback: (String text) async {

      //     if (tasks.indexWhere((task) => task.text == text) > -1) {

      //       print('Task already exists');

      //     } else {

      //       await Firestore.instance.collection('tasks').add(<String, dynamic>{
      //         'text': text,
      //         'completed': false,
      //         'created_at': FieldValue.serverTimestamp(),
      //       });

      //     }

      //     print(tasks.length);

      //   }
      // ),
    );

  }

}




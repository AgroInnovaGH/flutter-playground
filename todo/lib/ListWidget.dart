import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'Task.dart';

class ListWidget extends StatelessWidget{

  final List tasks;
  final Function(DocumentSnapshot, bool) onChanged;
  final Function(DocumentSnapshot) onPressed;
  String search;

  ListWidget({
    this.tasks,
    this.onChanged,
    this.onPressed
  });

  static Column listItem(DocumentSnapshot doc, dynamic onChanged, dynamic onPressed) {

    // if (tasks[position] == null) return null;

    var task = doc.data;

    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            left: 10
          ),
          child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Checkbox(
                  onChanged: (completed) {
                    onChanged(doc, completed);
                  },
                  value: task['completed'],
                ),
                Text(task['text'], style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 21.0
                )),
              ],
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: (){
                onPressed(doc);
              },
            )
          ],
        ),
        )
      ],
    );

  }

  @override
  Widget build(BuildContext context) {

    return Text('Hello World');

  }

}
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Task.dart';

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

  @override
  Widget build(BuildContext context) {

    return new Column(
      children: <Widget>[
        Expanded(child: new ListView.builder(
          itemBuilder: (context, position){

            DocumentSnapshot doc = tasks[position];
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
          },
          itemCount: tasks.length,
        ),
        ),
        Divider(
          height: 2.0,
          color: Colors.black,
        )
      ],
    );

  }

}
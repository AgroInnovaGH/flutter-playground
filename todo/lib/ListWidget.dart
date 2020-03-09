import 'package:flutter/material.dart';
import 'Task.dart';

class ListWidget extends StatelessWidget{

  final List tasks;
  final Function(Task, bool) onChanged;
  final Function(int) onPressed;
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
                            onChanged(tasks[position], completed);
                          },
                          value: tasks[position].completed,
                        ),
                        Text(tasks[position].text, style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 21.0
                        )),
                      ],
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: (){
                        onPressed(position);
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
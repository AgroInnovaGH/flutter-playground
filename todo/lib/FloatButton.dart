import 'package:flutter/material.dart';

class FloatButton extends StatelessWidget{

  final Function(String) onCallback;

  FloatButton({
    this.onCallback
  });

  Future<String> showAlertDialog(BuildContext context){

    TextEditingController controller = TextEditingController();

    return showDialog(context: context, builder: (context){

      return AlertDialog(
        title: Text('Enter task'),
        content: TextField(
          controller: controller,
        ),
        actions: <Widget>[
          RaisedButton(
            onPressed: (){

              Navigator.of(context).pop(controller.text.toString());

            },
            child: Text('Save'),
          )
        ],
      );

    });

  }

  @override
  Widget build(BuildContext context) {

    return FloatingActionButton(
      onPressed: () {

        showAlertDialog(context).then((text) {

          if (text != null) {
            onCallback(text);
          }
          // final snackBar = SnackBar(content: Text('Saved $text'));

          // // Find the Scaffold in the widget tree and use it to show a SnackBar.
          // Scaffold.of(context).showSnackBar(snackBar);

        });

      },
      child: Icon(Icons.add),
      backgroundColor: Colors.green[600],
    );

  }

}
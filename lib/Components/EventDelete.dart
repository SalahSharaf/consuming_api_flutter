import 'package:flutter/material.dart';

class EventDelete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text("delete"),
      content: new Text("are you sure you want to delete"),
      actions: <Widget>[
        FlatButton(
          child: new Text("yes"),
          onPressed: (){Navigator.of(context).pop(true);},
        ),
        FlatButton(
          child: new Text("no"),
          onPressed: (){Navigator.of(context).pop(false);},
        )
      ],
    );
  }
}

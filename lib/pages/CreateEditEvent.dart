import 'package:flutter/material.dart';

class CreateEditEvent extends StatefulWidget {
  int gateOfCreate;

  CreateEditEvent(this.gateOfCreate);

  @override
  _CreateEditEventState createState() => _CreateEditEventState();
}

class _CreateEditEventState extends State<CreateEditEvent> {
  String nameOFPage;

  var textTitleController;
  var textDetailsController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.gateOfCreate == 1) {
      nameOFPage = "Create Event";
    } else {
      nameOFPage = "Edit Event";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: new Text(nameOFPage)),
      body: new Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(15),
          child: new TextField(controller: textTitleController,decoration:InputDecoration(hintText:" Title Field",hintMaxLines: 1,),),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: new TextField(controller: textDetailsController,decoration: InputDecoration(hintText: "Details Field",hintMaxLines: 1),),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: MaterialButton(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: new Text("Submit"),
            ),
            elevation: 10,
            color: Colors.blueGrey,
            textColor: Colors.white,
            minWidth: double.infinity,
            onPressed: (){},
          ),
        )
      ],),
    );
  }
}

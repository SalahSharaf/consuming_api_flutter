import 'package:consumingapi/Models/ApiResponce.dart';
import 'package:consumingapi/Models/Event.dart';
import 'package:consumingapi/Models/EventMonupolation.dart';
import 'package:consumingapi/Models/EventPost.dart';
import 'package:consumingapi/Services/EventService.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CreateEditEvent extends StatefulWidget {
  String eventID;

  CreateEditEvent(this.eventID);

  @override
  _CreateEditEventState createState() => _CreateEditEventState();
}

class _CreateEditEventState extends State<CreateEditEvent> {
  String nameOFPage;

  EventService get eventService => GetIt.I<EventService>();
  ApiResponse<Event> apiResponse;
  Event event;
  TextEditingController textTitleController = new TextEditingController();
  TextEditingController textDetailsController = new TextEditingController();
  String errorName;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      isLoading = true;
    });
    if (widget.eventID == "") {
      nameOFPage = "Create Event";
    } else {
      nameOFPage = "Edit Event";
      eventService.getEvent(widget.eventID).then((value) {
        if (value.error) {
          errorName = value.errorMessage;
        }
        event = value.data;
        textTitleController.text = value.data.noteTitle;

        ///it's supposed to be content but i can't find it so make it event id
        textDetailsController.text = value.data.noteId;
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: new Text(nameOFPage)),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : new Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: new TextField(
                    controller: textTitleController,
                    decoration: InputDecoration(
                      hintText: " Title Field",
                      hintMaxLines: 1,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: new TextField(
                    controller: textDetailsController,
                    decoration: InputDecoration(
                        hintText: "Details Field", hintMaxLines: 1),
                  ),
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
                    onPressed: () async {
                      if (nameOFPage == "Create Event") {
                        final event = new EventPost(
                            eventTitle: textTitleController.text,
                            eventContent: textDetailsController.text);
                        final result = await eventService.createEvent(event);
                        final title = "done";
                        final text = result.error
                            ? result.errorMessage
                            : "item was Created successfully";
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: new Text(text),
                                actions: <Widget>[
                                  FlatButton(
                                    child: new Text("ok"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              );
                            }).then((value){
                              if(result.data) {
                                Navigator.of(context).pop();
                              }
                        });
                      } else if(nameOFPage=="Edit Event") {
                        final event = new EventMonupolation(
                            eventTitle: textTitleController.text,
                            eventContent: textDetailsController.text);
                        final result = await eventService.updateEvent(event,widget.eventID);
                        final title = "done";
                        final text = result.error
                            ? result.errorMessage
                            : "item was Updated successfully";
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: new Text(text),
                                actions: <Widget>[
                                  FlatButton(
                                    child: new Text("ok"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              );
                            }).then((value){
                          if(result.data) {
                            Navigator.of(context).pop();
                          }
                        });
                      }
                    },
                  ),
                ),
                Text("$errorName"),
              ],
            ),
    );
  }
}

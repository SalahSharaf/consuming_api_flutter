import 'package:flutter/cupertino.dart';

class EventMonupolation{

  String eventTitle;
  String eventContent;
  EventMonupolation({@required this.eventTitle,@required this.eventContent});

  Map<String,dynamic> toJson(){
    return
      {
        "noteTitle":eventTitle,
        "noteContent":eventContent
      };
  }
}
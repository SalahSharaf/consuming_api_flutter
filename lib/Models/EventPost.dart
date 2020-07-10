import 'package:flutter/cupertino.dart';

class EventPost{

  String eventTitle;
  String eventContent;
  EventPost({@required this.eventTitle,@required this.eventContent});
  Map<String,dynamic> toJson(){
    return
      {
        "noteTitle":eventTitle,
        "noteContent":eventContent
      };



  }
}
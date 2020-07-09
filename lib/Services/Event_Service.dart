import 'dart:convert';

import 'package:consumingapi/Models/ApiResponce.dart';
import 'package:consumingapi/Models/Event.dart';
import 'package:http/http.dart' as http;

class Events_Service {
  static const API = "http://api.notes.programmingaddict.com";
  static const APIKEYHeaders = {
    "apiKey": "b694296a-3377-4b91-b709-96d1785a616e"
  };

  Future<ApiResponse<List<Event>>> getEventsList() {
    return http.get(API + "/notes", headers: APIKEYHeaders).then((value) {
      if (value.statusCode == 200) {
        final jsonData = json.decode(value.body);
        final events = <Event>[];
        for (var item in jsonData) {
          final event = Event(
              item['noteID'],
              item['noteTitle'],
              DateTime.parse(item['createDateTime']),
              DateTime.parse(item['latestEditDateTime']));
          events.add(event);
        }
        return ApiResponse<List<Event>>(events, false,"");
      } else {
        return ApiResponse<List<Event>>(null, true, "error occured");
      }
    }).catchError((onError)=> ApiResponse<List<Event>>(null, true, "error occured"););
  }
}

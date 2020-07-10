import 'dart:convert';
import 'package:consumingapi/Models/ApiResponce.dart';
import 'package:consumingapi/Models/Event.dart';
import 'package:consumingapi/Models/EventMonupolation.dart';
import 'package:consumingapi/Models/EventPost.dart';
import 'package:http/http.dart' as http;

class Events_Service {
  static const API = "http://api.notes.programmingaddict.com";
  static const APIKEYHeaders = {
    "apiKey": "b694296a-3377-4b91-b709-96d1785a616e",
    "Content-Type": 'application/json'
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
              item['createDateTime'] != null
                  ? DateTime.parse(item['createDateTime'])
                  : null,
              item['latestEditDateTime'] != null
                  ? DateTime.parse(item['latestEditDateTime'])
                  : null);
          events.add(event);
        }
        return ApiResponse<List<Event>>(events, false, "");
      } else {
        return ApiResponse<List<Event>>(null, true, "error occurred");
      }
    }).catchError(
        (onError) => ApiResponse<List<Event>>(null, true, onError.toString()));
  }

  Future<ApiResponse<Event>> getEvent(String id) {
    return http.get(API + "/notes/" + id, headers: APIKEYHeaders).then((value) {
      if (value.statusCode == 200) {
        final jsonData = json.decode(value.body);
        final event = Event(
            jsonData['noteID'],
            jsonData['noteTitle'],
            jsonData['createDateTime'] != null
                ? DateTime.parse(jsonData['createDateTime'])
                : null,
            jsonData['latestEditDateTime'] != null
                ? DateTime.parse(jsonData['latestEditDateTime'])
                : null);
        return ApiResponse<Event>(event, false, "");
      } else {
        return ApiResponse<Event>(null, true, "error occurred");
      }
    }).catchError(
        (onError) => ApiResponse<Event>(null, true, onError.toString()));
  }

  Future<ApiResponse<bool>> createEvent(EventPost item) {
    return http
        .post(API + "/notes",
            headers: APIKEYHeaders, body: json.encode(item.toJson()))
        .then((value) {
      if (value.statusCode == 201) {
        return ApiResponse<bool>(true, false, "");
      } else {
        return ApiResponse<bool>(null, true, "error occurred");
      }
    }).catchError(
            (onError) => ApiResponse<bool>(null, true, onError.toString()));
  }

  Future<ApiResponse<bool>> updateEvent(EventMonupolation item, String eventID) {
    return http
        .put(API + "/notes/" + eventID,
            headers: APIKEYHeaders, body: json.encode(item.toJson()))
        .then((value) {
      if (value.statusCode == 204) {
        print("the error ################################################### ${value.statusCode.toString()}");
        return ApiResponse<bool>(true, false, "");
      } else {
        print("the error ################################################### ${value.statusCode.toString()}");
        return ApiResponse<bool>(false, true, "Updated Successfully but ${value.statusCode}");
      }
    }).catchError(
            (onError) => ApiResponse<bool>(false, true, onError.toString()));
  }


///////////////////////////////////////////////////////////////////////////
  Future<ApiResponse<bool>> deleteEvent( String eventID) {
    return http
        .put(API + "/notes/" + eventID,
        headers: APIKEYHeaders)
        .then((value) {
      if (value.statusCode == 200) {
        print("the error ################################################### ${value.statusCode.toString()}");
        return ApiResponse<bool>(true, false, "");
      } else {
        print("the error ################################################### ${value.statusCode.toString()}");
        return ApiResponse<bool>(false, true, "Deleted Successfully but  ${value.statusCode}");
      }
    }).catchError((onError) => ApiResponse<bool>(false, true, onError.toString()));
  }

}

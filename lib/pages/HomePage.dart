import 'package:consumingapi/Components/EventDelete.dart';
import 'package:consumingapi/Models/ApiResponce.dart';
import 'package:consumingapi/Models/Event.dart';
import 'package:consumingapi/Services/Event_Service.dart';
import 'package:consumingapi/pages/CreateEditEvent.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Events_Service get eventService => GetIt.I<Events_Service>();
  ApiResponse<List<Event>> apiResponse;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      fetchNotesList();
    });
  }

  Future fetchNotesList() async {
    setState(() {
      isLoading = true;
    });
    apiResponse = await eventService.getEventsList();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: Text("List"),
        ),
        floatingActionButton: new FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(
                    builder: (context) => CreateEditEvent("")))
                .then((value) {
              fetchNotesList();
            });
          },
          child: Icon(Icons.add),
        ),
        body: Builder(builder: (context) {
          if (isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (apiResponse.error) {
            return Text(apiResponse.errorMessage);
          }
          return ListView.separated(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Dismissible(
                    key: ValueKey(apiResponse.data[index].noteId),
                    direction: DismissDirection.startToEnd,
                    onDismissed: (direction) {},
                    confirmDismiss: (direction) async {
                      final result = await showDialog(
                          context: this.context,
                          builder: (context) => EventDelete());
                      if(result){
                        final deleteResult=await eventService.deleteEvent(apiResponse.data[index].noteId);
                        String message;
                        if(deleteResult!=null&&deleteResult.data==true){
                          message="the note was deleted successfully";
                        }else{
                            message=deleteResult.errorMessage;
                        }
                        Scaffold.of(context).showSnackBar(SnackBar(content: Text(message),duration: new Duration(milliseconds: 3000 ,)));
                        return deleteResult.data;
                      }
                      return result;
                    },
                    background: new Container(
                        color: Colors.deepOrange,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Icon(Icons.delete),
                        )),
                    child: Card(
                      color: Colors.white,
                      elevation: 10,
                      child: ListTile(
                        leading: new Text(apiResponse.data[index].noteId),
                        title: new Text(apiResponse.data[index].noteTitle),
                        subtitle: Text(
                            apiResponse.data[index].createDateTime.toString()),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CreateEditEvent(
                                  apiResponse.data[index].noteId))).then((value) {fetchNotesList();});
                        },
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, _) => Divider(
                    color: Colors.grey,
                    thickness: 3,
                    height: 3,
                  ),
              itemCount: apiResponse.data.length);
        }));
  }
}

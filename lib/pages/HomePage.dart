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
  ApiResponce<List<Event>> apiResponce;
  bool isLoading
  @override
  void initState() {
    // TODO: implement initState
  fetchNotesList
    super.initState();
  }
  void fetchNotesList(){
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: Text("List"),
        ),
        floatingActionButton: new FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CreateEditEvent(1)));
          },
          child: Icon(Icons.add),
        ),
        body: new ListView.separated(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Dismissible(
                  key: ValueKey(events[index].noteId),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction) {},
                  confirmDismiss: (direction) async {
                    final result = await showDialog(
                        context: this.context,
                        builder: (context) => EventDelete());
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
                      leading: new Text(events[index].noteId),
                      title: new Text(events[index].noteTitle),
                      subtitle: Text(events[index].createDateTime.toString()),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CreateEditEvent(0)));
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
            itemCount: events.length));
  }
}

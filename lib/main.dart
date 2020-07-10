import 'package:consumingapi/Services/EventService.dart';
import 'package:consumingapi/pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void setupLocator(){
    GetIt.instance.registerLazySingleton(() => EventService());
}
void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}
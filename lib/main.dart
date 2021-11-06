import 'package:flutter/material.dart';
import 'package:notes_app/routes/HomePageRoutes.dart';
import 'package:notes_app/widgets/MyHomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue,),
      title: "Notes",
      //home: MyHomePage(),
      initialRoute: "/",
      routes: getHomePageRoutes(context),

      debugShowCheckedModeBanner: false,
    );
  }
}

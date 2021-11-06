import 'package:flutter/material.dart';
import 'package:notes_app/routes/HomePageRoutes.dart';


class App extends StatelessWidget {

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
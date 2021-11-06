import 'package:flutter/material.dart';
import 'package:notes_app/widgets/AddNewNotesPage.dart';
import 'package:notes_app/widgets/MyHomePage.dart';


Map<String, Widget Function(BuildContext)> getHomePageRoutes(BuildContext context){
  return {
    "/" : (context) => const MyHomePage(),
    "/newNote" : (context) => AddNewNotesPage(),
  };
}
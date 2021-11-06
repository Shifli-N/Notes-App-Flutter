import 'package:flutter/material.dart';
import 'package:notes_app/src/ui/AddNewNotesPage.dart';
import 'package:notes_app/src/ui/MyHomePage.dart';


Map<String, Widget Function(BuildContext)> getHomePageRoutes(BuildContext context){
  return {
    "/" : (context) => const MyHomePage(),
    "/newNote" : (context) => AddNewNotesPage(),
  };
}
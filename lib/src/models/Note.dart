import 'dart:core';
import 'package:floor/floor.dart';
import 'package:flutter/material.dart';


@entity
class Note{

  @PrimaryKey(autoGenerate: true)
  int? id;
  String heading;
  String notes;
  String date;


  Note({this.id, required this.heading, required this.notes, required this.date});

  // Note.formJson(Map<String, dynamic> data)
  //   :id = data["id"],
  //   heading = data["heading"],
  //   notes = data["notes"]
  // ;

  Note.formJson(Map<String, dynamic> data)
      : heading = data["heading"],
        notes = data["notes"],
        date = data["date"]
  ;

  Map<String, dynamic> toJson(){
    return {
      "id" : this.id,
      "heading" : this.heading,
      "note" : this.notes,
      "date" : this.date,
    };
  }

  @override
  String toString() {
    return 'Note{id: $id, heading: $heading, notes: $notes, date: $date}';
  }
}
import 'package:floor/floor.dart';
import 'package:notes_app/src/models/Note.dart';
import 'package:notes_app/src/resources/databases/dao/NoteDAO.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;

part "NoteDatabase.g.dart";

@Database(version: 1, entities: [Note,])
abstract class NoteDatabase extends FloorDatabase{
  NoteDAO get noteDAO;
}
import 'package:floor/floor.dart';
import 'dart:async';
import 'package:notes_app/databases/dao/NoteDAO.dart';
import 'package:notes_app/databases/models/Note.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part "NoteDatabase.g.dart";

@Database(version: 1, entities: [Note,])
abstract class NoteDatabase extends FloorDatabase{
  NoteDAO get noteDAO;
}
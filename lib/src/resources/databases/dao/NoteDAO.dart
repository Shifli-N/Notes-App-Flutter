import 'package:floor/floor.dart';
import 'dart:async';
import 'package:notes_app/src/models/Note.dart';

@dao
abstract class NoteDAO{
  @insert
  Future<void> insertNote(Note note);

  @Query("SELECT * FROM Note")
  Future<List<Note>> showAllNotes();
}
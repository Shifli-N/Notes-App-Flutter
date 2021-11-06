import 'package:notes_app/src/models/Note.dart';
import 'databases/dbClasses/NoteDatabase.dart';

class Repository{

  //Database Connections
  Future<NoteDatabase> getNoteDbInstance() async{
    return await $FloorNoteDatabase.databaseBuilder("NoteDatabase.db").build();
  }

  Future<void> insertNote(NoteDatabase db, Note note) async{
    await db.noteDAO.insertNote(note);
  }

  Future<List<Note>> showAllNotes(NoteDatabase db) async{
    return await db.noteDAO.showAllNotes();
  }
}
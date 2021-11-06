import 'package:notes_app/src/models/Note.dart';
import 'package:notes_app/src/resources/Repository.dart';
import 'package:notes_app/src/resources/databases/dbClasses/NoteDatabase.dart';

class NoteBloc{
  static NoteBloc? _noteBloc;
  NoteDatabase? _noteDb;
  final _repository = Repository();

  NoteBloc(){
    print('Inside the constructor');
    print('constructor noteDb - ${this._noteDb}');
  }

  static NoteBloc getInstance(){
    if(_noteBloc != null) return _noteBloc!;

    _noteBloc = NoteBloc();
    return _noteBloc!;
  }

  Future<NoteDatabase> _getDbInstance() async {
    if(_noteDb == null) {
      _noteDb = await _repository.getNoteDbInstance();
    }

    return _noteDb!;
  }


  void saveNotesInDb({required String heading, required String note}) async{
    try{

      /*var tempData = {
        "heading" : "Test 2",
        "notes" : "Auto upgrade testing",
        "date":"${DateTime.now().millisecondsSinceEpoch}"
      };*/

      var tempData = {
        "heading" : "$heading",
        "notes" : "$note",
        "date":"${DateTime.now().millisecondsSinceEpoch}"
      };

      var notes = Note.formJson(tempData);

      var db = await _getDbInstance();

      await _repository.insertNote(db, notes);

    }catch(e, s){
      print('$e');
      print(s);
    }
  }


  Future<List<Note>> showNotesInDb() async{
    List<Note> notes = [];
    try{
      print('noteDb - $_noteDb');

      var db = await _getDbInstance();

      notes = await _repository.showAllNotes(db);

      //print('result $tempResult');

      /*tempResult.forEach((element) {
        print('${element.toString()}');
      });*/

      // return notes;

    }catch(e, s){
      print(e);
      print(s);
    }

    return notes;
  }


}

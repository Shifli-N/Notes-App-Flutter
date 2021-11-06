import 'package:flutter/material.dart';
import 'package:notes_app/constants/TextStyleConstant.dart';
import 'package:notes_app/src/bloc/NoteBloc.dart';
import 'package:notes_app/src/models/Note.dart';

class AddNewNotesPage extends StatefulWidget {
  const AddNewNotesPage({Key? key}) : super(key: key);

  @override
  _AddNewNotesPageState createState() => _AddNewNotesPageState();
}

class _AddNewNotesPageState extends State<AddNewNotesPage> {
  late BuildContext mContext;

  NoteBloc noteBloc = NoteBloc.getInstance();

  late dynamic db;

  bool alreadyOneAdded = false;

  late TextEditingController _headingTextFieldController, _noteTextFieldController;

  @override
  void initState() {
    super.initState();
    print('Widget is Init State');
    _headingTextFieldController = TextEditingController();
    _noteTextFieldController = TextEditingController();

   /* $FloorNoteDatabase.databaseBuilder("NoteDatabase.db")
        .build()
        .then((value) async {
          this.db = value;
        }
    );*/
    
  }

  @override
  void dispose() {
    print('Widget in Dispose State');
    _headingTextFieldController.clear();
    _headingTextFieldController.dispose();
    _noteTextFieldController.dispose();

    super.dispose();
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies in state');
  }


  Future<bool> _onBackPress() async {
    if(alreadyOneAdded){
      return true;
    }

    var dialogWidget = await showDialog(
        context: context,
        builder: (context)=> AlertDialog(
          title: Text("Do you want Discard"),
          content: Text("Are you sure to Discard, Note is unsaved?"),

          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context,false);
              },
              child: Text("No",
                style: TextStyle(
                    backgroundColor: Colors.blue,
                    color: Colors.white,
                    fontWeight: FontWeight.w600
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.pushNamed(context, "/");
                Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
              },
              child: Text("Yes",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600
                ),
              ),
            ),
          ],

        ),
    );

    return dialogWidget ?? false;
  }



  @override
  Widget build(BuildContext context) {
    mContext = context;

    return SafeArea(
      child: WillPopScope(
        onWillPop: _onBackPress,

        child: Scaffold(
          appBar: AppBar(
            title: Text("Notes",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                letterSpacing: 2.3,
              ),
            ),
          ),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20,),
                  Text("Add New Notes", style: addNewHeadingTextStyle,),

                  SizedBox(height: 15,),
                  TextField(
                    controller: _headingTextFieldController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Add Subject"
                    ),

                    onSubmitted: (String value){
                      print('$value');
                      _headingTextFieldController.clear();
                    },
                  ),

                  SizedBox(height: 20,),
                  TextField(
                    controller: _noteTextFieldController,
                    minLines: 10,
                    maxLines: 25,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Add Notes",
                    ),

                    onSubmitted: (String value){
                      print('$value');
                      _headingTextFieldController.clear();
                    },
                  ),
                ],
              ),
            )
          ),

          floatingActionButton: FloatingActionButton(
            onPressed: addNotes,
            backgroundColor: Colors.green,
            mini: false,
            child: Icon(Icons.check, color: Colors.white,),
          ),

        ),
      ),
    );
  }


  void addNotes() {
    if(_headingTextFieldController.value.text.isNotEmpty && _noteTextFieldController.value.text.isNotEmpty){
      String head = _headingTextFieldController.value.text;
      String note = _noteTextFieldController.value.text;

      _headingTextFieldController.clear();
      _noteTextFieldController.clear();


      /*saveNotesInDb(heading: head, note: note);
      showNotesInDb();*/
      
      noteBloc.saveNotesInDb(heading: head, note: note);
      showNotesList();
      

      alreadyOneAdded = true;
    }else{
      print('Text Field is empty');
      showNotesList();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Please Fill all Fields"),
            action: SnackBarAction(label: "OK", onPressed: ScaffoldMessenger.of(context).hideCurrentSnackBar),
          )
      );
    }

    FocusScope.of(context).unfocus();
  }


  void showNotesList() async{
    try{

      List<Note> tempResult = await noteBloc.showNotesInDb();
      print('result - \n $tempResult');

      /*tempResult.forEach((element) {
        print('${element.toString()}');
      });*/

    }catch(e, s){
      print(e);
      print(s);
    }

  }

}

import 'package:flutter/material.dart';
import 'package:notes_app/constants/ColorsConstant.dart';
import 'package:notes_app/constants/TextStyleConstant.dart';
import 'package:notes_app/databases/dbClasses/NoteDatabase.dart';
import 'package:notes_app/sampleDataJSON/JsonForLoadData.dart';
import 'package:notes_app/widgets/NotesWidgets.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {

  late NoteDatabase db;

  Map<String, dynamic> temp_data = jsonFormatDummyData[0];
  //List<Map<String, dynamic>> listOfTempData = jsonFormatDummyData;
  List<Map<String, dynamic>> listOfTempData = [];


  @override
  void initState() {
    print('home initState');

    // listOfTempData.addAll(jsonFormatDummyData);
    //
    // //DB connections
    getDbConnection();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
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
          padding: EdgeInsets.symmetric(horizontal: 10),
          /*child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height:20,),
              Text("Today", style:mDayTextStyle),
              SizedBox(height: 15,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Note, Today TODO's", style:mHeadingTextStyle),
                    SizedBox(height: 8,),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: 20,
                        maxHeight: 80
                      ),
                      child: Text("Jogging, Yoga, Breakfast, Brunch, Movie Time-Jogging, Yoga, Breakfast, Brunch, Movie Time",
                        style: mNoteTextStyle,
                        maxLines: 6,
                        overflow: TextOverflow.ellipsis,
                      )
                    ),
                    SizedBox(height: 16,),
                    Divider(height: 1, thickness: 1, color: Colors.black12,)
                  ],
                )//
              ),
            ],
          ),*/

          child: showListIfContains(listOfTempData),


        ),

        floatingActionButton: FloatingActionButton(
          tooltip: "Add Note",
          child: Icon(Icons.edit, color: Colors.white,),
          splashColor: Colors.white54,
          mini: false,
          onPressed: (){
            Navigator.pushNamed(context, "/newNote");
          },
        ),
      ),
    );
  }


  Widget showListIfContains(List listOfItems){

    if(listOfItems.length < 1){
      return Center(
        child: Text("Add New Note !", style: addNewHeadingTextStyle,),
      );
    }else{
      return Column(
        children: [
          SizedBox(height:20,),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              itemCount: listOfTempData.length,
              itemBuilder: (context, index){
                return  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height:2,),
                    Text("${listOfTempData[index]['day']}", style:mDayTextStyle),
                    SizedBox(height: 10,),
                    Column(children: populateNotesWidget(listOfTempData[index]["heading"], listOfTempData[index]["note"]),)
                  ],
                );
              },
            ),
          ),
        ],
      );
    }
  }




  List<Widget> populateNotesWidget(List<String> headings, List<String> notes) {
    List<Widget> widgetList = [];

    int indexOfItem;
    var head = headings.forEach(
        (item) => {
          indexOfItem = headings.indexOf(item),

          widgetList.add(
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: NoteWidgets(heading: "$item", noteText: "${notes[indexOfItem]}"),
            )
          ),
        }
    );

    return widgetList;
  }

  Future<void> showAllNotesInDb() async{
    var noteList = await this.db.noteDAO.showAllNotes();

    var heading = noteList.map((e) => e.heading).toList();
    var note = noteList.map((e) => e.notes).toList();


    Map<String, dynamic> tempMap = {
      "day": "Today",
      "heading": heading,
      "note": note
    };

    //print('tempMap - $tempMap');

    this.setState(() {
      listOfTempData.add(tempMap);
    });


    print('listOfTempData - ${listOfTempData.length}');
  }


  void getDbConnection() async{
    this.db = await $FloorNoteDatabase.databaseBuilder("NoteDatabase.db").build();

    await showAllNotesInDb();
  }
}

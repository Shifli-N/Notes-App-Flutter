import 'package:flutter/material.dart';
import 'package:notes_app/constants/TextStyleConstant.dart';
import 'package:notes_app/sampleDataJSON/JsonForLoadData.dart';
import 'package:notes_app/src/bloc/NoteBloc.dart';
import 'package:notes_app/src/ui/NotesWidgets.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {

  late dynamic db;

  NoteBloc noteBloc = NoteBloc.getInstance();

  Map<String, dynamic> temp_data = jsonFormatDummyData[0];
  //List<Map<String, dynamic>> listOfTempData = jsonFormatDummyData;
  List<Map<String, dynamic>> listOfTempData = [];


  @override
  void initState() {
    super.initState();
    print('home initState');
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    print('didChangeDependencies is working');

    // listOfTempData.addAll(jsonFormatDummyData);

    //notes in db
    showAllNotesInDb();
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
    var noteList = await noteBloc.showNotesInDb();

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

}

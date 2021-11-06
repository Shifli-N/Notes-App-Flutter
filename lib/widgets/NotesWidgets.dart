import 'package:flutter/material.dart';
import 'package:notes_app/constants/TextStyleConstant.dart';

class NoteWidgets extends StatefulWidget {
  final String heading;
  final String noteText;

  const NoteWidgets({Key? key, required this.heading, required this.noteText}) : super(key: key);

  @override
  _NoteWidgetsState createState() => _NoteWidgetsState();
}

class _NoteWidgetsState extends State<NoteWidgets> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${widget.heading}", style:mHeadingTextStyle),
          SizedBox(height: 8,),
          ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: 20,
                  maxHeight: 80
              ),
              child: Text("${widget.noteText}",
                style: mNoteTextStyle,
                maxLines: 6,
                overflow: TextOverflow.ellipsis,
              )
          ),
          SizedBox(height: 16,),
          Divider(height: 1, thickness: 1, color: Colors.black12,),
          SizedBox(height: 8,),
        ],
      ),
    );
  }
}

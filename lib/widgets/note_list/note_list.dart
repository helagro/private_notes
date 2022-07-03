import 'package:flutter/material.dart';
import 'package:opnot/widgets/note_list/note_list_content.dart';
import '../../logic/note_handler.dart';

class NoteList extends StatefulWidget {
  final Function? onNoteSelected;
  final bool highlightSelectedNote;

  const NoteList(
      {Key? key, this.onNoteSelected, this.highlightSelectedNote = true})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  final int _id = UniqueKey().hashCode;

  @override
  void initState() {
    NoteHandler.addNoteListChangedListener(reloadNoteList, _id);
    super.initState();
  }

  void reloadNoteList() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SizedBox.expand(
      child: Container(
        color: Colors.blue,
        child: NoteListContent(
          onNoteListItemClicked: onNoteListItemClicked,
          highlightSelectedNote: widget.highlightSelectedNote,
        ),
      ),
    ));
  }

  void onNoteListItemClicked(int noteListIndex) {
    setState(() {
      NoteHandler.setSelectedNoteI(noteListIndex);
    });
    widget.onNoteSelected?.call();
  }

  @override
  void dispose() {
    NoteHandler.removeNoteListChangedListener(_id);
    super.dispose();
  }
}

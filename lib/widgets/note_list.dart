import 'package:flutter/material.dart';
import '../logic/note_handler.dart';
import 'note_list_item.dart';

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
        child: ListView.builder(
          itemBuilder: (context, noteListIndex) {
            return NoteListItem(
              onClick: onNoteListItemClicked,
              noteListIndex: noteListIndex,
              isSelected: noteListIndex == NoteHandler.selectedNoteI.value &&
                  widget.highlightSelectedNote,
            );
          },
          itemCount: NoteHandler.notes.length,
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

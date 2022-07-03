import 'package:flutter/material.dart';
import 'package:opnot/logic/dropbox/dropbox_handler.dart';
import 'package:opnot/widgets/text_message.dart';

import '../../logic/note_handler.dart';
import 'note_list_item.dart';

class NoteListContent extends StatelessWidget {
  final void Function(int) onNoteListItemClicked;
  final bool highlightSelectedNote;

  const NoteListContent(
      {Key? key,
      required this.onNoteListItemClicked,
      required this.highlightSelectedNote})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!DropboxHandler.getInstance().fileManager.hasListOfNotes) {
      return const TextMessage("Loading...");
    }

    if (NoteHandler.notes.isEmpty) {
      return const TextMessage("No notes added yet");
    }

    return ListView.builder(
      itemBuilder: (context, noteListIndex) {
        return NoteListItem(
          onClick: onNoteListItemClicked,
          noteListIndex: noteListIndex,
          isSelected: noteListIndex == NoteHandler.selectedNoteI.value &&
              highlightSelectedNote,
        );
      },
      itemCount: NoteHandler.notes.length,
    );
  }
}

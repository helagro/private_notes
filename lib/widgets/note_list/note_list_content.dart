import 'package:flutter/material.dart';
import 'package:opnot/logic/dropbox/dropbox_handler.dart';
import 'package:opnot/widgets/text_message.dart';

import '../../logic/note_handler.dart';
import 'note_list_item.dart';

class NoteListContent extends StatelessWidget {
  final void Function(int) onNoteListItemClicked;
  final bool highlightSelectedNote;
  final ScrollController _scrollController = ScrollController();
  static int _lastKeyboardInputTime = -1;

  NoteListContent(
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

    return RawKeyboardListener(
      focusNode: FocusNode(),
      onKey: highlightSelectedNote ? onKey : (_) {},
      child: ListView.builder(
        itemBuilder: (context, noteListIndex) {
          return NoteListItem(
            onClick: onNoteListItemClicked,
            noteListIndex: noteListIndex,
            isSelected: noteListIndex == NoteHandler.selectedNoteI.value &&
                highlightSelectedNote,
          );
        },
        itemCount: NoteHandler.notes.length,
        controller: _scrollController,
      ),
    );
  }

  void onKey(RawKeyEvent event) {
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    if (currentTime < _lastKeyboardInputTime + 150) return;

    final int selectedNoteI = NoteHandler.selectedNoteI.value;
    switch (event.logicalKey.keyLabel) {
      case "Arrow Down":
        if (selectedNoteI == NoteHandler.notes.length - 1) return;
        onNoteListItemClicked(selectedNoteI + 1);
        break;
      case "Arrow Up":
        if (selectedNoteI == 0) return;
        onNoteListItemClicked(selectedNoteI - 1);
        break;
      default:
        return;
    }
    _lastKeyboardInputTime = currentTime;
  }
}

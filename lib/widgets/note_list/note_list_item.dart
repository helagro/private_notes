import 'package:flutter/material.dart';
import '../../logic/note_handler.dart';

class NoteListItem extends StatelessWidget {
  const NoteListItem(
      {Key? key,
      required this.noteListIndex,
      this.onClick,
      this.isSelected = false})
      : super(key: key);

  final int noteListIndex;
  final void Function(int)? onClick;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isSelected ? Colors.white : Colors.yellow;

    return TextButton(
      style: TextButton.styleFrom(
          textStyle: const TextStyle(fontSize: 24), padding: EdgeInsets.zero),
      onPressed: () => onClick?.call(noteListIndex),
      child: Container(
        color: backgroundColor,
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Text(
            NoteHandler.notes[noteListIndex].title,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}

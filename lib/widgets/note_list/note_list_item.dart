import 'package:flutter/material.dart';
import 'package:opnot/res/colors_main.dart';
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
    final backgroundColor = isSelected
        ? Theme.of(context).colorScheme.tertiaryContainer
        : Theme.of(context).colorScheme.secondaryContainer;

    if (NoteHandler.notes.isEmpty) return Container();

    final String itemText = NoteHandler.notes[noteListIndex].title;

    return Card(
      elevation: isSelected ? 1 : 0.5,
      margin: isSelected
          ? const EdgeInsets.only(bottom: 2, right: 0, left: 0, top: 0.2)
          : const EdgeInsets.all(0),
      child: TextButton(
        style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 24), padding: EdgeInsets.zero),
        onPressed: () => onClick?.call(noteListIndex),
        child: Container(
          color: backgroundColor,
          padding: isSelected
              ? const EdgeInsets.all(10)
              : const EdgeInsets.only(
                  bottom: 12, right: 10, left: 10, top: 10.2),
          child: Center(
            child: Text(
              itemText,
              style: TextStyle(
                  color: isSelected
                      ? ColorsMain.textColorElevated
                      : ColorsMain.textColor),
            ),
          ),
        ),
      ),
    );
  }
}

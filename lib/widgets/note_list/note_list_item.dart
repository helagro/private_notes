import 'package:flutter/material.dart';
import 'package:opnot/res/colors_main.dart';
import 'package:opnot/res/dimensions.dart';
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
        ? ColorsMain.tertiaryContainer
        : ColorsMain.secondaryContainer;

    if (NoteHandler.notes.isEmpty) return Container();

    final String itemText = NoteHandler.notes[noteListIndex].title;

    return Card(
      elevation: isSelected ? Dimensions.elevation6 : Dimensions.elevation5,
      margin: isSelected
          ? const EdgeInsets.only(bottom: 2, right: 1, left: 0, top: 0.2)
          : const EdgeInsets.all(0),
      shape: const ContinuousRectangleBorder(),
      color: backgroundColor,
      child: TextButton(
        style: TextButton.styleFrom(
            alignment: Alignment.centerLeft,
            textStyle: const TextStyle(fontSize: 20),
            padding: const EdgeInsets.only(left: 10)),
        onPressed: () => onClick?.call(noteListIndex),
        child: Container(
          padding: isSelected
              ? const EdgeInsets.all(10)
              : const EdgeInsets.only(
                  bottom: 12, right: 10, left: 10, top: 10.2),
          child: Text(
            itemText,
            textAlign: TextAlign.left,
            style: TextStyle(
                color: isSelected
                    ? ColorsMain.textColorElevated
                    : ColorsMain.textColor),
          ),
        ),
      ),
    );
  }
}

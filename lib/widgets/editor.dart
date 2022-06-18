import 'package:flutter/material.dart';
import 'package:private_notes/logic/note_handler.dart';

class EditorWidget extends StatefulWidget {
  final ValueNotifier selectedNote;

  const EditorWidget({Key? key, required this.selectedNote}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditorWidgetState(selectedNote);
}

class _EditorWidgetState extends State<EditorWidget> {
  final _textEditingController = TextEditingController();
  final ValueNotifier _selectedNote;
  final NoteHandler _noteHandler = NoteHandler.getInstance();

  _EditorWidgetState(this._selectedNote) {
    _selectedNote.addListener(() {
      _textEditingController.text =
          _noteHandler.notes[_selectedNote.value].content;
    });
    _textEditingController.text =
        _noteHandler.notes[_selectedNote.value].content;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SizedBox.expand(
      child: Container(
        padding: const EdgeInsets.all(30),
        color: Colors.red,
        child: TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            controller: _textEditingController,
            onChanged: onTextChange,
            minLines: 2,
            decoration: const InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none)),
      ),
    ));
  }

  void onTextChange(final String text) {
    _noteHandler.notes[_selectedNote.value].content = text;
  }
}

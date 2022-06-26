import 'package:flutter/material.dart';
import 'package:private_notes/logic/note_handler.dart';

class EditorWidget extends StatefulWidget {
  const EditorWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditorWidgetState();
}

class _EditorWidgetState extends State<EditorWidget> {
  final _textEditingController = TextEditingController();

  _EditorWidgetState() {
    NoteHandler.selectedNote.addListener(fillWithNoteContent);
    fillWithNoteContent();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SizedBox.expand(
      child: Container(
        padding: const EdgeInsets.all(30),
        color: Colors.red,
        // child: MarkdownFormField(
        //   emojiConvert: true,
        // )
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

  void fillWithNoteContent() {
    _textEditingController.text = NoteHandler.getCurrentNote()?.content ?? "";
  }

  void onTextChange(final String text) {
    NoteHandler.getCurrentNote()?.content = text;
  }

  @override
  void dispose() {
    NoteHandler.selectedNote.removeListener(fillWithNoteContent);
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:opnot/logic/debug.dart';
import 'package:opnot/logic/dropbox/dropbox_handler.dart';
import 'package:opnot/logic/note_handler.dart';

import '../data_types/note.dart';

class EditorWidget extends StatefulWidget {
  const EditorWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditorWidgetState();
}

class _EditorWidgetState extends State<EditorWidget> {
  final _textEditingController = TextEditingController();
  static final int _noteListChangedListenerId = UniqueKey().hashCode;

  _EditorWidgetState() {
    NoteHandler.selectedNoteI.addListener(fillWithNoteContent);
    NoteHandler.addNoteListChangedListener(
        fillWithNoteContent, _noteListChangedListenerId);
    fillWithNoteContent();
    autoSaveTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SizedBox.expand(
      child: Container(
        padding: const EdgeInsets.all(10),
        color: Theme.of(context).colorScheme.primaryContainer,
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

  void autoSaveTimer() async {
    Note? note = NoteHandler.getCurrentNote();
    if (note != null) {
      DropboxHandler.getFileManager().upload(NoteHandler.getCurrentNote()!);
      Debug.log("Auto saving ”${NoteHandler.getCurrentNote()!.title}”");
    }
    Future.delayed(const Duration(minutes: 3), autoSaveTimer);
  }

  @override
  void dispose() {
    NoteHandler.saveCurrentNote();
    NoteHandler.selectedNoteI.removeListener(fillWithNoteContent);
    NoteHandler.removeNoteListChangedListener(_noteListChangedListenerId);
    super.dispose();
  }
}


import 'package:private_notes/data_types/note.dart';

class NoteHandler{
  static NoteHandler? _instance;
  final List<Note> notes = List.from([Note("t1", "c1"), Note("t2", "c2")]);

  static NoteHandler getInstance(){
    _instance ??= NoteHandler();
    return _instance!;
  }

}
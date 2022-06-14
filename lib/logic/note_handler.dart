
import 'package:private_notes/data_types/note.dart';

class NoteHandler{
  static NoteHandler? _instance;
  final List<Note> notes = List.from([Note("t1", "c1"), Note("t2", "c2")]);
  final List<Function> noteListChangedListeners = List.empty(growable: true);

  static NoteHandler getInstance(){
    _instance ??= NoteHandler();
    return _instance!;
  }

  void addNoteListChangedListener(Function noteListChangedListener){
    noteListChangedListeners.add(noteListChangedListener);
  }

  void addNote(Note note){
    notes.add(note);
    callNoteListChangedListeners();
  }

  void callNoteListChangedListeners(){
    for(final Function noteListChangedListener in noteListChangedListeners){
      noteListChangedListener.call();
    }
  }

}
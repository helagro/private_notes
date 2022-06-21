import 'package:flutter/material.dart';
import 'package:private_notes/data_types/note.dart';

class NoteHandler {
  static NoteHandler? _instance;
  final List<Note> notes =
      List.from([Note("t1", "c1"), Note("t2", "c2"), Note("t3", "c3")]);
  final List<Function> _noteListChangedListeners = List.empty(growable: true);
  final ValueNotifier selectedNote = ValueNotifier(0);

  static NoteHandler getInstance() {
    _instance ??= NoteHandler();
    return _instance!;
  }

  void addNoteListChangedListener(Function noteListChangedListener) {
    _noteListChangedListeners.add(noteListChangedListener);
  }

  void addNote(Note note, {bool? selectNote}) {
    notes.add(note);

    if (selectNote == true) {
      selectedNote.value = notes.length - 1;
    }
    callNoteListChangedListeners();
  }

  void deleteSelectedNote({bool? selectPriorNote}) {
    deleteNote(selectedNote.value, selectPriorNote: selectPriorNote);
  }

  void deleteNote(int noteIndex, {bool? selectPriorNote}) {
    final noteAmtBeforeDelete = notes.length;
    if (noteAmtBeforeDelete == 0) return;

    notes.removeAt(noteIndex);
    callNoteListChangedListeners();

    if (noteAmtBeforeDelete != 1 && selectPriorNote == true) {
      selectedNote.value -= 1;
    }
  }

  void callNoteListChangedListeners() {
    for (final Function noteListChangedListener in _noteListChangedListeners) {
      noteListChangedListener.call();
    }
  }
}

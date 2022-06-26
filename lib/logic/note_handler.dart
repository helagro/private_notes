import 'package:flutter/material.dart';
import 'package:private_notes/data_types/note.dart';
import 'package:private_notes/logic/dropbox_handler.dart';

class NoteHandler {
  static final List<Note> notes = List<Note>.empty(growable: true);
  static final List<Map> _noteListChangedListeners = List.empty(growable: true);
  static final ValueNotifier selectedNoteI = ValueNotifier(0);

  //ANCHOR listeners
  static void addNoteListChangedListener(
      Function noteListChangedListener, int id) {
    _noteListChangedListeners
        .add({"function": noteListChangedListener, "id": id});
  }

  static void removeNoteListChangedListener(int id) {
    for (Map noteListChangedListenerMap in _noteListChangedListeners) {
      if (noteListChangedListenerMap["id"] == id) {
        _noteListChangedListeners.remove(noteListChangedListenerMap);
        return;
      }
    }
  }

  static void callNoteListChangedListeners() {
    for (final Map noteListChangedListenerMap in _noteListChangedListeners) {
      noteListChangedListenerMap["function"].call();
    }
  }

  static void setSelectedNoteI(int index) {
    DropboxHandler dropboxHandler = DropboxHandler.getInstance();
    if (getCurrentNote() != null) dropboxHandler.upload(getCurrentNote()!);

    selectedNoteI.value = index;
    if (!getCurrentNote()!.isLoaded) {
      dropboxHandler
          .fillNoteContent(getCurrentNote()!)
          .then((value) => callNoteListChangedListeners());
    }
  }

  //ANCHOR note list editors
  static void loadNotes() async {
    notes.clear();
    notes.addAll(await DropboxHandler.getInstance().getNotes());
    callNoteListChangedListeners();
  }

  static void addNote(Note note, {bool? selectNote}) {
    notes.add(note);

    if (selectNote == true) {
      selectedNoteI.value = notes.length - 1;
    }
    callNoteListChangedListeners();
  }

  static void deleteSelectedNote({bool? selectPriorNote}) {
    deleteNote(selectedNoteI.value, selectPriorNote: selectPriorNote);
  }

  static void deleteNote(int noteIndex, {bool? selectPriorNote}) {
    if (notes.isEmpty) return;

    notes.removeAt(noteIndex);
    callNoteListChangedListeners();

    if (noteIndex != 0 && selectPriorNote == true) {
      selectedNoteI.value -= 1;
    }
    selectedNoteI.notifyListeners();
  }

  static Note? getCurrentNote() {
    return notes.isNotEmpty ? notes[selectedNoteI.value] : null;
  }
}

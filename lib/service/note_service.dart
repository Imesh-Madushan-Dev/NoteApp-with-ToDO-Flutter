import 'package:hive/hive.dart';
import 'package:notes_sphere/models/note_model.dart';
import 'package:uuid/uuid.dart';

class NoteService {
  //all notes
  List<Note> allNotes = [
    Note(
      id: const Uuid().v4(),
      title: "Meeting Notes",
      category: "Work",
      content:
          "Discussed project deadlines and deliverables. Assigned tasks to team members and set up follow-up meetings to track progress.",
      date: DateTime.now(),
    ),
    Note(
      id: const Uuid().v4(),
      title: "Grocery List",
      category: "Personal",
      content:
          "Bought milk, eggs, bread, fruits, and vegetables from the local grocery store. Also added some snacks for the week.",
      date: DateTime.now(),
    ),
    Note(
      id: const Uuid().v4(),
      title: "Book Recommendations",
      category: "Hobby",
      content:
          "Recently read 'Sapiens' by Yuval Noah Harari, which offered fascinating insights into the history of humankind. Also enjoyed 'Atomic Habits' by James Clear, a practical guide to building good habits and breaking bad ones.",
      date: DateTime.now(),
    ),
  ];

  //* Create the database reference for notes
  final _myBox = Hive.box<Note>("notes");

  //* Check whether the user is new (box is empty)
  Future<bool> isNewUser() async {
    return _myBox.isEmpty;
  }

  //* Method to create the initial notes if the box is empty
  Future<void> createInitialNotes() async {
    if (_myBox.isEmpty) {
      for (var note in allNotes) {
        await _myBox.add(note); // Save each note individually
      }
    }
  }

  //* Method to load the notes
  Future<List<Note>> loadNotes() async {
    final notes = _myBox.values.toList();
    return notes;
  }

  //* Method to add a note
  Future<void> addNote(Note note) async {
    await _myBox.add(note); // Save the new note
  }

  //* Method to calculate the number of notes according to the category
  int getNoOfNotes(String category, List<Note> allNotes) {
    return allNotes.where((note) => note.category == category).length;
  }

  //* Method to get all the categories
  Future<List<String>> getAllCategories() async {
    final List<String> categories = [];
    final allNotes = _myBox.values.toList();
    for (final note in allNotes) {
      if (!categories.contains(note.category)) {
        categories.add(note.category);
      }
    }
    return categories;
  }

  //* Method to get the notes according to the category
  Future<List<Note>> getNotesByCategory(String category) async {
    final allNotes = _myBox.values.toList();
    return allNotes.where((note) => note.category == category).toList();
  }

  //* Loop through all notes and create an object where the key is the category and the value is the notes in that category
  Map<String, List<Note>> getNotesByCategoryMap(List<Note> allNotes) {
    final Map<String, List<Note>> notesByCategory = {};
    for (final note in allNotes) {
      if (notesByCategory.containsKey(note.category)) {
        notesByCategory[note.category]!.add(note);
      } else {
        notesByCategory[note.category] = [note];
      }
    }
    return notesByCategory;
  }

  //* Method to update / edit a note
  Future<void> updateNote(Note note) async {
    final index =
        _myBox.values.toList().indexWhere((element) => element.id == note.id);
    if (index != -1) {
      await _myBox.putAt(index, note); // Update the note at the specified index
    }
  }

  //* Method to delete a note
  Future<void> deleteNote(String noteId) async {
    final index =
        _myBox.values.toList().indexWhere((element) => element.id == noteId);
    if (index != -1) {
      await _myBox.deleteAt(index); // Delete the note at the specified index
    }
  }
}

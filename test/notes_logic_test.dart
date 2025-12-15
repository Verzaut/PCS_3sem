import 'package:flutter_test/flutter_test.dart';
import 'package:simple_notes/models/note.dart';

// Мок для имитации функциональности NotesPage
class MockNotesLogic {
  List<Note> notes = [
    Note(id: '1', title: 'Shopping List', body: 'Milk, Eggs, Bread'),
    Note(id: '2', title: 'Meeting Notes', body: 'Discuss project timeline'),
    Note(id: '3', title: 'Ideas', body: 'Create new app features'),
  ];

  List<Note> filteredNotes = [];

  void filterNotes(String query) {
    if (query.isEmpty) {
      filteredNotes = List.from(notes);
    } else {
      filteredNotes = notes
          .where(
            (note) =>
                note.title.toLowerCase().contains(query.toLowerCase()) ||
                note.body.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    }
  }

  void addNote(Note note) {
    notes.add(note);
  }

  void updateNote(Note updatedNote) {
    final index = notes.indexWhere((n) => n.id == updatedNote.id);
    if (index != -1) {
      notes[index] = updatedNote;
    }
  }

  void deleteNote(String id) {
    notes.removeWhere((n) => n.id == id);
  }
}

void main() {
  group('Notes Logic Tests', () {
    late MockNotesLogic logic;

    setUp(() {
      logic = MockNotesLogic();
    });

    test('Initial state has all notes', () {
      logic.filterNotes('');
      expect(logic.filteredNotes.length, 3);
    });

    test('Filter by exact title match', () {
      logic.filterNotes('Shopping');
      expect(logic.filteredNotes.length, 1);
      expect(logic.filteredNotes[0].title, 'Shopping List');
    });

    test('Filter by partial title match', () {
      logic.filterNotes('List');
      expect(logic.filteredNotes.length, 1);
      expect(logic.filteredNotes[0].title, 'Shopping List');
    });

    test('Filter by body content', () {
      logic.filterNotes('timeline');
      expect(logic.filteredNotes.length, 1);
      expect(logic.filteredNotes[0].title, 'Meeting Notes');
    });

    test('Empty search returns all notes', () {
      logic.filterNotes('');
      expect(logic.filteredNotes.length, 3);
    });

    test('Search with no matches returns empty list', () {
      logic.filterNotes('nonexistent');
      expect(logic.filteredNotes.length, 0);
    });

    test('Search is case insensitive', () {
      logic.filterNotes('SHOPPING');
      expect(logic.filteredNotes.length, 1);
      expect(logic.filteredNotes[0].title, 'Shopping List');
    });

    test('Add new note increases count', () {
      final newNote = Note(id: '4', title: 'New Note', body: 'New Content');
      logic.addNote(newNote);
      expect(logic.notes.length, 4);
      expect(logic.notes.last.id, '4');
    });

    test('Update existing note', () {
      final updated = Note(
        id: '1',
        title: 'Updated Title',
        body: 'Updated Body',
      );
      logic.updateNote(updated);

      final note = logic.notes.firstWhere((n) => n.id == '1');
      expect(note.title, 'Updated Title');
      expect(note.body, 'Updated Body');
    });

    test('Update non-existent note does nothing', () {
      final originalNotes = List.from(logic.notes);
      final updated = Note(id: '999', title: 'Updated', body: 'Body');

      logic.updateNote(updated);

      expect(logic.notes.length, originalNotes.length);
    });

    test('Delete note decreases count', () {
      logic.deleteNote('1');
      expect(logic.notes.length, 2);
      expect(logic.notes.any((n) => n.id == '1'), false);
    });

    test('Delete non-existent note does nothing', () {
      final originalCount = logic.notes.length;
      logic.deleteNote('999');
      expect(logic.notes.length, originalCount);
    });

    test('Filter updates after adding note', () {
      logic.filterNotes('Shopping');
      expect(logic.filteredNotes.length, 1);

      logic.addNote(Note(id: '4', title: 'Shopping', body: 'More items'));
      logic.filterNotes('Shopping');
      expect(logic.filteredNotes.length, 2);
    });

    test('Filter updates after deleting note', () {
      logic.filterNotes('Shopping');
      expect(logic.filteredNotes.length, 1);

      logic.deleteNote('1');
      logic.filterNotes('Shopping');
      expect(logic.filteredNotes.length, 0);
    });
  });
}

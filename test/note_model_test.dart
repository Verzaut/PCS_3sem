import 'package:flutter_test/flutter_test.dart';
import 'package:safe_notes/models/note.dart';

void main() {
  group('Note Model Tests', () {
    test('Note creation with valid data', () {
      final note = Note(id: '1', title: 'Test Title', body: 'Test Body');

      expect(note.id, '1');
      expect(note.title, 'Test Title');
      expect(note.body, 'Test Body');
    });

    test('Note copyWith creates new instance with updated fields', () {
      final original = Note(id: '1', title: 'Original', body: 'Body');
      final copied = original.copyWith(title: 'Updated');

      expect(copied.id, '1');
      expect(copied.title, 'Updated');
      expect(copied.body, 'Body');
      expect(original.title, 'Original'); // Original unchanged
    });

    test('Note copyWith with all fields', () {
      final original = Note(id: '1', title: 'Original', body: 'Body');
      final copied = original.copyWith(title: 'New Title', body: 'New Body');

      expect(copied.id, '1');
      expect(copied.title, 'New Title');
      expect(copied.body, 'New Body');
    });

    test('Note with empty title', () {
      final note = Note(id: '1', title: '', body: 'Body');
      expect(note.title, '');
      expect(note.body, 'Body');
    });

    test('Note with empty body', () {
      final note = Note(id: '1', title: 'Title', body: '');
      expect(note.title, 'Title');
      expect(note.body, '');
    });

    test('Note with very long title', () {
      final longTitle = 'A' * 1000;
      final note = Note(id: '1', title: longTitle, body: 'Body');
      expect(note.title.length, 1000);
    });

    test('Note with very long body', () {
      final longBody = 'B' * 10000;
      final note = Note(id: '1', title: 'Title', body: longBody);
      expect(note.body.length, 10000);
    });
  });
}

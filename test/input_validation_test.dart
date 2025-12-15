import 'package:flutter_test/flutter_test.dart';

class EditNoteValidation {
  static String? validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Заголовок не может быть пустым';
    }
    if (value.trim().length > 200) {
      return 'Заголовок слишком длинный (макс. 200 символов)';
    }
    return null;
  }

  static String? validateBody(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Введите текст заметки';
    }
    if (value.trim().length > 10000) {
      return 'Текст слишком длинный (макс. 10000 символов)';
    }
    return null;
  }

  static String? validateSearch(String? value) {
    if (value != null && value.length > 100) {
      return 'Слишком длинный поисковый запрос';
    }
    return null;
  }
}

void main() {
  group('Input Validation Tests', () {
    test('Empty title returns error', () {
      expect(
        EditNoteValidation.validateTitle(''),
        'Заголовок не может быть пустым',
      );
      expect(
        EditNoteValidation.validateTitle('   '),
        'Заголовок не может быть пустым',
      );
      expect(
        EditNoteValidation.validateTitle(null),
        'Заголовок не может быть пустым',
      );
    });

    test('Valid title returns null', () {
      expect(EditNoteValidation.validateTitle('Valid Title'), null);
      expect(EditNoteValidation.validateTitle('T'), null);
    });

    test('Title too long returns error', () {
      final longTitle = 'A' * 201;
      expect(
        EditNoteValidation.validateTitle(longTitle),
        'Заголовок слишком длинный (макс. 200 символов)',
      );
    });

    test('Title at max length is valid', () {
      final maxLengthTitle = 'A' * 200;
      expect(EditNoteValidation.validateTitle(maxLengthTitle), null);
    });

    test('Empty body returns error', () {
      expect(EditNoteValidation.validateBody(''), 'Введите текст заметки');
      expect(EditNoteValidation.validateBody('   '), 'Введите текст заметки');
      expect(EditNoteValidation.validateBody(null), 'Введите текст заметки');
    });

    test('Valid body returns null', () {
      expect(EditNoteValidation.validateBody('Valid body text'), null);
      expect(EditNoteValidation.validateBody('Single word'), null);
    });

    test('Body too long returns error', () {
      final longBody = 'B' * 10001;
      expect(
        EditNoteValidation.validateBody(longBody),
        'Текст слишком длинный (макс. 10000 символов)',
      );
    });

    test('Body at max length is valid', () {
      final maxLengthBody = 'B' * 10000;
      expect(EditNoteValidation.validateBody(maxLengthBody), null);
    });

    test('Search query validation', () {
      expect(EditNoteValidation.validateSearch('normal query'), null);
      expect(EditNoteValidation.validateSearch(''), null);
      expect(EditNoteValidation.validateSearch(null), null);

      final longQuery = 'Q' * 101;
      expect(
        EditNoteValidation.validateSearch(longQuery),
        'Слишком длинный поисковый запрос',
      );
    });

    test('Search with spaces and special characters is valid', () {
      expect(EditNoteValidation.validateSearch('query with spaces'), null);
      expect(EditNoteValidation.validateSearch('query!@#\$%'), null);
      expect(EditNoteValidation.validateSearch('123 numbers'), null);
    });
  });
}

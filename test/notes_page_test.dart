import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:safe_notes/main.dart';

void main() {
  // Хелпер для поиска текста только внутри ListTile
  Finder findNoteTitle(String text) {
    return find.descendant(
      of: find.byType(ListTile),
      matching: find.text(text),
    );
  }

  // Хелпер для поиска текста только внутри подзаголовка ListTile
  Finder findNoteBody(String text) {
    final listTiles = find.byType(ListTile);
    return find.descendant(of: listTiles, matching: find.text(text));
  }

  testWidgets('App launches and shows initial note', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const SimpleNotesApp());

    expect(find.text('Simple Notes'), findsOneWidget);
    expect(findNoteTitle('Пример'), findsOneWidget);
    expect(findNoteBody('Это пример заметки'), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
  });

  testWidgets('FloatingActionButton opens edit page', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const SimpleNotesApp());

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    expect(find.text('Новая заметка'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.text('Заголовок'), findsOneWidget);
    expect(find.text('Текст'), findsOneWidget);
    expect(find.text('Сохранить'), findsOneWidget);
    expect(find.byIcon(Icons.check), findsOneWidget);
  });

  testWidgets('Create new note with valid data', (WidgetTester tester) async {
    await tester.pumpWidget(const SimpleNotesApp());

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Заголовок'),
      'Купить продукты',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Текст'),
      'Молоко, хлеб, яйца',
    );
    await tester.pump();

    await tester.tap(find.text('Сохранить'));
    await tester.pumpAndSettle();

    expect(find.text('Simple Notes'), findsOneWidget);
    expect(findNoteTitle('Купить продукты'), findsOneWidget);
    expect(findNoteBody('Молоко, хлеб, яйца'), findsOneWidget);
  });

  testWidgets('Create note with empty body shows validation error', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const SimpleNotesApp());

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Заголовок'),
      'Заметка без текста',
    );
    await tester.pump();

    await tester.tap(find.text('Сохранить'));
    await tester.pump();

    expect(find.text('Введите текст заметки'), findsOneWidget);
    expect(find.text('Новая заметка'), findsOneWidget);
  });

  testWidgets('Edit existing note', (WidgetTester tester) async {
    await tester.pumpWidget(const SimpleNotesApp());

    // Нажимаем на существующую заметку
    await tester.tap(findNoteTitle('Пример'));
    await tester.pumpAndSettle();

    expect(find.text('Редактировать'), findsOneWidget);

    // Редактируем заголовок
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Пример'),
      'Обновленный заголовок',
    );
    await tester.pump();

    await tester.tap(find.text('Сохранить'));
    await tester.pumpAndSettle();

    // Проверяем обновление
    expect(findNoteTitle('Обновленный заголовок'), findsOneWidget);
    expect(findNoteTitle('Пример'), findsNothing);
  });

  testWidgets('Search functionality works', (WidgetTester tester) async {
    await tester.pumpWidget(const SimpleNotesApp());

    // Включаем поиск
    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();

    // Вводим текст поиска
    await tester.enterText(find.byType(TextField).first, 'Пример');
    await tester.pump();

    // Проверяем, что заметка найдена
    expect(findNoteTitle('Пример'), findsOneWidget);

    // Проверяем кнопку очистки
    expect(find.byIcon(Icons.clear), findsOneWidget);
  });

  testWidgets('Search clears when clear button is pressed', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const SimpleNotesApp());

    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();

    // Вводим текст
    await tester.enterText(find.byType(TextField).first, 'Пример');
    await tester.pump();

    // Очищаем поиск
    await tester.tap(find.byIcon(Icons.clear));
    await tester.pumpAndSettle();

    // После очистки все заметки должны отображаться
    expect(findNoteTitle('Пример'), findsOneWidget);

    // Проверяем, что поле поиска очищено
    final textFields = tester.widgetList<TextField>(find.byType(TextField));
    bool isSearchFieldEmpty = false;
    for (final field in textFields) {
      if (field.decoration?.hintText == 'Поиск...') {
        isSearchFieldEmpty = field.controller?.text.isEmpty ?? true;
        break;
      }
    }
    expect(isSearchFieldEmpty, isTrue);
  });

  testWidgets('Delete note using delete button', (WidgetTester tester) async {
    await tester.pumpWidget(const SimpleNotesApp());

    // Проверяем, что заметка есть
    expect(findNoteTitle('Пример'), findsOneWidget);

    // Нажимаем кнопку удаления
    await tester.tap(find.byIcon(Icons.delete_outline).first);
    await tester.pumpAndSettle();

    // Проверяем удаление
    expect(findNoteTitle('Пример'), findsNothing);
    expect(find.text('Пока нет заметок. Нажмите +'), findsOneWidget);
  });

  testWidgets('Delete note by swipe gesture', (WidgetTester tester) async {
    await tester.pumpWidget(const SimpleNotesApp());

    // Находим заметку и свайпаем
    final noteTile = findNoteTitle('Пример');
    await tester.drag(noteTile, const Offset(-500, 0));
    await tester.pumpAndSettle();

    // Проверяем удаление
    expect(findNoteTitle('Пример'), findsNothing);
  });

  testWidgets('Empty state shows correct message', (WidgetTester tester) async {
    await tester.pumpWidget(const SimpleNotesApp());

    // Удаляем заметку
    await tester.tap(find.byIcon(Icons.delete_outline).first);
    await tester.pumpAndSettle();

    // Проверяем сообщение
    expect(find.text('Пока нет заметок. Нажмите +'), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });

  testWidgets('Search empty state shows correct message', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const SimpleNotesApp());

    // Включаем поиск
    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();

    // Ищем несуществующее
    await tester.enterText(
      find.byType(TextField).first,
      'несуществующий текст',
    );
    await tester.pumpAndSettle();

    // Проверяем сообщение
    expect(find.text('Заметки не найдены'), findsOneWidget);
  });

  testWidgets('Note with empty title shows placeholder', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const SimpleNotesApp());

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    // Вводим только текст
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Текст'),
      'Текст без заголовка',
    );
    await tester.pump();

    await tester.tap(find.text('Сохранить'));
    await tester.pumpAndSettle();

    // Проверяем заглушку
    expect(findNoteTitle('(без названия)'), findsOneWidget);
    expect(findNoteBody('Текст без заголовка'), findsOneWidget);
  });
}

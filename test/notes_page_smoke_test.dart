import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_notes/main.dart';

void main() {
  testWidgets('App renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const SimpleNotesApp());

    // Проверяем заголовок
    expect(find.text('Simple Notes'), findsOneWidget);

    // Проверяем, что начальная заметка есть в списке
    expect(find.text('Пример'), findsOneWidget);

    // Проверяем наличие кнопки добавления
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });

  testWidgets('Add note flow works', (WidgetTester tester) async {
    await tester.pumpWidget(const SimpleNotesApp());

    // Открыть форму добавления
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Заполнить форму
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Заголовок'),
      'Test Note',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Текст'),
      'Test content',
    );
    await tester.pump();

    // Сохранить
    await tester.tap(find.text('Сохранить'));
    await tester.pumpAndSettle();

    // Проверить результат - ищем заметку в ListTile
    expect(
      find.descendant(
        of: find.byType(ListTile),
        matching: find.text('Test Note'),
      ),
      findsOneWidget,
    );
  });

  testWidgets('Search functionality', (WidgetTester tester) async {
    await tester.pumpWidget(const SimpleNotesApp());

    // Включить поиск
    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();

    // Искать заметку
    await tester.enterText(find.byType(TextField), 'Пример');
    await tester.pump();

    // Проверяем, что заметка найдена (в ListTile)
    expect(
      find.descendant(of: find.byType(ListTile), matching: find.text('Пример')),
      findsOneWidget,
    );
  });

  testWidgets('Delete note', (WidgetTester tester) async {
    await tester.pumpWidget(const SimpleNotesApp());

    // Ищем и нажимаем кнопку удаления для первой заметки
    await tester.tap(find.byIcon(Icons.delete_outline).first);
    await tester.pumpAndSettle();

    // После удаления проверяем сообщение о пустом списке
    expect(find.text('Пока нет заметок. Нажмите +'), findsOneWidget);
  });
}

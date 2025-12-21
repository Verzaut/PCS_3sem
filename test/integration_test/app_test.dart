import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:safe_notes/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('End-to-end тесты приложения заметок', () {
    testWidgets('Запуск приложения и проверка начального экрана', (
      WidgetTester tester,
    ) async {
      // Запускаем приложение
      app.main();
      await tester.pumpAndSettle();

      // Проверяем заголовок приложения
      expect(find.text('Simple Notes'), findsOneWidget);

      // Проверяем наличие начальной заметки
      expect(find.text('Пример'), findsOneWidget);
      expect(find.text('Это пример заметки'), findsOneWidget);

      // Проверяем наличие кнопки добавления
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets('Создание новой заметки', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Нажимаем кнопку добавления
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      // Проверяем, что открылась форма создания
      expect(find.text('Новая заметка'), findsOneWidget);

      // Заполняем форму
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Заголовок'),
        'Покупки на неделю',
      );
      await tester.pump();

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Текст'),
        'Молоко, хлеб, яйца, сыр, фрукты',
      );
      await tester.pump();

      // Сохраняем заметку
      await tester.tap(find.text('Сохранить'));
      await tester.pumpAndSettle();

      // Проверяем, что заметка добавлена
      expect(find.text('Покупки на неделю'), findsOneWidget);
      expect(find.text('Молоко, хлеб, яйца, сыр, фрукты'), findsOneWidget);
    });

    testWidgets('Редактирование существующей заметки', (
      WidgetTester tester,
    ) async {
      app.main();
      await tester.pumpAndSettle();

      // Нажимаем на существующую заметку для редактирования
      await tester.tap(find.text('Пример').first);
      await tester.pumpAndSettle();

      // Проверяем форму редактирования
      expect(find.text('Редактировать'), findsOneWidget);

      // Редактируем заголовок
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Пример'),
        'Отредактированная заметка',
      );
      await tester.pump();

      // Редактируем текст
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Это пример заметки'),
        'Это обновленный текст заметки',
      );
      await tester.pump();

      // Сохраняем изменения
      await tester.tap(find.text('Сохранить'));
      await tester.pumpAndSettle();

      // Проверяем изменения
      expect(find.text('Отредактированная заметка'), findsOneWidget);
      expect(find.text('Это обновленный текст заметки'), findsOneWidget);
    });

    testWidgets('Поиск заметок', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Добавляем еще одну заметку для поиска
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Заголовок'),
        'Важная встреча',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Текст'),
        'Обсудить новый проект в 15:00',
      );
      await tester.pump();

      await tester.tap(find.text('Сохранить'));
      await tester.pumpAndSettle();

      // Включаем поиск
      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      // Ищем заметку по заголовку
      await tester.enterText(find.byType(TextField), 'Важная');
      await tester.pumpAndSettle();

      // Проверяем, что найдена нужная заметка
      expect(find.text('Важная встреча'), findsOneWidget);
      expect(find.text('Обсудить новый проект в 15:00'), findsOneWidget);

      // Ищем несуществующую заметку
      await tester.enterText(find.byType(TextField), 'несуществующий');
      await tester.pumpAndSettle();

      // Проверяем сообщение "не найдено"
      expect(find.text('Заметки не найдены'), findsOneWidget);
    });

    testWidgets('Удаление заметки через кнопку удаления', (
      WidgetTester tester,
    ) async {
      app.main();
      await tester.pumpAndSettle();

      // Создаем заметку для удаления
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Заголовок'),
        'Заметка для удаления',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Текст'),
        'Эту заметку нужно удалить',
      );
      await tester.pump();

      await tester.tap(find.text('Сохранить'));
      await tester.pumpAndSettle();

      // Проверяем, что заметка создана
      expect(find.text('Заметка для удаления'), findsOneWidget);

      // Удаляем заметку через кнопку
      await tester.tap(find.byIcon(Icons.delete_outline).last);
      await tester.pumpAndSettle();

      // Проверяем, что заметка удалена
      expect(find.text('Заметка для удаления'), findsNothing);
    });

    testWidgets('Удаление заметки свайпом', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Создаем заметку для удаления свайпом
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Заголовок'),
        'Заметка для свайпа',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Текст'),
        'Удалить свайпом',
      );
      await tester.pump();

      await tester.tap(find.text('Сохранить'));
      await tester.pumpAndSettle();

      // Находим заметку и свайпаем
      final noteTile = find.text('Заметка для свайпа').first;
      await tester.drag(noteTile, const Offset(-500, 0));
      await tester.pumpAndSettle();

      // Проверяем удаление
      expect(find.text('Заметка для свайпа'), findsNothing);
    });

    testWidgets('Полный сценарий: создание, редактирование, удаление', (
      WidgetTester tester,
    ) async {
      app.main();
      await tester.pumpAndSettle();

      // 1. Создаем заметку
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Заголовок'),
        'Тестовая заметка',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Текст'),
        'Исходный текст',
      );
      await tester.pump();

      await tester.tap(find.text('Сохранить'));
      await tester.pumpAndSettle();

      expect(find.text('Тестовая заметка'), findsOneWidget);

      // 2. Редактируем заметку
      await tester.tap(find.text('Тестовая заметка').first);
      await tester.pumpAndSettle();

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Тестовая заметка'),
        'Обновленная заметка',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Исходный текст'),
        'Обновленный текст',
      );
      await tester.pump();

      await tester.tap(find.text('Сохранить'));
      await tester.pumpAndSettle();

      expect(find.text('Обновленная заметка'), findsOneWidget);
      expect(find.text('Обновленный текст'), findsOneWidget);

      // 3. Ищем заметку
      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'Обновленная');
      await tester.pumpAndSettle();

      expect(find.text('Обновленная заметка'), findsOneWidget);

      // 4. Удаляем заметку
      await tester.tap(find.byIcon(Icons.delete_outline).last);
      await tester.pumpAndSettle();

      expect(find.text('Обновленная заметка'), findsNothing);
    });

    testWidgets('Создание заметки с пустым заголовком', (
      WidgetTester tester,
    ) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      // Оставляем заголовок пустым, заполняем только текст
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Текст'),
        'Текст без заголовка',
      );
      await tester.pump();

      await tester.tap(find.text('Сохранить'));
      await tester.pumpAndSettle();

      // Проверяем, что заметка создалась с заглушкой
      expect(find.text('(без названия)'), findsOneWidget);
      expect(find.text('Текст без заголовка'), findsOneWidget);
    });

    testWidgets('Валидация пустого тела заметки', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      // Заполняем только заголовок
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Заголовок'),
        'Заголовок без текста',
      );
      await tester.pump();

      await tester.tap(find.text('Сохранить'));
      await tester.pump();

      // Проверяем сообщение об ошибке
      expect(find.text('Введите текст заметки'), findsOneWidget);

      // Добавляем текст и сохраняем
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Текст'),
        'Теперь есть текст',
      );
      await tester.pump();

      await tester.tap(find.text('Сохранить'));
      await tester.pumpAndSettle();

      // Проверяем успешное сохранение
      expect(find.text('Заголовок без текста'), findsOneWidget);
    });
  });
}

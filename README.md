Практическая 5 Хайров Матвей Артёмович ЭФБО-06-23
Цели ПЗ: 
1) Создать заметки с помощью Flutter-приложения
2) Научится использовать ListView.builder и отработать работу с виджитами состояния такие как: StatefulWidget
3) Отработать работу с формами и валидацией

<img width="697" height="40" alt="image" src="https://github.com/user-attachments/assets/5f07dc53-dd41-4f93-8747-e698ad4832f4" />
<img width="684" height="114" alt="image" src="https://github.com/user-attachments/assets/0d25ce59-1105-4bb0-9589-0d26850a219f" />
<img width="896" height="464" alt="image" src="https://github.com/user-attachments/assets/6336b17d-ebca-44f7-9f24-7bd0920a68ce" />
<img width="468" height="1042" alt="image" src="https://github.com/user-attachments/assets/552ba0a0-8b96-41cf-9145-b4f4772af269" />
<img width="480" height="1053" alt="image" src="https://github.com/user-attachments/assets/a98d2885-1057-4268-82fc-36297964001d" />
<img width="480" height="1045" alt="image" src="https://github.com/user-attachments/assets/29d6388b-bd83-4ac9-b8a7-a6a23ba1ab77" />
<img width="476" height="1045" alt="image" src="https://github.com/user-attachments/assets/598361d8-a7fc-4995-9a90-c799a080ada4" />
<img width="485" height="997" alt="image" src="https://github.com/user-attachments/assets/b1e88a99-62c1-4e98-a5e5-6408053d4210" />

1)ListView.builder создает элементы списка по мере прокрутки, а ListView(children: [...]) создает все элементы сразу.
2)Передаете объект через конструктор нового экрана, а возвращаете через Navigator.pop(context, обновленныйОбъект). На исходном экране используйте await Navigator.push() чтобы получить результат. Если вернулся не null - обновите данные через setState().
3)Key помогают Flutter правильно идентифицировать элементы при изменениях списка.
4)Самый простой способ - кнопка удаления в trailing ListTile. В onPressed вызываете setState() и удаляете элемент из списка по индексу или id.
5)Данные в памяти изменятся, но интерфейс останется прежним.
6)Использовать временную метку: DateTime.now().microsecondsSinceEpoch.toString().

# restaurant_critic

Хайров Матвей Артемович ЭФБО-06-23

Отчет по проекту приложения "Ресторанный критик"

1. Общее описание системы

Платформа для ресторанных критиков и любителей кулинарии с возможностью:

Публикации рецензий на рестораны

Оценки заведений

Управления профилями пользователей

2. Основные сущности системы

Пользователь 

id (UUID, primary key)
email (уникальный)
username (уникальный)
created_at
role (critic, regular, admin)
favorite_cuisines[]

Ресторан 

id (UUID, primary key)
name
description
address
phone
cuisine_types[]
average_rating 
photos_urls[]
created_at

Рецензия

id (UUID, primary key)
restaurant_id (foreign key)
author_id (foreign key)
rating (1-5)
content
visit_date

Комментарий

id (UUID, primary key)
review_id (foreign key)
content

3. Функциональные требования

Аутентификация и авторизация:
Регистрация/вход через email
Восстановление пароля
Управление профилем


4. Хранение файлов: Supabase Storage

Бакеты: restaurant-photos, review-photos, avatars
Правила доступа через RLS

5. Безопасность

Row Level Security (RLS):
Все таблицы с включенным RLS
Политики для разных ролей
Валидация данных через check constraints

ERD диаграмма:


<img width="1155" height="887" alt="image" src="https://github.com/user-attachments/assets/52a341a8-9bd2-419a-a423-abfd754e20bc" />


Скриншоты приложения:

1-я страница вход(там же есть возможность регистрации)

<img width="565" height="1280" alt="image" src="https://github.com/user-attachments/assets/fada309e-1b82-4234-be0d-16f307b8a21c" />


2-я страница это главный экран где можно добавлять отзывы на рестораны

<img width="565" height="1280" alt="image" src="https://github.com/user-attachments/assets/d660e96b-774c-45ab-8c99-3d5941fba1ad" />


3-я страница создание нового ресторана

<img width="565" height="1280" alt="image" src="https://github.com/user-attachments/assets/d9bbd792-81b3-45d5-aacf-e30966b19678" />


После добавления нового ресторана и сохранения его главная страница будет выглядить примерно так 

<img width="565" height="1280" alt="image" src="https://github.com/user-attachments/assets/965b6538-6513-4970-8994-5b275e297ff3" />


Также если пользователь еще не зарегистрирован в системе есть страница с регистрацией 

<img width="565" height="1280" alt="image" src="https://github.com/user-attachments/assets/9cab4aa8-31ce-493e-82df-f670c87de4f6" />

Возможные улучшения в проекте:
1) Можно переделать регистрацию чтобы была возможность создавать учетку через мессенджер VK и Max
2) Также добавить более разнообразную сортировку
3) Добавить карту с местонахождением ресторанов
4) Возможность добавить форум для общения пользователей
5) Сделать дизайн более строгим и утонченным

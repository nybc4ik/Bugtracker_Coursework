#     Bugtracker_Coursework

# Сущности базы данных «Планировщик задач / Баг-трекер» 

## 1. users — Пользователи
| Атрибут | Тип данных | Обоснование |
| :--- | :--- | :--- |
| `id` | INT, PK, AUTO_INCREMENT | Уникальный идентификатор. |
| `username` | VARCHAR(100), UNIQUE, NOT NULL | Логин (может быть email или длинным корпоративным ID). |
| `email` | VARCHAR(100), UNIQUE, NOT NULL | Для уведомлений и восстановления пароля. |
| `password_hash` | VARCHAR(255), NOT NULL | Хеш пароля (безопасность). |
| `role` | VARCHAR(20), NOT NULL, DEFAULT 'developer' | Роль: 'admin', 'manager', 'developer', 'tester'. |
| `created_at` | TIMESTAMP, DEFAULT NOW() | Дата регистрации. |

## 2. teams — Команды
| Атрибут | Тип данных | Обоснование |
| :--- | :--- | :--- |
| `id` | INT, PK, AUTO_INCREMENT | |
| `name` | VARCHAR(100), UNIQUE, NOT NULL | Название команды. |
| `description` | TEXT, NULLABLE | Описание деятельности. |
| `lead_id` | INT, FK -> users.id, NULLABLE | Лидер/менеджер команды. |
| `created_at` | TIMESTAMP, DEFAULT NOW() | |

## 3. team_members — Состав команд
| Атрибут | Тип данных | Обоснование |
| :--- | :--- | :--- |
| `team_id` | INT, FK -> teams.id, NOT NULL | |
| `user_id` | INT, FK -> users.id, NOT NULL | |
| `joined_at` | TIMESTAMP, DEFAULT NOW() | |
| **PRIMARY KEY** | (`team_id`, `user_id`) | Гарантирует уникальность вступления. |

## 4. projects — Проекты
| Атрибут | Тип данных | Обоснование |
| :--- | :--- | :--- |
| `id` | INT, PK, AUTO_INCREMENT | |
| `name` | VARCHAR(150), NOT NULL | Название проекта. |
| `description` | TEXT, NULLABLE | |
| `team_id` | INT, FK -> teams.id, NULLABLE | Проект может быть привязан к команде. |
| `owner_id` | INT, FK -> users.id, NOT NULL | Создатель/менеджер проекта. |
| `created_at` | TIMESTAMP, DEFAULT NOW() | |
| `deadline` | DATE, NULLABLE | Крайний срок. |

## 5. issues — Задачи
| Атрибут | Тип данных | Обоснование |
| :--- | :--- | :--- |
| `id` | INT, PK, AUTO_INCREMENT | |
| `title` | VARCHAR(255), NOT NULL | Краткое описание. |
| `description` | TEXT, NULLABLE | Подробности, шаги воспроизведения. |
| `project_id` | INT, FK -> projects.id, NOT NULL | **Обязательная** привязка к проекту (используется проект «Без проекта» при необходимости). |
| `type_id` | INT, FK -> issue_types.id, NOT NULL | Тип задачи: баг, фича, улучшение и т.д. |
| `author_id` | INT, FK -> users.id, NOT NULL | Автор задачи. |
| `assignee_id` | INT, FK -> users.id, NULLABLE | Исполнитель (один). NULL – не назначен. |
| `status_id` | INT, FK -> statuses.id, NOT NULL | Текущий статус. |
| `priority_id` | INT, FK -> priorities.id, NOT NULL | Приоритет. |
| `is_active` | BOOLEAN, NOT NULL, DEFAULT TRUE | Флаг мягкого удаления (FALSE – задача скрыта). |
| `created_at` | TIMESTAMP, DEFAULT NOW() | |
| `updated_at` | TIMESTAMP, DEFAULT NOW() ON UPDATE | Автоматическое обновление при изменении. |

## 6. comments — Комментарии
| Атрибут | Тип данных | Обоснование |
| :--- | :--- | :--- |
| `id` | INT, PK, AUTO_INCREMENT | |
| `issue_id` | INT, FK -> issues.id, NOT NULL | К какой задаче. |
| `author_id` | INT, FK -> users.id, NOT NULL | Автор. |
| `body` | TEXT, NOT NULL | Содержание. |
| `created_at` | TIMESTAMP, DEFAULT NOW() | |

## 7. statuses — Статусы задач
| Атрибут | Тип данных | Обоснование |
| :--- | :--- | :--- |
| `id` | INT, PK, AUTO_INCREMENT | |
| `name` | VARCHAR(50), UNIQUE, NOT NULL | «Открыто», «В работе», «Закрыто». |
| `sort_order` | INT, DEFAULT 0 | Порядок колонок на доске. |

## 8. priorities — Приоритеты
| Атрибут | Тип данных | Обоснование |
| :--- | :--- | :--- |
| `id` | INT, PK, AUTO_INCREMENT | |
| `name` | VARCHAR(50), UNIQUE, NOT NULL | «Низкий», «Средний», «Высокий», «Критичный». |
| `level` | INT, NOT NULL | Числовой вес (1-4). |

## 9. issue_types — Типы задач
| Атрибут | Тип данных | Обоснование |
| :--- | :--- | :--- |
| `id` | INT, PK, AUTO_INCREMENT | |
| `name` | VARCHAR(50), UNIQUE, NOT NULL | «Баг», «Фича», «Улучшение», «Технический долг». |
| `description` | VARCHAR(255), NULLABLE | Что значит этот тип. |

## 10. issue_history — История изменений задач
| Атрибут | Тип данных | Обоснование |
| :--- | :--- | :--- |
| `id` | INT, PK, AUTO_INCREMENT | |
| `issue_id` | INT, FK -> issues.id, NOT NULL | По какой задаче изменение. |
| `user_id` | INT, FK -> users.id, NOT NULL | Кто внёс изменение. |
| `changed_at` | TIMESTAMP, DEFAULT NOW() | Когда произошло изменение. |
| `field_name` | VARCHAR(50), NOT NULL | Какое поле: 'status', 'assignee', 'priority', 'title' и т.д. |
| `old_value` | VARCHAR(255), NULLABLE | Предыдущее значение (NULL – если поле было пустым). |
| `new_value` | VARCHAR(255), NULLABLE | Новое значение. |




Диаграма 
Table users {
  id integer [pk, increment]
  first_name varchar [not null]
  last_name varchar [not null]
  patronymic varchar
  email varchar [unique, not null]
  created_at timestamp
}

Table projects {
  id integer [pk, increment]
  name varchar [not null]
  description text
  created_at timestamp
}

Table issues {
  id integer [pk, increment]
  title varchar [not null]
  description text
  created_at timestamp
  project_id integer [not null]
}

Table teams {
  id integer [pk, increment]
  name varchar [not null]
  description text
  created_at timestamp
}

Table project_members {
  id integer [pk, increment]
  user_id integer [not null]    // ← ПРЯМАЯ СВЯЗЬ!
  project_id integer [not null] // ← ПРЯМАЯ СВЯЗЬ!
  role varchar
  joined_at timestamp
}

Table team_members {
  id integer [pk, increment]
  user_id integer [not null]
  team_id integer [not null]
  role varchar
  joined_at timestamp
}

Table team_projects {
  id integer [pk, increment]
  team_id integer [not null]
  project_id integer [not null]
  assigned_at timestamp
}

Table comments {
  id integer [pk, increment]
  text text [not null]
  issue_id integer [not null]
  user_id integer [not null]
  created_at timestamp
}

// СВЯЗИ:
Ref: project_members.user_id > users.id
Ref: project_members.project_id > projects.id
Ref: issues.project_id > projects.id
Ref: comments.user_id > users.id
Ref: comments.issue_id > issues.id
Ref: team_members.user_id > users.id
Ref: team_members.team_id > teams.id
Ref: team_projects.team_id > teams.id
Ref: team_projects.project_id > projects.id


https://dbdiagram.io/d
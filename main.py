# main.py
import sys
from database import init_db, add_user, get_all_users

def main():
    try:
        print("🔧 Инициализация базы данных...")
        init_db()
        print("✅ Таблица users готова.")

        print("\n➕ Добавляем тестовых пользователей...")
        id1 = add_user("Иван", "Петров", "Сергеевич")
        id2 = add_user("Анна", "Сидорова")
        print(f"Созданы записи с id={id1}, id={id2}")

        print("\n📋 Список пользователей:")
        users = get_all_users()
        for u in users:
            print(f"  [{u['id']}] {u['last_name']} {u['first_name']} {u.get('patronymic', '')}")

    except Exception as e:
        print(f"❌ Критическая ошибка: {e}", file=sys.stderr)
        sys.exit(1)

if __name__ == "__main__":
    main()
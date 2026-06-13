# test.py — тестирование всех 8 таблиц БД
import sys
from database import init_db, get_connection

def main():
    try:
        print("Инициализация базы данных...")
        init_db()

        print("\nПроверка таблиц:")
        conn = get_connection()
        cursor = conn.cursor()
        
        # Получаем список всех таблиц (исключаем sqlite_sequence)
        cursor.execute("SELECT name FROM sqlite_master WHERE type='table' AND name != 'sqlite_sequence' ORDER BY name")
        tables = cursor.fetchall()
        conn.close()
        
        print(f"Найдено таблиц: {len(tables)}")
        for t in tables:
            print(f"  - {t['name']}")
        
        if len(tables) != 8:
            print(f"Внимание: ожидается 8 таблиц, найдено {len(tables)}")
            sys.exit(1)
        
        print("\nВсе 8 таблиц созданы успешно!")
        
    except Exception as e:
        print(f"Критическая ошибка: {e}", file=sys.stderr)
        sys.exit(1)

if __name__ == "__main__":
    main()
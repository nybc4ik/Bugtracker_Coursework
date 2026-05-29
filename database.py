# database.py
import sqlite3
import os
from dotenv import load_dotenv

load_dotenv()

DB_FILE = os.getenv("DB_FILE", "bugtracker.db")

def get_connection():
    conn = sqlite3.connect(DB_FILE)
    conn.row_factory = sqlite3.Row  # чтобы возвращались словари
    return conn

def init_db():
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            first_name TEXT NOT NULL,
            last_name TEXT NOT NULL,
            patronymic TEXT,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
    """)
    conn.commit()
    conn.close()

def add_user(first_name: str, last_name: str, patronymic: str = None) -> int:
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute(
        "INSERT INTO users (first_name, last_name, patronymic) VALUES (?, ?, ?)",
        (first_name, last_name, patronymic)
    )
    conn.commit()
    user_id = cursor.lastrowid
    conn.close()
    return user_id

def get_all_users() -> list:
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT id, first_name, last_name, patronymic, created_at FROM users ORDER BY id")
    rows = cursor.fetchall()
    conn.close()
    # Преобразуем Row в dict
    return [dict(row) for row in rows]


def delete_user(user_id: int) -> bool:
    """Удаляет пользователя по ID. Возвращает True, если удалён."""
    conn = get_connection()
    cursor = conn.cursor()
    try:
        # Выполняем удаление
        cursor.execute("DELETE FROM users WHERE id = ?", (user_id,))
        conn.commit()
        
        # Проверяем, удалилось ли хоть что-то (если ID не существовал)
        if cursor.rowcount == 0:
            return False
        return True
    except Exception as e:
        # Сюда мы попадём, если сработают ограничения целостности (Foreign Key)
        print(f"Ошибка удаления: {e}")
        return False
    finally:
        conn.close()
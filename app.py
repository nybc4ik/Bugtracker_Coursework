# app.py
from flask import Flask, render_template, request, redirect, url_for, flash
from database import init_db, add_user, get_all_users, delete_user
import os
from flask import redirect, url_for # Убедись, что это есть в импортах сверху

app = Flask(__name__)
app.secret_key = os.getenv("FLASK_SECRET_KEY", "dev-secret-key-for-coursework")  # нужен для flash-сообщений

@app.route('/delete_user/<int:user_id>', methods=['POST'])
def delete_user_route(user_id):
    # Вызываем функцию из БД
    success = delete_user(user_id)
    
    if success:
        flash(f"Пользователь ID {user_id} удалён", "success")
    else:
        flash(f"Не удалось удалить пользователя (возможно, он используется)", "error")
        
    return redirect(url_for('index'))

@app.route('/')
def index():
    users = get_all_users()
    return render_template('index.html', users=users)

@app.route('/add_user', methods=['POST'])
def add_user_route():
    first_name = request.form.get('first_name', '').strip()
    last_name = request.form.get('last_name', '').strip()
    patronymic = request.form.get('patronymic', '').strip() or None

    # Базовая валидация (для курсовой достаточно)
    if not first_name or not last_name:
        flash("Имя и фамилия обязательны", "error")
        return redirect(url_for('index'))

    try:
        add_user(first_name, last_name, patronymic)
        flash("Пользователь успешно добавлен", "success")
    except Exception as e:
        flash(f"Ошибка БД: {e}", "error")

    return redirect(url_for('index'))

if __name__ == '__main__':
    init_db()  # гарантируем, что таблица существует при старте
    app.run(debug=True, host='127.0.0.1', port=5000)
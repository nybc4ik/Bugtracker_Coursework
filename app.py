from flask import Flask, render_template

app = Flask(__name__)
app.secret_key = "dev-key-stage1"

@app.route('/login')
def login():
    return render_template('login.html')

@app.route('/')
def dashboard():
    return render_template('dashboard.html')

@app.route('/members')
def members():
    return render_template('members.html')

@app.route('/logout')
def logout():
    return render_template('login.html')  # Пока просто редирект на логин

if __name__ == '__main__':
    app.run(debug=True, host='127.0.0.1', port=5000)
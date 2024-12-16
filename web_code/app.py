from flask import Flask, render_template, request, redirect, url_for, session, flash, jsonify
import mysql.connector
from datetime import datetime
from functools import wraps

app = Flask(__name__)
app.secret_key = 'your_secret_key'  # 设置密钥，用于session加密

# 数据库连接配置
db_config = {
    'host': 'localhost',
    'user': 'root',
    'password': '123456',
    'database': 'elder'
}

# 登录验证装饰器
def login_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if 'logged_in' not in session:
            return redirect(url_for('login'))
        return f(*args, **kwargs)
    return decorated_function

def get_db_connection():
    return mysql.connector.connect(**db_config)

@app.route('/login', methods=['GET', 'POST'])
def login():
    error = None
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        
        if username == 'admin' and password == '123456':
            session['logged_in'] = True
            return redirect(url_for('index'))
        else:
            error = '用户名或密码错误'
    
    return render_template('login.html', error=error)

@app.route('/logout', methods=['GET', 'POST'])
def logout():
    # 清除session
    session.clear()
    # 重定向到登录页面
    return redirect(url_for('login'))

@app.route('/')
@login_required
def index():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    
    # 获取搜索参数
    elderly_id = request.args.get('elderly_id', type=int)
    record_type = request.args.get('record_type')
    education_category = request.args.get('education_category')  # 新增教育资源分类参数
    
    # 构建查询条件
    health_records_query = "SELECT * FROM elderly_health_records WHERE 1=1"
    recommendations_query = "SELECT * FROM health_recommendations WHERE 1=1"
    education_materials_query = "SELECT * FROM health_education_materials WHERE 1=1"
    
    query_params = []
    education_params = []
    
    if elderly_id:
        health_records_query += " AND elderly_id = %s"
        recommendations_query += " AND elderly_id = %s"
        query_params.append(elderly_id)
    
    if record_type and record_type != '全部':
        health_records_query += " AND record_type = %s"
        query_params.append(record_type)
    
    if education_category and education_category != '全部':
        education_materials_query += " AND category = %s"
        education_params.append(education_category)
    
    health_records_query += " ORDER BY record_date DESC"
    recommendations_query += " ORDER BY created_at DESC"
    education_materials_query += " ORDER BY publish_date DESC"
    
    # 执行查询
    cursor.execute(health_records_query, tuple(query_params))
    health_records = cursor.fetchall()
    
    if elderly_id:
        cursor.execute(recommendations_query, (elderly_id,))
    else:
        cursor.execute(recommendations_query)
    recommendations = cursor.fetchall()
    
    # 获取教育资料
    if education_params:
        cursor.execute(education_materials_query, tuple(education_params))
    else:
        cursor.execute(education_materials_query)
    education_materials = cursor.fetchall()
    
    # 获取所有记录类型
    cursor.execute("SELECT DISTINCT record_type FROM elderly_health_records ORDER BY record_type")
    record_types = [row['record_type'] for row in cursor.fetchall()]
    
    # 获取所有教育资料分类
    cursor.execute("SELECT DISTINCT category FROM health_education_materials ORDER BY category")
    education_categories = [row['category'] for row in cursor.fetchall()]
    
    cursor.close()
    conn.close()
    
    return render_template('index.html', 
                         health_records=health_records,
                         recommendations=recommendations,
                         education_materials=education_materials,
                         elderly_id=elderly_id,
                         record_type=record_type,
                         record_types=record_types,
                         education_category=education_category,
                         education_categories=education_categories)

@app.route('/add_record', methods=['POST'])
@login_required
def add_record():
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        
        # 获取表单数据
        data = {
            'elderly_id': request.form.get('elderly_id'),
            'record_type': request.form.get('record_type'),
            'blood_pressure': request.form.get('blood_pressure') or None,
            'heart_rate': request.form.get('heart_rate') or None,
            'blood_sugar': request.form.get('blood_sugar') or None,
            'weight': request.form.get('weight') or None,
            'height': request.form.get('height') or None,
            'temperature': request.form.get('temperature') or None,
            'diagnosis': request.form.get('diagnosis') or None,
            'medication': request.form.get('medication') or None,
            'allergies': request.form.get('allergies') or None,
            'sleep_hours': request.form.get('sleep_hours') or None,
            'exercise_minutes': request.form.get('exercise_minutes') or None,
            'record_date': datetime.now()
        }
        
        # 如果有身高和体重，计算BMI
        if data['height'] and data['weight']:
            height_m = float(data['height']) / 100  # 转换为米
            weight_kg = float(data['weight'])
            data['bmi'] = round(weight_kg / (height_m * height_m), 2)
        else:
            data['bmi'] = None
        
        # 构建SQL语句
        sql = """
            INSERT INTO elderly_health_records 
            (elderly_id, record_type, blood_pressure, heart_rate, blood_sugar, 
             weight, height, bmi, diagnosis, medication, allergies, 
             temperature, sleep_hours, exercise_minutes, record_date)
            VALUES 
            (%(elderly_id)s, %(record_type)s, %(blood_pressure)s, %(heart_rate)s, 
             %(blood_sugar)s, %(weight)s, %(height)s, %(bmi)s, %(diagnosis)s, 
             %(medication)s, %(allergies)s, %(temperature)s, %(sleep_hours)s, 
             %(exercise_minutes)s, %(record_date)s)
        """
        
        cursor.execute(sql, data)
        conn.commit()
        
        cursor.close()
        conn.close()
        
        return jsonify({'success': True, 'message': '记录添加成功'})
        
    except Exception as e:
        return jsonify({'success': False, 'message': str(e)})

@app.route('/add_advice', methods=['POST'])
@login_required
def add_advice():
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        
        # 获取表单数据
        data = {
            'elderly_id': request.form.get('elderly_id'),
            'health_status': request.form.get('health_status'),
            'risk_level': request.form.get('risk_level'),
            'dietary_advice': request.form.get('dietary_advice'),
            'exercise_plan': request.form.get('exercise_plan'),
            'medication_reminder': request.form.get('medication_reminder') or None,
            'lifestyle_suggestions': request.form.get('lifestyle_suggestions'),
            'next_checkup_date': request.form.get('next_checkup_date')
        }
        
        # 构建SQL语句
        sql = """
            INSERT INTO health_recommendations 
            (elderly_id, health_status, risk_level, dietary_advice, exercise_plan,
             medication_reminder, lifestyle_suggestions, next_checkup_date)
            VALUES 
            (%(elderly_id)s, %(health_status)s, %(risk_level)s, %(dietary_advice)s,
             %(exercise_plan)s, %(medication_reminder)s, %(lifestyle_suggestions)s,
             %(next_checkup_date)s)
        """
        
        cursor.execute(sql, data)
        conn.commit()
        
        cursor.close()
        conn.close()
        
        return jsonify({'success': True, 'message': '建议添加成功'})
        
    except Exception as e:
        return jsonify({'success': False, 'message': str(e)})

if __name__ == '__main__':
    app.run(debug=True) 
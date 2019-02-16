import os
import hashlib


#Import Flask Library
from flask import Flask, render_template, request, session, url_for, redirect
import pymysql.cursors

#Initialize the app from Flask
app = Flask(__name__)
APP_ROOT = os.path.dirname(os.path.abspath(__file__))
#Configure MySQL
conn = pymysql.connect(host='localhost',
                       user='root',
                       password='Munemrastgir1.',
                       db='project',
                       charset='utf8mb4',
                       cursorclass=pymysql.cursors.DictCursor)

print ("Connection Successful")

#Define a route to hello function
@app.route('/')
def hello():
    cursor = conn.cursor();
    query = 'SELECT item_id, email_post, post_time, file_path, item_name FROM contentitem WHERE is_pub = true AND post_time >= DATE_SUB(NOW(), INTERVAL 1 DAY)'
    cursor.execute(query)
    data = cursor.fetchall()
    cursor.close()
    return render_template('index.html', contentitems=data)

#Define route for login
@app.route('/login')
def login():
    return render_template('login.html')

#Define route for restaurant login
@app.route('/restaurantLogin')
def restaurantLogin():
    return render_template('restaurantLogin.html')

#Define route for register
@app.route('/register')
def register():
    return render_template('register.html')

#register for restaurants
@app.route('/restaurantRegister')
def restaurantRegister():
    return render_template('restaurantRegister.html')

#Define route for verify
@app.route('/verify')
def verify():
    return render_template('verify.html')

#Authenticates the login
@app.route('/loginAuth', methods=['GET', 'POST'])
def loginAuth():
    #grabs information from the forms
    email = request.form['email']
    password = request.form['password']

    #cursor used to send queries
    cursor = conn.cursor()
    #executes query
    query = 'SELECT * FROM person WHERE email = %s and password = %s'
    cursor.execute(query, (email, hashlib.sha256(password.encode('utf-8')).hexdigest()))
    #stores the results in a variable
    data = cursor.fetchone()
    #use fetchall() if you are expecting more than 1 data row
    cursor.close()
    error = None
    if(data):
        #creates a session for the the user
        #session is a built in
        session['email'] = email

        return redirect(url_for('home'))
    else:
        #returns an error message to the html page
        error = 'Invalid login or email'
        return render_template('login.html', error=error)

#Authenticates the restaurant login
@app.route('/restaurantLoginAuth', methods=['GET', 'POST'])
def restaurantLoginAuth():
    #grabs information from the forms
    email = request.form['email']
    password = request.form['password']

    #cursor used to send queries
    cursor = conn.cursor()
    #executes query
    query = 'SELECT * FROM restaurants WHERE email = %s and pass = %s'
    cursor.execute(query, (email, hashlib.sha256(password.encode('utf-8')).hexdigest()))
    #stores the results in a variable
    data = cursor.fetchone()
    #use fetchall() if you are expecting more than 1 data row
    cursor.close()
    error = None
    if(data):
        #creates a session for the the user
        #session is a built in
        session['email'] = email

        return redirect(url_for('restaurantHome'))
    else:
        #returns an error message to the html page
        error = 'Invalid login or email'
        return render_template('restaurantLogin.html', error=error)

#Authenticates the register
@app.route('/registerAuth', methods=['GET', 'POST'])
def registerAuth():
    #grabs information from the forms
    email = request.form['email']
    password = request.form['password']
    fname = request.form['fname']
    lname = request.form['lname']
    address = request.form['address']
    city = request.form['city']
    state = request.form['state']
    zipcode = request.form['zipcode']
    stateID = request.files['stateID']
    paystubs = request.files['paystubs']

    destination = "/".join([target, email])
    stateID.save(destination)
    paystubs.save(destination)


    target = os.path.join(APP_ROOT, 'images/')
    if not os.path.isdir(target):
        os.mkdir(target)


    #cursor used to send queries
    cursor = conn.cursor()
    #executes query
    query = 'SELECT * FROM person WHERE email = %s'
    cursor.execute(query, (email))
    #stores the results in a variable
    data = cursor.fetchone()
    #use fetchall() if you are expecting more than 1 data row
    error = None
    if(data):
        #If the previous query returns data, then user exists
        error = "This user already exists"
        return render_template('register.html', error = error)
    else:
        ins = 'INSERT INTO person VALUES(%s, %s, %s, %s, %s, %s, %s, %s, %s)'
        cursor.execute(ins, (email, hashlib.sha256(password.encode('utf-8')).hexdigest(), fname, lname, address, city, state, zipcode, destination))
        conn.commit()
        cursor.close()
        return redirect(url_for('verify'))
#Authenticates the register
@app.route('/restaurantRegisterAuth', methods=['GET', 'POST'])
def restaurantRegisterAuth():
    #grabs information from the forms
    email = request.form['email']
    password = request.form['password']
    restaurantName = request.form['restaurantName']
    address = request.form['address']
    city = request.form['city']
    state = request.form['state']
    zipcode = request.form['zipcode']

 
    #cursor used to send queries
    cursor = conn.cursor()
    #executes query
    query = 'SELECT * FROM restaurants WHERE email = %s'
    cursor.execute(query, (email))
    #stores the results in a variable
    data = cursor.fetchone()
    #use fetchall() if you are expecting more than 1 data row
    error = None
    if(data):
        #If the previous query returns data, then user exists
        error = "This user already exists"
        return render_template('restaurantRegister.html', error = error)
    else:
        ins = 'INSERT INTO restaurants VALUES(%s, %s, %s, %s, %s, %s, %s)'
        cursor.execute(ins, (email, hashlib.sha256(password.encode('utf-8')).hexdigest(), restaurantName, address, city, state, zipcode))
        conn.commit()
        cursor.close()
        return redirect(url_for('verify'))
        

#displays the home page
@app.route('/home')
def home():
    email = session['email']
    query = 'SELECT zipcode FROM restaurants WHERE email = %s'
    cursor.execute(query, (email))
    zipcode = cursor.fetchone()
    return render_template('home.html', email = email)

#displays the home page for restaurants
@app.route('/restaurantHome')
def restaurantHome():
    email = session['email']
    return render_template('restaurantHome.html', email = email)
    
#logs the user out
@app.route('/logout')
def logout():
    session.pop('email')
    return redirect('/')

app.secret_key = 'some key that you will never guess'


if __name__ == "__main__":
    app.run('127.0.0.1', 5000, debug = True)
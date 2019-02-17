import os
import hashlib


#Import Flask Library
from flask import Flask, render_template, request, session, url_for, redirect
import pymysql.cursors

#file path for images
imgFold = os.path.join('static', 'img')

#Initialize the app from Flask
app = Flask(__name__)
app.config['UPLOAD_FOLDER'] = imgFold
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
    return render_template('index.html')

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
    query = 'SELECT * FROM person WHERE email = %s and pass = %s'
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
        ins = 'INSERT INTO person VALUES(%s, %s, %s, %s, %s, %s, %s, %s)'
        cursor.execute(ins, (email, hashlib.sha256(password.encode('utf-8')).hexdigest(),fname, lname, address, city, state, zipcode))
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
    cuisine = request.form['cuisine']

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
        return render_template('restaurantRegister.html', error = error)
    else:
        ins = 'INSERT INTO restaurants VALUES(%s, %s, %s, %s, %s, %s, %s, %s)'
        cursor.execute(ins, (email, hashlib.sha256(password.encode('utf-8')).hexdigest(),restaurantName, address, city, state, zipcode, cuisine))
        conn.commit()
        cursor.close()
        return redirect(url_for('verify'))

        

#displays the home page
@app.route('/home')
def home():
    email = session['email']
    cursor = conn.cursor()
    query = 'SELECT * FROM person WHERE email = %s'
    cursor.execute(query, (email))
    data = cursor.fetchone()
    zipcode = data.get("zipcode")
    query2 = 'SELECT * FROM restaurants WHERE zipcode = %s'
    cursor.execute(query2,(zipcode))
    row = cursor.fetchall()
    cursor.close()
    firstName = data.get('fname')
    restaurantList = []
    for i in range(0,len(row)):
        if ((row[i].get('cuisine')) == 'french'):
            fileName = os.path.join(app.config['UPLOAD_FOLDER'], 'french.jpg')
        if ((row[i].get('cuisine')) == 'chinese'):
            fileName = os.path.join(app.config['UPLOAD_FOLDER'], 'chinese.jpg')
        if ((row[i].get('cuisine')) == 'american'):
            fileName = os.path.join(app.config['UPLOAD_FOLDER'], 'american.jpg')
        if ((row[i].get('cuisine')) == 'italian'):
            fileName = os.path.join(app.config['UPLOAD_FOLDER'], 'italian.jpg')
        restaurantList.append((row[i].get("restaurantName"),row[i].get("address"), fileName, row[i].get('cuisine')))
    size = len(restaurantList)
    return render_template('home.html', firstName = firstName, zipcode = zipcode, restaurantList = restaurantList, size = size)

#displays the home page for restaurants
@app.route('/restaurantHome')
def restaurantHome():
    email = session['email']
    cursor = conn.cursor()
    query = 'SELECT * FROM donations WHERE email = %s'
    cursor.execute(query, (email))
    data = cursor.fetchone()
    cursor.close()
    restName = data.get('restaurantName') + ' family'
    if (data):
        points = data.get("pounds") * 100
        return render_template('restaurantHome.html', restName = restName, points = points)
    else:
        return render_template('restaurantHome.html', restName = restName, points = 0)

#Define route for restaurant donations 
@app.route('/donate', methods=['GET', 'POST'])
def donate():
    return render_template('donate.html')

#Define route for donateverify
@app.route('/donateVerified')
def donateVerified():
    return render_template('donateVerified.html')

@app.route('/donateAuth', methods=['GET', 'POST'])
def donateAuth():
    #grabs information from the forms
    email = request.form['email']
    pounds = request.form['pounds']
    restaurantName = request.form['restaurantName']
    #cursor used to send queries
    cursor = conn.cursor()
    #executes query
    query = 'SELECT * FROM donations WHERE email = %s'
    cursor.execute(query, (email))
    #stores the results in a variable
    data = cursor.fetchone()

    #use fetchall() if you are expecting more than 1 data row
    error = None
    if(data):
        query2= 'UPDATE donations set pounds =  (pounds + %s) where email = %s'
        cursor.execute(query2, (pounds, email))
        conn.commit()
        
        return redirect(url_for('donateVerified'))
    
    else:
        query3 = "INSERT INTO donations VALUES(%s, %s, %s)"
        cursor.execute(query3, (pounds, restaurantName, email))
        conn.commit()
        return redirect(url_for('donateVerified'))
    
#logs the user out
@app.route('/logout')
def logout():
    session.pop('email')
    return redirect('/')

app.secret_key = 'some key that you will never guess'


if __name__ == "__main__":
    app.run('127.0.0.1', 5000, debug = True)










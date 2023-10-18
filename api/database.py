import mysql.connector
from flask import request

def get_database_connection():
    try:
        db_connection = mysql.connector.connect(
            host="localhost",
            user="root",
            password="Code&123",
            database="meditracker_login"
        )
        cursor = db_connection.cursor()
        try:
            data = request.form
            email = data.get('email')
            password = data.get('password')

            # Validate login against the database
            cursor.execute("SELECT * FROM logindetails WHERE email = %s AND password = %s", (email, password))
            user = cursor.fetchone()

            if user:
            # Login successful
                return 'true', 200
            else:
            # Login failed
                return 'false', 401
        except Exception as e:
            print(str(e))
            return 'false', 500

        
    except mysql.connector.Error as err:
        print("Error: {}".format(err))
        return None

def signup_new_account():
    try:
        db_connection = mysql.connector.connect(
            host="localhost",
            user="root",
            password="Code&123",
            database="meditracker_login"
        )
        cursor = db_connection.cursor()
        try:
            data = request.form
            email = data.get('email')
            password = data.get('password')
            cursor.execute("SELECT * FROM logindetails WHERE email = %s", (email,))
            existing_user = cursor.fetchone()
            if existing_user:
                return 'Email already exists', 409
            else:

            # Validate login against the database
                cursor.execute("INSERT INTO logindetails(email,password) VALUES(%s,%s)", (email, password))
                db_connection.commit()

                return 'true', 200
            
                
        except Exception as e:
            print(str(e))
            return 'false', 500
    
    except mysql.connector.Error as err:
        print("Error: {}".format(err))
        return None
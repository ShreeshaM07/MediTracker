# meditracker

An app that keeps track of your medicines. Reminds you to take the respective medicines at proper timings.
This is done by integrating the app with google calendar which also allows users to access their reminders
on all their google synced devices.


## Overview

The app is built using `flutter` which can be installed using the following link 
`https://docs.flutter.dev/get-started/install/windows`. Most of the backend of this app
has been developed using `python` which is a very  convenient language and has 
a rich ecosystem with many libraries.

This has been carried out using the `flask` server which creates a server on the local
machine and allows the python files to be called from the flutter application.

The login screen on flutter has been created using `MySQL`. A database is created on the 
local system which is then accessed and used through the python file `database.py`.

The image extraction tool used is `pytesseract` which uses TESSERACT-OCR engine to convert
the text in the image into a string which is then written into a file `extracted_text.txt`.

The application then recognises the set of medicines along with their respective dosage, timings 
and the duration it needs to be taken. The app also allows users to make changes to the current ones
and add new medicines.

The final set of medicines can then be updated to the calendar by pressing on the `update to calendar`
button which calls another python function `medicines_to_calendar.py` which creates the event in the
test users google calendar.

## Installation

install flutter and create a project and run `flutter doctor`    
run `pub-get` in pubspec.yaml.  
`pip install flask`  
install mysql and create a database with name `meditracker_login`
Create a table named `logindetails` with email and password columns
and link it with the `db_connection` in `database.py` file.  
Create a `google cloud console` account and add the app as a project.  
Complete the OAUTH consent and add test users or verify app when it is published.  
Enable google calendar api.  
Download the `json` file generated and modify it in the address in `cal_setup.py`.  
`pip install google-api-python-client`  
`pip install datetime`  
`pip install pytesseract`
install Tesseract-OCR from `https://github.com/UB-Mannheim/tesseract/wiki`
add the Tesseract-OCR folder to the environment path variable on the system and restart pc.  

## Step by Step Setup
 
1.Install the medi_tracker.exe from `https://github.com/ShreeshaM07/MediTracker/tree/main/installers`  
2.Setup the application to desktop as an app  
3.install mysql and create a database with name `meditracker_login`  
4.Create a table named `logindetails` with email and password columns  
#### Note: go to `mysql` database and `flush privileges;`  
5.link `meditracker_login` with the `db_connection` in `database.py` file.  
6.install Tesseract-OCR from `https://github.com/UB-Mannheim/tesseract/wiki`  
7.add the Tesseract-OCR folder to the environment path variable on the system and restart pc.  

![Screenshot (71)](https://github.com/ShreeshaM07/MediTracker/assets/120820143/c367c771-b3fc-4baa-b397-b1fa1436e6a5)

![Screenshot (73)](https://github.com/ShreeshaM07/MediTracker/assets/120820143/b5098bd5-b7cc-4469-8963-bb315b5a591b)  

![Screenshot (75)](https://github.com/ShreeshaM07/MediTracker/assets/120820143/5e04db35-8af6-4e83-a4bb-4471a7a2fe14)


8.Execute the following pip commands:  
`pip install google-api-python-client`   
`pip install datetime`  
`pip install pytesseract`  
`pip install flask`  
9.`cd` to the api folder after forking the repo and `flask run` on CMD  
10.A request to allow app to access google calendar will pop up press `ALLOW`.  
11.Start the app by clicking on the icon created after `step 2`.  

## NOTE

To call the flask server to integrate python backend move to the directory where the `app.py` is present using `cd`
then `flask run` which will then take you to a google vefirication link which must be allowed in order to access the
google calendat and create events in it. Then build the program by running the main.dart file.

## Working Video

### How to run the app

https://github.com/ShreeshaM07/MediTracker/assets/120820143/8a268352-c1d0-4eb6-8a6a-552f02228e31

### Select Image and Process


https://github.com/ShreeshaM07/MediTracker/assets/120820143/4da3c2fe-824e-47c7-8a26-43030a1eb840

### Output

https://github.com/ShreeshaM07/MediTracker/assets/120820143/122c659d-e686-423f-b9bf-116003519534



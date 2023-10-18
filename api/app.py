import os
from flask import Flask, request, jsonify
from PIL import Image
import pytesseract
import base64
import io
from database import get_database_connection,signup_new_account

app = Flask(__name__)

@app.route('/login', methods=['POST'])
def login():
    db_connection = get_database_connection()
    return db_connection

@app.route('/signup', methods=['POST'])
def signup():
    db_connection = signup_new_account()
    return db_connection
    

@app.route('/extracttext', methods=['POST'])
def extract_text():
    try:
        data = request.get_json()
        base64_image = data.get('image')  # Get the base64 encoded image from the request data
        image_bytes = base64.b64decode(base64_image)  # Decode the base64 image to bytes
        
        # Open the image from bytes using Pillow
        img = Image.open(io.BytesIO(image_bytes))

        # Perform text extraction using Tesseract
        extracted_text = pytesseract.image_to_string(img)
        
        # Do something with the extracted text, such as saving it to a file
        with open('extracted_text.txt', 'w') as text_file:
            text_file.write(extracted_text)
        
        return jsonify({'extracted_text': extracted_text}), 200
    except Exception as e:
        print(str(e))
        return jsonify({'error': 'Error occurred while processing the image'}), 500

if __name__ == '__main__':
    app.run(debug=True)

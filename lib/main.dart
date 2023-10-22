import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'login_page.dart';
import 'dart:io';
// import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'medicine_info_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MediTracker',
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => ImageTextExtraction(),
      },
    );
  }
}

class ImageTextExtraction extends StatefulWidget {
  @override
  _ImageTextExtractionState createState() => _ImageTextExtractionState();
}

class _ImageTextExtractionState extends State<ImageTextExtraction> {
  File? _selectedImage;

  Future<void> _selectImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null) {
      setState(() {
        _selectedImage = File(result.files.single.path!);
      });
    }
  }

  Future<void> extractText() async {
    if (_selectedImage == null) {
      // Handle no image selected error
      print('No Image selected');
      return;
    }
    final apiUrl = Uri.parse('http://127.0.0.1:5000/extracttext');
    try {
      List<int> imageBytes = _selectedImage!.readAsBytesSync();

      final response = await http.post(
        apiUrl,
        body: jsonEncode({
          'image': base64Encode(imageBytes)
        }), // Send base64 encoded image directly in the body
        headers: {
          'Content-Type': 'application/json', // Set the content type here
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        String extractedText = responseData['extracted_text'];
        List<List<dynamic>> dynamicTabList =
            List<List<dynamic>>.from(responseData['tab_list']);
        List<List<String>> tabList = dynamicTabList
            .map<List<String>>((dynamic sublist) => sublist.cast<String>())
            .toList();
        setState(() {
          // Handle the extracted text response if needed
          print('Image Extracted: $extractedText');
          print('Tab List: $tabList');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MedicineInfoScreen(tabList: tabList),
            ),
          );
        });
      } else {
        throw Exception('Failed to extract text.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MediTracker'),
        backgroundColor: const Color.fromARGB(255, 16, 185, 211),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 60),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 16, 185, 211),
                ),
                onPressed: _selectImage,
                child: Text('Select Image'),
              ),
              _selectedImage == null
                  ? Text('No image selected.')
                  : Image.file(
                      _selectedImage!,
                      height: 480,
                      width: 270,
                      fit: BoxFit.fill,
                    ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 16, 185, 211),
                ),
                onPressed: extractText,
                child: Text('Extract Text'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

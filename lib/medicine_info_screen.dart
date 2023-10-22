import 'package:flutter/material.dart';

class MedicineInfoScreen extends StatefulWidget {
  final List<List<String>> tabList;

  MedicineInfoScreen({required this.tabList});

  @override
  _MedicineInfoScreenState createState() => _MedicineInfoScreenState();
}

class _MedicineInfoScreenState extends State<MedicineInfoScreen> {
  List<List<String>> editedTabList = [];

  @override
  void initState() {
    super.initState();
    // Initialize editedTabList with the initial data
    editedTabList.addAll(widget.tabList);
  }

  void _addMedicine() async {
    TextEditingController _controller = TextEditingController();
    String? newData = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
              'Add New Medicine with timings and \nduration in days in separate lines'),
          content: Column(
            children: [
              TextField(
                controller: _controller,
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),
              SizedBox(height: 8),
              Text(
                'Note: While adding new elements or editing existing ones, keep the same format in mind of using "after" or "before" before the time of the day.',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Save the new data and pop the dialog
                Navigator.of(context).pop(_controller.text);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );

    if (newData != null && newData.isNotEmpty) {
      setState(() {
        // Add the new medicine to the editedTabList
        editedTabList.insert(editedTabList.length - 1, newData.split('\n'));

        // Print editedTabList in the terminal
        print('Edited List: $editedTabList');
      });
    }
  }

  void _editMedicine(int index) async {
    String initialData = editedTabList[index].join('\n');
    TextEditingController _controller =
        TextEditingController(text: initialData);
    String? updatedData = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Medicine'),
          content: Column(
            children: [
              TextField(
                controller: _controller,
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),
              SizedBox(height: 8),
              Text(
                'Note: While adding new elements or editing existing ones, keep the same format in mind of using "after" or "before" before the time of the day.',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Save the updated data and pop the dialog
                Navigator.of(context).pop(_controller.text);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );

    if (updatedData != null) {
      setState(() {
        // Update the editedTabList with the new data
        editedTabList[index] = updatedData.split('\n');
        print('Edited tabList: $editedTabList');
      });
    }
  }

  void _deleteMedicine(int index) {
    setState(() {
      // Remove the medicine from editedTabList at the given index
      editedTabList.removeAt(index);
      print('Edited tabList after deletion: $editedTabList');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medicine Info'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: editedTabList.length,
        itemBuilder: (context, index) {
          String medicineName = editedTabList[index][0];
          List<String> additionalInfo = editedTabList[index].sublist(1);

          // Build subtitle text with all available information
          String subtitleText = additionalInfo.join('\n');

          return ListTile(
            title: Text(medicineName),
            subtitle: Text(subtitleText),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // Handle edit button tap
                    _editMedicine(index);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // Handle delete button tap
                    _deleteMedicine(index);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addMedicine,
        child: Icon(Icons.add),
      ),
    );
  }
}

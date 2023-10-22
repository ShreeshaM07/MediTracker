import 'package:flutter/material.dart';

class MedicineInfoScreen extends StatelessWidget {
  final List<List<String>> tabList;

  MedicineInfoScreen({required this.tabList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medicine Info'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: tabList.length,
        itemBuilder: (context, index) {
          String medicineName = tabList[index][0];
          List<String> additionalInfo = tabList[index].sublist(1);

          // Build subtitle text with all available information
          String subtitleText = additionalInfo.join('\n');

          return ListTile(
            title: Text(medicineName),
            subtitle: Text(subtitleText),
          );
        },
      ),
    );
  }
}

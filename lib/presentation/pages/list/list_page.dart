import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListPage extends StatelessWidget {
  ListPage({super.key});

  final List<Map<String, dynamic>> data = [
    {
      "icon": Icons.home,
      "name": "Home",
      "address": "123 Main St, Springfield, USA",
    },
    {
      "icon": Icons.work,
      "name": "Work",
      "address": "456 Elm St, Springfield, USA",
    },
    {
      "icon": Icons.school,
      "name": "School",
      "address": "789 Oak St, Springfield, USA",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('List Tile Page')),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(data[index]['icon']),
            title: Text(data[index]['name']),
            subtitle: Text(data[index]['address']),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Get.snackbar(
                data[index]['name'],
                data[index]['address'],
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.blue,
                colorText: Colors.white,
              );
            },
          );
        },
      ),
    );
  }
}

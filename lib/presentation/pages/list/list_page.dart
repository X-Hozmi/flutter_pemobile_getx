// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class ListPage extends StatelessWidget {
//   ListPage({super.key});

//   final List<Map<String, dynamic>> data = [
//     {"name": "Home", "address": "123 Main St, Springfield, USA"},
//     {"name": "Work", "address": "456 Elm St, Springfield, USA"},
//     {"name": "School", "address": "789 Oak St, Springfield, USA"},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('List Tile Page')),
//       body: ListView.builder(
//         padding: const EdgeInsets.all(10),
//         itemCount: data.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             leading: Icon(Icons.person),
//             title: Text(data[index]['name']),
//             subtitle: Text(data[index]['address']),
//             trailing: InkWell(child: Icon(Icons.delete), onTap: () {}),
//             onTap: () {
//               Get.snackbar(
//                 data[index]['name'],
//                 data[index]['address'],
//                 snackPosition: SnackPosition.BOTTOM,
//                 backgroundColor: Colors.blue,
//                 colorText: Colors.white,
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'dart:developer';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pemobile_getx/domain/entities/person/person.dart';
import 'package:flutter_pemobile_getx/presentation/controllers/person_controller.dart';
import 'package:get/get.dart';

part 'parts/person_form_sheet.dart';
part 'parts/show_person_form.dart';

class ListPage extends StatelessWidget {
  ListPage({super.key});

  final personController = Get.find<PersonController>();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      personController.getPerson();
    });

    return Scaffold(
      appBar: AppBar(title: Text('List Tile Page')),
      body: GetBuilder<PersonController>(
        builder: (controller) {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else if (controller.isError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, color: Colors.red, size: 48),
                  SizedBox(height: 16),
                  Text(
                    'Error: ${controller.message}',
                    style: TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      controller.clearError();
                      controller.getPerson();
                    },
                    child: Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (!controller.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person_outline, size: 48, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No persons found',
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => controller.getPerson(),
                    child: Text('Refresh'),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async => await controller.getPerson(),
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: controller.personEntity!.length,
              itemBuilder: (context, index) {
                final person = controller.personEntity![index];

                return Card(
                  margin: EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.withOpacity(0.1),
                      child: Icon(Icons.person),
                    ),
                    title: Text(
                      person.name ?? 'Unknown Name',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (person.email != null && person.email!.isNotEmpty)
                          Text(
                            person.email!,
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        if (person.handphone != null &&
                            person.handphone!.isNotEmpty)
                          Text(
                            person.handphone!,
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        if (person.address != null &&
                            person.address!.isNotEmpty)
                          Text(
                            person.address!,
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        log(person.toString());
                        personController.removePerson(person);
                      },
                    ),
                    onTap:
                        () => showPersonForm(
                          context,
                          personController,
                          person: person,
                        ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showPersonForm(context, personController),
        tooltip: 'Add Person',
        child: Icon(Icons.add),
      ),
    );
  }
}

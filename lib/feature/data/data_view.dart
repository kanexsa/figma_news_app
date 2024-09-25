import 'package:figma_news_app/product/services/firestore/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataView extends StatelessWidget {
  final FirestoreService _firestoreService = FirestoreService();

  DataView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              await _firestoreService
                  .addData('test_collection', {'name': 'Test'});
            },
            child: const Text('Add Data'),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _firestoreService.getData('test_collection'),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final docs = snapshot.data!.docs;
                return Expanded(
                  child: ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final doc = docs[index];
                      TextEditingController controller =
                          TextEditingController(text: doc['name']);

                      return ListTile(
                        title: TextField(
                          controller: controller,
                          decoration: const InputDecoration(
                            labelText: 'Name',
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () async {
                                await _firestoreService.updateData(
                                  'test_collection',
                                  doc.id,
                                  {'name': controller.text},
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () async {
                                await _firestoreService.deleteData(
                                    'test_collection', doc.id);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}

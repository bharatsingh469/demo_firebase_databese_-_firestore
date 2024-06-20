import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database_01/utils/utils.dart';
import 'package:firebase_database_01/widgtes/round_button.dart';
import 'package:flutter/material.dart';

class AddFirestoreDataScreen extends StatefulWidget {
  const AddFirestoreDataScreen({super.key});

  @override
  State<AddFirestoreDataScreen> createState() => _AddFirestoreDataScreenState();
}

class _AddFirestoreDataScreenState extends State<AddFirestoreDataScreen> {
  final postController = TextEditingController();
  bool loading = false;
  final fireStore = FirebaseFirestore.instance.collection('users');
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Firestore Data'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              maxLines: 4,
              controller: postController,
              decoration: const InputDecoration(
                  hintText: 'What is in your mind?',
                  border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 30,
            ),
            RoundButton(
                title: 'Add Data',
                onTap: () {
                  setState(() {
                    loading = true;
                  });
                  String id = DateTime.now().microsecondsSinceEpoch.toString(); 

                  fireStore
                      .doc(id)
                      .set({
                        'title' : postController.text.toString(),
                        'id': id,

                      })
                      .then((value) {
                        Utils().toastMessage('Data added');
                         setState(() {
                      loading = false;
                    });
                      })
                      .onError((error, stackTrace) {
                        Utils().toastMessage(error.toString());
                         setState(() {
                      loading = false;
                    });
                      });
                }),
          ],
        ),
      ),
    );
  }
}

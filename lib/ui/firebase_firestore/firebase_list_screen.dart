import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database_01/ui/firebase_firestore/add_firestore_data.dart';
import 'package:flutter/material.dart';

class FireStoreScreen extends StatefulWidget {
  const FireStoreScreen({super.key});

  @override
  State<FireStoreScreen> createState() => _FireStoreScreenState();
}

class _FireStoreScreenState extends State<FireStoreScreen> {
  final auth = FirebaseAuth.instance;
  final editController = TextEditingController();
  final fireStore = FirebaseFirestore.instance.collection('users').snapshots();

  CollectionReference ref = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FireStore Screen'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          StreamBuilder<QuerySnapshot>(
              stream: fireStore,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return CircularProgressIndicator();

                if (snapshot.hasError) return Text("Some Error");

                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: ((context, index) {
                      return ListTile(
                        onTap: () {
                          // for update
                          // ref
                          //     .doc(snapshot.data!.docs[index]['id'].toString())
                          //     .update({'title': 'Rammmmmmmmmmmmmmmmmmm'}).then(
                          //         (value) {
                          //   Utils().toastMessage("Updated");
                          // }).onError((error, stackTrace) {
                          //   Utils().toastMessage(error.toString());
                          // });

                          //  for Dalete
                          // ref
                          //     .doc(snapshot.data!.docs[index]['id'].toString())
                          //     .delete();
                        },
                        title: Text(
                            snapshot.data!.docs[index]['title'].toString()),
                        subtitle:
                            Text(snapshot.data!.docs[index]['id'].toString()),
                      );
                    }),
                  ),
                );
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddFirestoreDataScreen()));
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }

  Future<void> showMyDialog(String title, String id) async {
    editController.text = title;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Update"),
          content: Container(
            child: TextField(
              controller: editController,
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel")),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // ref
                          //     .doc(snapshot.data!.docs[index]['id'].toString())
                          //     .update({'title': 'Rammmmmmmmmmmmmmmmmmm'}).then(
                          //         (value) {
                          //   Utils().toastMessage("Updated");
                          // }).onError((error, stackTrace) {
                          //   Utils().toastMessage(error.toString());
                          // });
               // ref.doc(snapshot.data!.docs[index]['id'].toString())

                },
                child: Text("Update"))
          ],
        );
      },
    );
  }
}

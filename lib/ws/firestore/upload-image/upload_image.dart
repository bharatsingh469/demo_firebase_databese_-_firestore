import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database_01/utils/utils.dart';
import 'package:firebase_database_01/ws/ui/ui_helper.dart';
import 'package:image_picker/image_picker.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  File? pickedImage;
  // to upload image on firebase
  signUp(String email, String password) async {
    if (email == "" && password == "" && pickedImage == null) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Enter Required Fields"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Ok")),
              ],
            );
          });
    } else {
      UserCredential? usercredential;
      try {
        usercredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) {
          uploadData();
        });
      } on FirebaseAuthException catch (ex) {
        print(ex.code.toString());
        Utils().toastMessage(ex.code.toString());
      }
    }
  }

  //
  uploadData() async {
    UploadTask uploadTask = FirebaseStorage.instance
        .ref("Profile Pics")
        .child(emailController.text.toString())
        .putFile(pickedImage!);
    TaskSnapshot taskSnapshot = await uploadTask;
    String url = await taskSnapshot.ref.getDownloadURL();
    FirebaseFirestore.instance
        .collection("Userss")
        .doc(emailController.text.toString())
        .set({
      "Email": emailController.text.toString(),
      "Image": url,
    }).then((value) {
      Utils().toastMessage("User Uploaded");
      print("User Uploaded");
    });
  }

  // to show dialogbox on on tap profile photo
  showAlertBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Pick Image From"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () {
                    pickImage(ImageSource.camera);
                    Navigator.pop(context);
                  },
                  leading: const Icon(Icons.camera_alt),
                  title: const Text("Camera"),
                ),
                ListTile(
                  onTap: () {
                    pickImage(ImageSource.gallery);
                    Navigator.pop(context);
                  },
                  leading: Icon(Icons.image),
                  title: Text("Gallery"),
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Image"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              showAlertBox();
            },
            child: pickedImage != null
                ? CircleAvatar(
                    radius: 80,
                    backgroundImage: FileImage(pickedImage!),
                  )
                : CircleAvatar(
                    radius: 80,
                    child: Icon(
                      Icons.person,
                      size: 80,
                    ),
                  ),
          ),
          UiHelper.CustomTextField(
              emailController, "Enter your email", Icons.mail, false),
          UiHelper.CustomTextField(
              passwordController, "Enter your password", Icons.password, false),
          const SizedBox(
            height: 20,
          ),
          UiHelper.CustomButton(() {
            signUp(emailController.text.toString(),
                passwordController.text.toString());
          }, "Sign UP"),
        ],
      ),
    );
  }

  pickImage(ImageSource imageSource) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageSource);
      if (photo == null) return;
      final tempImage = File(photo.path);
      setState(() {
        pickedImage = tempImage;
      });
    } catch (ex) {
      Utils().toastMessage(ex.toString());
      print(ex.toString());
    }
  }
}

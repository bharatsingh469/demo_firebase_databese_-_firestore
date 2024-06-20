import 'package:flutter/material.dart';

class UiHelper {
  static CustomTextField(TextEditingController controller, String text,
      IconData iconData, bool toHide) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: TextField(
        controller: controller,
        obscureText: toHide,
        decoration: InputDecoration(
            hintText: text,
            suffixIcon: Icon(iconData),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
            )),
      ),
    );
  }

  static CustomButton(VoidCallback voidCallback, String text) {
    return Container(
      // color: Colors.deepPurple,
      height: 50,
      width: 300,
      child: ElevatedButton(
        onPressed: () {
          voidCallback();
        },
        child: Text(text, style: TextStyle(color: Colors.white, fontSize: 20)),
        // style: ButtonStyle(

        //   backgroundColor: MaterialStateProperty.all(Colors.deepPurple)
        // )
        style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 103, 58, 183),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25))),
      ),
    );
  }

  static CustomAlertBox(BuildContext context, String text) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(text),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("OK"))
            ],
          );
        });
  }
}

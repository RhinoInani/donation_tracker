import 'package:donation_tracker/screens/homeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      textTheme: GoogleFonts.ralewayTextTheme(),
    ),
    themeMode: ThemeMode.light,
    home: HomeScreen(),
  ));
}

//createAlertDialog(context).then((value) {
//            SnackBar mySnackBar = SnackBar(content: Text("Hello $value"),);
//            Scaffold.of(context).showSnackBar(mySnackBar);
//
//         });

//  Future<String>createAlertDialog(BuildContext context){
//    TextEditingController customController = TextEditingController();
//    return showDialog(context: context, builder: (context) {
//      return AlertDialog(
//        title: Text("Donation Location"),
//        content: TextField(
//          controller: customController,
//        ),
//        actions: <Widget>[
//          MaterialButton(
//            elevation: 5,
//            child: Text("Submit"),
//            onPressed: (){
//              Navigator.of(context).pop(customController.text.toString());
//            },
//          ),
//        ],
//      );
//    });
//
//    }

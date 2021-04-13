import 'package:donation_tracker/components/settingsCard.dart';
import 'package:donation_tracker/components/settingsHeader.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SettingsHeader(),
            SettingsCard(
              text: "Target Amount",
              icon: Icon(Icons.attach_money_rounded),
              pressIcon: () {},
            ),
          ],
        ),
      ),
    );
  }
}

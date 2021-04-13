import 'package:flutter/material.dart';

class SettingsHeader extends StatelessWidget {
  const SettingsHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          height: 5,
          endIndent: 50,
          indent: 50,
          color: Colors.black87,
          thickness: 0.5,
        ),
        Text(
          "Settings",
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.07,
          ),
        ),
        Divider(
          height: 5,
          color: Colors.black,
          endIndent: 50,
          indent: 50,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        Divider(
          height: 5,
          color: Colors.black87,
          thickness: 0.5,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class SettingsCard extends StatelessWidget {
  final String text;
  final Icon icon;
  final Function pressIcon;

  const SettingsCard({Key key, this.text, this.icon, this.pressIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pressIcon,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.035),
            height: MediaQuery.of(context).size.height * 0.12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  text,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.055,
                  ),
                ),
                IconButton(
                  onPressed: pressIcon,
                  icon: icon,
                  iconSize: MediaQuery.of(context).size.height * 0.03,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          Divider(
            height: 5,
            color: Colors.black87,
            thickness: 0.5,
          ),
        ],
      ),
    );
  }
}

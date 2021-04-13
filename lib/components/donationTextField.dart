import 'package:flutter/material.dart';

class DonationsTextField extends StatelessWidget {
  DonationsTextField(
      {Key key,
      @required this.textController,
      @required this.text,
      @required this.isAmount})
      : super(key: key);

  final TextEditingController textController;
  final String text;
  final bool isAmount;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            "$text",
            style: TextStyle(fontSize: size.width * 0.045),
          ),
        ),
        TextField(
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[400]),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[400]),
            ),
          ),
          keyboardType: isAmount
              ? TextInputType.numberWithOptions(decimal: true, signed: false)
              : null,
          controller: textController,
          textAlign: TextAlign.center,
          expands: false,
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
      ],
    );
  }
}

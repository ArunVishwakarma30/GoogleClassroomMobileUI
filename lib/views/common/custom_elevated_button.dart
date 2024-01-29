import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hci_lms/views/app_constants.dart';
import 'package:hci_lms/views/common/custom_text_style.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({Key? key, required this.onButtonTap, required this.text}) : super(key: key);
  final VoidCallback onButtonTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ElevatedButton(onPressed: onButtonTap, style: ElevatedButton.styleFrom(
      backgroundColor: darkThemeColor,
      minimumSize: Size(width - 23, 60),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ), child: Text(text, style: customStyle(23, Colors.white, FontWeight.bold),));
  }
}

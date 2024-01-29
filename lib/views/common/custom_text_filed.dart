import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hci_lms/views/app_constants.dart';
import 'package:hci_lms/views/common/custom_text_style.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      required this.hintText,
      required this.textEditingController,
      this.suffixIcon,
      required this.textInputType,
      required this.hideText,
      this.validator})
      : super(key: key);
  final String hintText;
  final TextEditingController textEditingController;
  final Widget? suffixIcon;
  final TextInputType textInputType;
  final bool hideText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      obscureText: hideText,
      controller: textEditingController,
      maxLines: 1,
      validator: validator,
      style: customStyle(20, Colors.black, FontWeight.normal),
      decoration: InputDecoration(
          suffixIcon: suffixIcon,
          labelText: hintText,
          labelStyle: customStyle(19, Colors.black45, FontWeight.normal),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: lightThemeColor),
            borderRadius: BorderRadius.circular(10),
          )),
    );
  }
}

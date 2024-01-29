import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hci_lms/views/common/custom_text_style.dart';

class CreateClassTextField extends StatefulWidget {
  const CreateClassTextField({
    Key? key,
    required this.hintText,
    required this.textEditingController,
    this.onTextChange,
  }) : super(key: key);
  final String hintText;
  final TextEditingController textEditingController;
  final void Function(String?)? onTextChange;

  @override
  State<CreateClassTextField> createState() => _CreateClassTextFieldState();
}

class _CreateClassTextFieldState extends State<CreateClassTextField> {
  bool showSuffixIcon = false;

  @override
  void initState() {
    super.initState();
    widget.textEditingController.addListener(() {
      setState(() {
        showSuffixIcon = widget.textEditingController.text.trim().isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom: 20),
      height: 60,
      decoration: BoxDecoration(
          color: Colors.grey.shade300,
          border: const BorderDirectional(bottom: BorderSide(width: 1)),
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(5), topLeft: Radius.circular(5))),
      child: TextField(
        controller: widget.textEditingController,
        onChanged: widget.onTextChange,
        keyboardType: TextInputType.text,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          suffixIcon: showSuffixIcon
              ? GestureDetector(
                  onTap: () {
                    widget.textEditingController.clear();
                  },
                  child: const Icon(Icons.close),
                )
              : null,
          border: InputBorder.none,
          labelText: widget.hintText,
          labelStyle: customStyle(15, Colors.black, FontWeight.normal),
        ),
      ),
    );
  }
}

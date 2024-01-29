import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hci_lms/views/common/custom_text_style.dart';

class ButtonWithIcon extends StatelessWidget {
  const ButtonWithIcon({Key? key, required this.imageUrl, required this.text}) : super(key: key);
  final String imageUrl;
  final String text;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black12),
        borderRadius: BorderRadius.circular(12)
      ),
      child: Row(
        children: [
          Image.network(imageUrl, width: 35, height: 35),
          const SizedBox(width: 15,),
          Text(text, style: customStyle(22, Colors.black, FontWeight.bold),),
        ],
      ),
    );
  }
}

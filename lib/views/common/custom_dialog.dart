import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_constants.dart';
import 'custom_text_filed.dart';
import 'custom_text_style.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog(
      {Key? key,
      required this.controller,
      required this.personName,
      required this.isStudent,
      required this.onAddButtonTap,
      this.onCopyButtonTap,
      this.inviteCode})
      : super(key: key);
  final TextEditingController controller;
  final String personName;
  final bool isStudent;
  final VoidCallback onAddButtonTap;
  final VoidCallback? onCopyButtonTap;
  final String? inviteCode;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: Colors.white,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Add a $personName",
                style: customStyle(23, Colors.black, FontWeight.w500),
              ),
              IconButton(
                onPressed: () {
                  controller.text = "";
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close, color: darkThemeColor),
              )
            ],
          ),
        ),
        const Divider(
          height: 0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
          child: CustomTextField(
              hintText: "Enter email address",
              textEditingController: controller,
              textInputType: TextInputType.emailAddress,
              hideText: false),
        ),
        ElevatedButton(
            onPressed: onAddButtonTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: darkThemeColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
            ),
            child: Text(
              "Add $personName",
              style: customStyle(18, Colors.white, FontWeight.w500),
            )),
        isStudent
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                      width: 40,
                      child: Divider(
                        thickness: 2,
                        color: Colors.black,
                      )),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Or",
                    style: customStyle(22, Colors.black, FontWeight.normal),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const SizedBox(
                      width: 40,
                      child: Divider(
                        thickness: 2,
                        color: Colors.black,
                      )),
                ],
              )
            : const SizedBox.shrink(),
        isStudent
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 1),
                child: Row(
                  children: [
                    Text(
                      "Invitation Code : ",
                      style: customStyle(18, Colors.black, FontWeight.w500),
                    ),
                    Text(
                      "$inviteCode ",
                      style: customStyle(18, Colors.black, FontWeight.normal),
                    ),
                    const Expanded(
                        child: SizedBox(
                      width: 1,
                    )),
                    IconButton(
                        onPressed: onCopyButtonTap,
                        icon: Icon(
                          Icons.copy,
                          color: darkThemeColor,
                        ))
                  ],
                ),
              )
            : SizedBox.shrink()
      ]),
    );
    ;
  }
}

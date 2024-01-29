import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hci_lms/views/app_constants.dart';

import '../../common/custom_text_style.dart';

class AnnouncementsContainer extends StatelessWidget {
  const AnnouncementsContainer({Key? key, this.img, required this.isAssignment})
      : super(key: key);
  final bool isAssignment;
  final File? img;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        color: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          child: InkWell(
            onTap: () {},
            child: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    radius: 22,
                    backgroundColor:
                        isAssignment ? darkThemeColor : Colors.pink,
                    child: isAssignment
                        ? const Icon(
                            Icons.assignment,
                            color: Colors.white,
                          )
                        : Text(
                            "A",
                            style: customStyle(
                                20, Colors.white, FontWeight.normal),
                          ),
                  ),
                  title: Text(
                    "New assignment : " * 7,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: customStyle(15, Colors.black,
                        isAssignment ? FontWeight.w500 : FontWeight.bold),
                  ),
                  subtitle: Text(
                    "29 Jan",
                    style: customStyle(15, Colors.black, FontWeight.w300),
                  ),
                ),
                isAssignment
                    ? SizedBox.shrink()
                    : Text(
                        "29 Jan " * 100,
                        style: customStyle(15, Colors.black, FontWeight.normal),
                      ),
                img != null
                    ? const SizedBox(
                        height: 20,
                      )
                    : const SizedBox.shrink(),
                img != null
                    ? GestureDetector(
                        onTap: () {
                          // todo : write a code, after the click on the image, show image on different page, with full size
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Image.file(
                            img!,
                            height: 200,
                            width: width * 0.5,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

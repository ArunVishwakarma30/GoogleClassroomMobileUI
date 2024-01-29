import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hci_lms/controllers/auth_provider.dart';
import 'package:hci_lms/controllers/create_class_provider.dart';
import 'package:hci_lms/models/class_details_model.dart';
import 'package:hci_lms/views/app_constants.dart';
import 'package:provider/provider.dart';

import '../../common/custom_text_style.dart';

class ClassworkPage extends StatefulWidget {
  const ClassworkPage({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<ClassworkPage> createState() => _ClassworkPageState();
}

class _ClassworkPageState extends State<ClassworkPage> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Consumer<CreateClassProvider>(
      builder: (context, createClassProvider, child) {
        ClassDetails currentClassDetails =
            createClassProvider.allCreatedOrJoinedClasses[widget.index];
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.string(
              currentClassDetails.classTeachers!.any((element) =>
                      authProvider.loginUserDetails!.emailId == element.emailId)
                  ? classworkSvg
                  : studentClassworkSvg,
            ),
            Text(
              currentClassDetails.classTeachers!.any((element) =>
                      authProvider.loginUserDetails!.emailId == element.emailId)
                  ? "This is where you you'll assign work"
                  : "No assignments yet. Lucky you!",
              style: customStyle(16, Colors.black, FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            currentClassDetails.classTeachers!.any((element) =>
                    authProvider.loginUserDetails!.emailId == element.emailId)
                ? Text(
                    "You can add assignments and other works for \nthe class",
                    textAlign: TextAlign.center,
                    style: customStyle(16, Colors.black, FontWeight.w500),
                  )
                : const SizedBox.shrink(),
          ],
        );
      },
    );
  }
}

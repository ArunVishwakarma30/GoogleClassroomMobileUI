import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hci_lms/controllers/auth_provider.dart';
import 'package:hci_lms/controllers/create_class_provider.dart';
import 'package:hci_lms/models/user_model.dart';
import 'package:hci_lms/views/app_constants.dart';
import 'package:hci_lms/views/common/custom_dialog.dart';
import 'package:hci_lms/views/common/custom_text_filed.dart';
import 'package:hci_lms/views/common/snackbar.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import '../../common/custom_text_style.dart';

class PeoplePage extends StatefulWidget {
  const PeoplePage({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<PeoplePage> createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {
  final TextEditingController _personEmailAddress = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);
    return Consumer<CreateClassProvider>(
      builder: (context, createClassProvider, child) {
        var currentClassRoomDetails =
            createClassProvider.allCreatedOrJoinedClasses[widget.index];
        return ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text("Teachers",
                        style: customStyle(22, darkThemeColor, FontWeight.normal)),
                    trailing: currentClassRoomDetails.classTeachers!.any(
                            (element) =>
                                authProvider.loginUserDetails!.emailId ==
                                element.emailId)
                        ? IconButton(
                            onPressed: () {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) => CustomDialog(
                                  controller: _personEmailAddress,
                                  personName: "Teacher",
                                  isStudent: false,
                                  onAddButtonTap: () {
                                    User? existingUser = authProvider
                                        .registeredUsers
                                        .firstWhereOrNull((user) =>
                                            user.emailId ==
                                            _personEmailAddress.text);
                                    if (existingUser != null) {
                                      bool isTeacherAlreadyExist =
                                          currentClassRoomDetails.classTeachers!
                                              .any((teacher) =>
                                                  _personEmailAddress.text ==
                                                  teacher.emailId);
                                      if (isTeacherAlreadyExist) {
                                        ShowSnackbar(
                                            title: "Failed",
                                            message: "Teacher already exist",
                                            icon: Icons.error_outline_outlined);
                                      } else {
                                        createClassProvider
                                            .allCreatedOrJoinedClasses[widget.index]
                                            .classTeachers!
                                            .add(existingUser);
                                        setState(() {});
                                      }
                                    } else {
                                      ShowSnackbar(
                                          title: "Failed",
                                          message: "User doesn't exist",
                                          icon: Icons.error_outline_outlined);
                                    }
                                    _personEmailAddress.text = "";
                                    Navigator.pop(context);
                                  },
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.person_add_alt_outlined,
                              color: darkThemeColor,
                            ),
                          )
                        : null,
                  ),
                  Divider(color: darkThemeColor, height: 0),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: currentClassRoomDetails.classTeachers!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          radius: 22,
                          backgroundColor: Colors.pink,
                          child: Text(
                            currentClassRoomDetails.classTeachers![index].fullName
                                .substring(0, 1),
                            style: customStyle(20, Colors.white, FontWeight.normal),
                          ),
                        ),
                        title: Text(
                          currentClassRoomDetails.classTeachers![index].fullName,
                          style: customStyle(15, Colors.black, FontWeight.normal),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.only(top: 10),
                    title: Text("Students",
                        style: customStyle(22, darkThemeColor, FontWeight.normal)),
                    trailing: currentClassRoomDetails.classTeachers!.any(
                            (element) =>
                                authProvider.loginUserDetails!.emailId ==
                                element.emailId)
                        ? IconButton(
                            onPressed: () {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return CustomDialog(
                                    controller: _personEmailAddress,
                                    personName: "Student",
                                    isStudent: true,
                                    onAddButtonTap: () {
                                      User? existingUser = authProvider
                                          .registeredUsers
                                          .firstWhereOrNull((user) =>
                                              user.emailId ==
                                              _personEmailAddress.text);

                                      if (existingUser != null) {
                                        bool isStudentAlreadyExist =
                                            currentClassRoomDetails.classStudents!
                                                .any((student) =>
                                                    _personEmailAddress.text ==
                                                    student.emailId);
                                        if (isStudentAlreadyExist) {
                                          ShowSnackbar(
                                              title: "Failed",
                                              message: "Student already exist",
                                              icon: Icons.error_outline_outlined);
                                        } else {
                                          createClassProvider
                                              .allCreatedOrJoinedClasses[
                                                  widget.index]
                                              .classStudents!
                                              .add(existingUser);
                                          setState(() {});
                                        }
                                      } else {
                                        ShowSnackbar(
                                            title: "Failed",
                                            message: "User doesn't exist",
                                            icon: Icons.error_outline_outlined);
                                      }
                                      _personEmailAddress.text = "";
                                      Navigator.pop(context);
                                    },
                                    inviteCode:
                                        currentClassRoomDetails.classInviteCode,
                                    onCopyButtonTap: () {
                                      Clipboard.setData(ClipboardData(
                                          text: currentClassRoomDetails
                                              .classInviteCode));
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text('Text copied to clipboard!'),
                                          duration: Duration(seconds: 1),
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            },
                            icon: Icon(
                              Icons.person_add_alt_outlined,
                              color: darkThemeColor,
                            ),
                          )
                        : null,
                  ),
                  Divider(color: darkThemeColor, height: 0),
                  currentClassRoomDetails.classStudents!.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: currentClassRoomDetails.classStudents!.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: CircleAvatar(
                                radius: 22,
                                backgroundColor: Colors.pink,
                                child: Text(
                                  currentClassRoomDetails
                                      .classStudents![index].fullName
                                      .substring(0, 1),
                                  style: customStyle(
                                      20, Colors.white, FontWeight.normal),
                                ),
                              ),
                              title: Text(
                                currentClassRoomDetails
                                    .classStudents![index].fullName,
                                style: customStyle(
                                    15, Colors.black, FontWeight.normal),
                              ),
                            );
                          },
                        )
                      : Column(
                          children: [
                            Container(
                                margin: const EdgeInsets.only(top: 40),
                                child: Center(child: SvgPicture.string(peopleSvg))),
                            const SizedBox(
                              height: 40,
                            ),
                            Center(
                                child: Text(
                              "Add students to your class",
                              style: customStyle(17, Colors.black, FontWeight.w500),
                            )),
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return CustomDialog(
                                          controller: _personEmailAddress,
                                          personName: "Student",
                                          isStudent: true,
                                          onAddButtonTap: () {
                                            User? existingUser = authProvider
                                                .registeredUsers
                                                .firstWhereOrNull((user) =>
                                                    user.emailId ==
                                                    _personEmailAddress.text);
                                            if (existingUser != null) {
                                              createClassProvider
                                                  .allCreatedOrJoinedClasses[
                                                      widget.index]
                                                  .classStudents!
                                                  .add(existingUser);
                                              setState(() {});
                                            } else {
                                              ShowSnackbar(
                                                  title: "Failed",
                                                  message: "User doesn't exist",
                                                  icon:
                                                      Icons.error_outline_outlined);
                                            }
                                            _personEmailAddress.text = "";
                                            Navigator.pop(context);
                                          },
                                          inviteCode: currentClassRoomDetails
                                              .classInviteCode,
                                          onCopyButtonTap: () {
                                            Clipboard.setData(ClipboardData(
                                                text: currentClassRoomDetails
                                                    .classInviteCode));
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'Text copied to clipboard!'),
                                                duration: Duration(seconds: 1),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: darkThemeColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6)),
                                  ),
                                  child: Text(
                                    "Add",
                                    style: customStyle(
                                        23, Colors.white, FontWeight.w500),
                                  )),
                            ),
                          ],
                        )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

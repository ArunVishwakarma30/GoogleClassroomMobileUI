import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hci_lms/controllers/auth_provider.dart';
import 'package:hci_lms/controllers/create_class_provider.dart';
import 'package:hci_lms/models/assignment_model.dart';
import 'package:hci_lms/models/class_details_model.dart';
import 'package:hci_lms/views/app_constants.dart';
import 'package:hci_lms/views/common/custom_text_style.dart';
import 'package:provider/provider.dart';

import '../../../models/user_model.dart';
import '../../common/create_class_text_field.dart';

class CreateClassFormPage extends StatefulWidget {
  const CreateClassFormPage({Key? key}) : super(key: key);

  @override
  State<CreateClassFormPage> createState() => _CreateClassFormPageState();
}

class _CreateClassFormPageState extends State<CreateClassFormPage> {
  late TextEditingController _classNameController;
  late TextEditingController _sectionController;
  late TextEditingController _roomController;
  late TextEditingController _subjectController;
  late ClassDetails classDetails;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _classNameController = TextEditingController();
    _sectionController = TextEditingController();
    _roomController = TextEditingController();
    _subjectController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _classNameController.dispose();
    _sectionController.dispose();
    _roomController.dispose();
    _subjectController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentFocus = FocusScope.of(context);
    final authProvider = Provider.of<AuthProvider>(context);
    return Consumer<CreateClassProvider>(
      builder: (context, createClassProvider, child) {
        return GestureDetector(
          onTap: () {
            if (currentFocus.hasFocus) {
              currentFocus.unfocus();
            }
          },
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: Container(
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      offset: Offset(0, 0.5),
                      blurRadius: 4.0,
                    )
                  ]),
                  child: AppBar(
                      elevation: 0.0,
                      leading: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(Icons.close)),
                      title: Text(
                        "Create Class",
                        style: customStyle(20, Colors.black, FontWeight.normal),
                      ),
                      actions: [
                        TextButton(
                          onPressed: createClassProvider.isCreateButtonEnabled
                              ? () {
                                  String? className = _classNameController.text;
                                  String? classSection =
                                      _sectionController.text;
                                  String? classRoom = _roomController.text;
                                  String? classSubject =
                                      _subjectController.text;
                                  List<User> students = [];
                                  List<User> teachers = [];
                                  List<Assignment> assignments = [];
                                  List<String> announcements = [];
                                  teachers.add(authProvider.loginUserDetails!);

                                  String inviteCode =
                                      createClassProvider.generateInviteCode(8);
                                  classDetails = ClassDetails(
                                      authProvider.loginUserDetails!,
                                      className,
                                      inviteCode,
                                      classSection: classSection.isNotEmpty
                                          ? classSection
                                          : "",
                                      classRoom:
                                          classRoom.isNotEmpty ? classRoom : "",
                                      classSubject: classSubject.isNotEmpty
                                          ? classSubject
                                          : "",
                                      classTeachers: teachers,
                                      classStudents: students,
                                      classAssignments: assignments,
                                      classAnnouncements: announcements);
                                  createClassProvider.createClass(classDetails);
                                }
                              : null,
                          style: TextButton.styleFrom(),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: Text(
                              "Create",
                              style: customStyle(
                                  16,
                                  createClassProvider.isCreateButtonEnabled
                                      ? darkThemeColor
                                      : Colors.black45,
                                  createClassProvider.isCreateButtonEnabled
                                      ? FontWeight.bold
                                      : FontWeight.normal),
                            ),
                          ),
                        ),
                      ])),
            ),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CreateClassTextField(
                    hintText: "Class name (required)",
                    textEditingController: _classNameController,
                    onTextChange: (String? value) {
                      if (value!.trim().isNotEmpty) {
                        createClassProvider.isCreateButtonEnabled = true;
                      } else {
                        createClassProvider.isCreateButtonEnabled = false;
                      }
                    },
                  ),
                  CreateClassTextField(
                    hintText: "Section",
                    textEditingController: _sectionController,
                  ),
                  CreateClassTextField(
                    hintText: "Room",
                    textEditingController: _roomController,
                  ),
                  CreateClassTextField(
                    hintText: "Subject",
                    textEditingController: _subjectController,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

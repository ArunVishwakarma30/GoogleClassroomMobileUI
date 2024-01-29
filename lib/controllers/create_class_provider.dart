import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hci_lms/models/class_details_model.dart';
import 'package:hci_lms/views/ui/main/home_page.dart';

class CreateClassProvider extends ChangeNotifier {
  bool _isCreateButtonEnabled = false;
  List<ClassDetails> allCreatedOrJoinedClasses = [];

  List<ClassDetails> loggedInUsersAllClass = [];

  bool get isCreateButtonEnabled => _isCreateButtonEnabled;

  set isCreateButtonEnabled(bool value) {
    _isCreateButtonEnabled = value;
    notifyListeners();
  }

  String generateInviteCode(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => chars.codeUnitAt(random.nextInt(chars.length)),
      ),
    );
  }

  // create class
  void createClass(ClassDetails model) {
    allCreatedOrJoinedClasses.add(model);
    Get.offAll(() => const HomePage());
  }

  // return all the class in which a particular user is exist
  void myClasses(String emailId) {
    loggedInUsersAllClass.clear(); // Clear the existing list
    for (ClassDetails classDetails in allCreatedOrJoinedClasses) {
      if (classDetails.classStudents != null &&
          classDetails.classStudents!.any((user) => user.emailId == emailId)) {
        loggedInUsersAllClass.add(classDetails);
      }
      if (classDetails.classTeachers != null &&
          classDetails.classTeachers!.any((user) => user.emailId == emailId)) {
        loggedInUsersAllClass.add(classDetails);
      }
    }
  }
}

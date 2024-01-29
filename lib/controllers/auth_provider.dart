import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hci_lms/models/user_model.dart';
import 'package:hci_lms/views/app_constants.dart';
import 'package:hci_lms/views/common/snackbar.dart';
import 'package:hci_lms/views/ui/main/home_page.dart';

class AuthProvider extends ChangeNotifier {

  // secure text
  bool _textSecure = true;
  User? loginUserDetails;
  List<User> registeredUsers = [];


  bool get textSecure => _textSecure;

  void setSecure() {
    if (_textSecure) {
      _textSecure = false;
    } else {
      _textSecure = true;
    }
    notifyListeners();
  }

  bool isValidEmail(String email) {
    // Define a regular expression for email validation
    final RegExp emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
    );

    // Check if the email matches the regular expression
    return emailRegex.hasMatch(email);
  }

  void updateRegisteredUsersList(User model){
    registeredUsers.add(model);
  }

  // user login
  void login(User model) {
    loginUserDetails = model;
    ShowSnackbar(title: "Successfully", message: "Logged In", icon: Icons.done, textColor: Colors.white, bgColor: darkThemeColor);
    Get.offAll(() => const HomePage());
  }
}
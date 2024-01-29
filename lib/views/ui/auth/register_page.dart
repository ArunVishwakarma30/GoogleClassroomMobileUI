import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hci_lms/models/user_model.dart';
import 'package:hci_lms/views/app_constants.dart';
import 'package:hci_lms/views/common/snackbar.dart';
import 'package:provider/provider.dart';

import '../../../controllers/auth_provider.dart';
import '../../common/buttin_with_icon.dart';
import '../../common/custom_elevated_button.dart';
import '../../common/custom_text_filed.dart';
import '../../common/custom_text_style.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _nameController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentFocus = FocusScope.of(context);

    return SafeArea(
      child: GestureDetector(
        onTap: () {
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Consumer<AuthProvider>(
              builder: (context, authProvider, child) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 23, vertical: 30),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Register",
                            style:
                                customStyle(25, Colors.black, FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Enter your account details to Register",
                            style: customStyle(
                                19, Colors.black45, FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          CustomTextField(
                            hintText: "Enter full name",
                            textEditingController: _nameController,
                            textInputType: TextInputType.text,
                            hideText: false,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your full name!';
                              } else {
                                List<String?> nameCount =
                                    value.trim().split(" ");
                                if (nameCount.length > 1) {
                                  return null;
                                } else {
                                  return "Please enter both First Name and Last Name";
                                }
                              }
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          CustomTextField(
                            hintText: "Enter Email",
                            textEditingController: _emailController,
                            textInputType: TextInputType.emailAddress,
                            hideText: false,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an email address!';
                              } else {
                                bool validated =
                                    authProvider.isValidEmail(value);
                                if (validated) {
                                  return null;
                                } else {
                                  return "Please enter a valid Email address";
                                }
                              }
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          CustomTextField(
                            hintText: "Enter password",
                            textEditingController: _passwordController,
                            textInputType: TextInputType.text,
                            hideText: authProvider.textSecure,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                authProvider.setSecure();
                              },
                              child: authProvider.textSecure
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.visibility),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Please enter valid password";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Forget password?",
                            style: customStyle(
                                17, Colors.black45, FontWeight.normal),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomElevatedButton(
                              onButtonTap: () {
                                if (_formKey.currentState!.validate()) {
                                  if (currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                  User user = User(_nameController.text,
                                      _emailController.text,
                                      password: _passwordController.text);
                                  authProvider.updateRegisteredUsersList(user);
                                  // Get.back(result: user);
                                  Get.back();
                                  ShowSnackbar(
                                      title: "Successfully Registered",
                                      message: "Please Login!",
                                      icon: Icons.done_outline,
                                      bgColor: darkThemeColor,
                                      textColor: Colors.white);
                                }
                              },
                              text: "Register"),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
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
                                style: customStyle(
                                    22, Colors.black, FontWeight.normal),
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
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ButtonWithIcon(
                                  text: "Google",
                                  imageUrl:
                                      "http://pngimg.com/uploads/google/google_PNG19635.png"),
                              ButtonWithIcon(
                                  text: "Facebook",
                                  imageUrl:
                                      "https://static.vecteezy.com/system/resources/previews/018/930/702/original/facebook-logo-facebook-icon-transparent-free-png.png"),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already an user? ",
                                style: customStyle(
                                    18, Colors.black, FontWeight.normal),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: Text(
                                  "Log in",
                                  style: customStyle(
                                          18, Colors.black, FontWeight.bold)
                                      .copyWith(
                                          decoration: TextDecoration.underline),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            )),
      ),
    );
  }
}

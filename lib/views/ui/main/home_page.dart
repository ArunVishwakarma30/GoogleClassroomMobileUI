import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hci_lms/controllers/auth_provider.dart';
import 'package:hci_lms/controllers/create_class_provider.dart';
import 'package:hci_lms/views/app_constants.dart';
import 'package:hci_lms/views/common/custom_text_style.dart';
import 'package:hci_lms/views/ui/auth/login_page.dart';
import 'package:hci_lms/views/ui/bottom_navbar/nav_bar.dart';
import 'package:hci_lms/views/ui/main/classroom_container.dart';
import 'package:hci_lms/views/ui/main/create_class_form_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final authProvider = Provider.of<AuthProvider>(context);
    return Consumer<CreateClassProvider>(
      builder: (context, createClassProvider, child) {
        createClassProvider.myClasses(authProvider.loginUserDetails!.emailId);

        return Scaffold(
          appBar: AppBar(
            backgroundColor: darkThemeColor,
            elevation: 5,
            title: Text(
              "IT Classroom",
              style: customStyle(24, Colors.white, FontWeight.normal),
            ),
            actions: [
              PopupMenuButton(
                onSelected: (value) {
                  Get.offAll(() => const LoginPage());
                  authProvider.loginUserDetails = null;
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                      value: "Log out",
                      child: Text(
                        "Log out",
                        style: customStyle(15, Colors.black, FontWeight.normal),
                      ))
                ],
              )
            ],
          ),
          body: createClassProvider.loggedInUsersAllClass.isNotEmpty
              ? ListView.builder(
                  itemCount: createClassProvider.loggedInUsersAllClass.length,
                  itemBuilder: (context, index) {
                    return ClassRoomContainer(
                      onTap: () {
                        Get.to(() => BottomNavBar(
                              index: index,
                            ));
                      },
                      details: createClassProvider.loggedInUsersAllClass[index],
                      imageUrl:
                          classRoomImageUrls[index % classRoomImageUrls.length],
                    );
                  },
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: height * 0.2,
                    ),
                    SvgPicture.string(createClassSvg),
                    Text(
                      "Add a class to get started",
                      style: customStyle(16, Colors.black, FontWeight.normal),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Get.to(() => const CreateClassFormPage(),
                                transition: Transition.rightToLeft);
                          },
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          child: Text(
                            "Create class",
                            style: customStyle(
                                18, darkThemeColor, FontWeight.normal),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 20),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              backgroundColor: darkThemeColor),
                          child: Text(
                            "Join class",
                            style: customStyle(
                                18, Colors.white, FontWeight.normal),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  context: context,
                  builder: (context) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 25, horizontal: 30),
                      width: width,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              "Join class",
                              style: customStyle(
                                  18, Colors.black, FontWeight.normal),
                            ),
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              Get.to(() => const CreateClassFormPage(),
                                  transition: Transition.rightToLeft);
                            },
                            child: Text(
                              "Create class",
                              style: customStyle(
                                  18, Colors.black, FontWeight.normal),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              shape: const CircleBorder(),
              backgroundColor: Colors.white,
              child: Icon(
                Icons.add,
                color: darkThemeColor,
              )),
        );
      },
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hci_lms/controllers/create_class_provider.dart';
import 'package:hci_lms/controllers/navbar_provider.dart';
import 'package:hci_lms/models/class_details_model.dart';
import 'package:hci_lms/views/app_constants.dart';
import 'package:hci_lms/views/ui/bottom_navbar/people_page.dart';
import 'package:provider/provider.dart';

import '../../../controllers/auth_provider.dart';
import '../../common/custom_text_style.dart';
import 'announcements_page.dart';
import 'classwork_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late List<Widget> pages;

  @override
  void initState() {
    super.initState();
    pages = [
      AnnouncementsPage(index: widget.index),
      ClassworkPage(index: widget.index),
      PeoplePage(index: widget.index),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final createClassProvider = Provider.of<CreateClassProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    return Consumer<NavbarProvider>(
      builder: (context, navProvider, child) {
        var classDetails =
            createClassProvider.allCreatedOrJoinedClasses[widget.index];
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Container(
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.black45,
                    offset: Offset(0, 0.5),
                    blurRadius: 4.0)
              ]),
              child: AppBar(
                iconTheme: IconThemeData(color: darkThemeColor),
                title: Text(
                  navProvider.selectedIndex == 0 ? "" : classDetails.className,
                  style: customStyle(24, darkThemeColor, FontWeight.normal),
                ),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Center(
              child: pages.elementAt(navProvider.selectedIndex),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: navProvider.selectedIndex,
            selectedItemColor: darkThemeColor,
            onTap: (value) {
              navProvider.selectedIndex = value;
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.chat_outlined),
                label: 'Announcements',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.assignment),
                label: 'Classwork',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people),
                label: 'People',
              ),
            ],
          ),
          floatingActionButton: (navProvider.selectedIndex == 1) &&
                  (classDetails.classTeachers!.any((element) =>
                      authProvider.loginUserDetails!.emailId ==
                      element.emailId))
              ? FloatingActionButton(
                  onPressed: () {},
                  shape: const CircleBorder(),
                  child: const Icon(Icons.add),
                )
              : null,
        );
      },
    );
  }
}

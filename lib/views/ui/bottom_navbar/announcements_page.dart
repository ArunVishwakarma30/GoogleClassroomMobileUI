import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hci_lms/controllers/auth_provider.dart';
import 'package:hci_lms/views/app_constants.dart';
import 'package:provider/provider.dart';

import '../../../controllers/create_class_provider.dart';
import '../../common/custom_text_style.dart';

class AnnouncementsPage extends StatefulWidget {
  const AnnouncementsPage({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<AnnouncementsPage> createState() => _AnnouncementsPageState();
}

class _AnnouncementsPageState extends State<AnnouncementsPage> {
  @override
  Widget build(BuildContext context) {
    final createClassProvider = Provider.of<CreateClassProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    var details = createClassProvider.allCreatedOrJoinedClasses[widget.index];
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Container(
            width: width - 20,
            height: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                    image: NetworkImage(
                      classRoomImageUrls[
                          widget.index % classRoomImageUrls.length],
                    ),
                    fit: BoxFit.cover)),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                      child: SizedBox(
                    height: 1,
                  )),
                  Text(
                    details.className,
                    style: customStyle(30, Colors.white, FontWeight.w300),
                  ),
                  details.classSection!.isNotEmpty
                      ? Text(
                          details.classSection!,
                          style: customStyle(17, Colors.white, FontWeight.w300),
                        )
                      : const SizedBox.shrink()
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Colors.white,
            child: ListTile(
              leading: CircleAvatar(
                radius: 22,
                backgroundColor: Colors.pink,
                child: Text(
                  authProvider.loginUserDetails!.fullName.substring(0, 1),
                  style: customStyle(20, Colors.white, FontWeight.normal),
                ),
              ),
              title: Text(
                "Announce something to your class",
                style: customStyle(15, Colors.black45, FontWeight.normal),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 40, bottom: 50),
                  child: SvgPicture.string(
                    announcementSvg,
                  )),
              Text(
                details.classTeachers!.any((element) =>
                        authProvider.loginUserDetails!.emailId ==
                        element.emailId)
                    ? "This is where you can talk to your class"
                    : "This is where you’ll see updates for this class",
                style: customStyle(16, Colors.black, FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                details.classTeachers!.any((element) =>
                        authProvider.loginUserDetails!.emailId ==
                        element.emailId)
                    ? "Use this announcement section to share announcements and post assignments"
                    : "Use this announcement section to connect with your class and check for announcements",
                textAlign: TextAlign.center,
                style: customStyle(16, Colors.black, FontWeight.w500),
              ),
            ],
          ),
        )
      ],
    );
  }
}

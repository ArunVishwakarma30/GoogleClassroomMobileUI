import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hci_lms/models/class_details_model.dart';
import 'package:hci_lms/views/common/custom_text_style.dart';

class ClassRoomContainer extends StatefulWidget {
  const ClassRoomContainer(
      {Key? key, required this.details, required this.imageUrl, required this.onTap})
      : super(key: key);
  final ClassDetails details;
  final String imageUrl;
  final VoidCallback onTap;

  @override
  State<ClassRoomContainer> createState() => _ClassRoomContainerState();
}

class _ClassRoomContainerState extends State<ClassRoomContainer> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: widget.onTap,
      child:
      Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Container(
          width: width - 20,
          height: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                  image: NetworkImage(
                    widget.imageUrl,
                  ),
                  fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.details.className,
                      style: customStyle(30, Colors.white, FontWeight.w300),
                    ),
                    GestureDetector(
                      onTap: (){
                        print("Here implement popup menu buttons, for various activity");
                        },
                      child: const Icon(
                        Icons.more_vert,
                        size: 25,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                widget.details.classSection!.isNotEmpty
                    ? Text(
                        widget.details.classSection!,
                        style: customStyle(17, Colors.white, FontWeight.w300),
                      )
                    : const SizedBox.shrink(),
                const Expanded(
                    child: SizedBox(
                  height: 1,
                )),
                Text(
                  "${widget.details.classStudents != null ? widget.details.classStudents!.length : '0'} students",
                  style: customStyle(15, Colors.white, FontWeight.w300),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

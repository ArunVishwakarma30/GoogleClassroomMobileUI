import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hci_lms/views/common/post_assignment_tile.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

import '../../app_constants.dart';
import '../../common/custom_text_style.dart';

class PostAssignmentPage extends StatefulWidget {
  const PostAssignmentPage({Key? key}) : super(key: key);

  @override
  State<PostAssignmentPage> createState() => _PostAssignmentPageState();
}

class _PostAssignmentPageState extends State<PostAssignmentPage> {
  File? attachedFile;

  Future<void> openFiles(File file) async {
    final filePath = file.path;
    await OpenFilex.open(filePath);
  }

  @override
  Widget build(BuildContext context) {
    final focusScope = FocusScope.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.black45, offset: Offset(0, 0.5), blurRadius: 4.0)
          ]),
          child: AppBar(
            iconTheme: IconThemeData(color: darkThemeColor),
            actions: [
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: darkThemeColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                  ),
                  child: Text(
                    "Post",
                    style: customStyle(20, Colors.white, FontWeight.w500),
                  )),
              const SizedBox(
                width: 20,
              )
            ],
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          if (focusScope.hasFocus) {
            focusScope.unfocus();
          }
        },
        child: ListView(
          children: [
            PostAssignmentTile(
                icon: const Icon(Icons.announcement_outlined),
                titleWidget: TextField(
                  style: customStyle(18, Colors.black, FontWeight.w400),
                  minLines: 1,
                  maxLines: 5,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                      hintText: "Announce something to your class",
                      hintStyle:
                          customStyle(16, Colors.black45, FontWeight.normal)),
                )),
            GestureDetector(
              onTap: () async {
                final result = await FilePicker.platform.pickFiles();
                if (result == null) return;

                // open single file
                final file = result.files.first;
                File savedFile = await saveFilePermanently(file);
                setState(() {
                  attachedFile = savedFile;
                });
                print(savedFile.path.split('/').last);
                print(savedFile.path.split('.').last);
              },
              child: PostAssignmentTile(
                icon: const Icon(Icons.attach_file_outlined),
                titleWidget: Text("Add attachment",
                    style: customStyle(
                      16,
                      Colors.black45,
                      FontWeight.normal,
                    )),
              ),
            ),
            attachedFile != null
                ? GestureDetector(
                    onTap: () {
                      openFiles(attachedFile!);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                      child: Image.file(attachedFile!, fit: BoxFit.contain, width: 300, height: 300,),
                    ))
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }

  Future<File> saveFilePermanently(PlatformFile file) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final newFile = File('${appStorage.path}/${file.name}');

    return File(file.path!).copy(newFile.path);
  }
}

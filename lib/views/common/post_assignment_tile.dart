import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostAssignmentTile extends StatelessWidget {
  const PostAssignmentTile({Key? key, required this.titleWidget, required this.icon}) : super(key: key);
  final Widget titleWidget;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: icon,
          title: titleWidget,
        ),
        Divider()
      ],
    );
  }
}

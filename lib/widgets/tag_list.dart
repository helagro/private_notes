import 'package:flutter/material.dart';
import 'package:opnot/main.dart';
import 'package:opnot/res/colors_main.dart';
import 'package:opnot/widgets/tag_list_item.dart';

class TagList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TagListState();
}

class _TagListState extends State {
  List<String> tags = [
    "house",
    "tanks",
    "sponsor",
    "happens sometimes",
    "watch face",
    "good"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 4, bottom: 1),
      color: ColorsMain.darkBackground,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: tags.length,
        itemBuilder: (context, index) {
          return TagListItem(isSelected: index == 1, tagName: tags[index]);
        },
      ),
    );
  }
}

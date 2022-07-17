import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:opnot/res/colors_main.dart';
import 'package:opnot/res/dimensions.dart';

class TagListItem extends StatelessWidget {
  const TagListItem(
      {Key? key, this.isSelected = false, this.onClick, required this.tagName})
      : super(key: key);

  final bool isSelected;
  final void Function(int)? onClick;
  final String tagName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: Dimensions.tagListWidth - 20),
          child: Card(
            elevation: Dimensions.elevation6,
            margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
            color: ColorsMain.primaryB9,
            child: TextButton(
              style: TextButton.styleFrom(
                  minimumSize: const Size(0, 30),
                  alignment: Alignment.centerLeft,
                  textStyle: const TextStyle(),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 0)),
              onPressed: () => onClick?.call(-1),
              child: Text(
                tagName,
                textAlign: TextAlign.left,
                softWrap: true,
                maxLines: 9,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Color(0xfffefefe), height: 1, fontSize: 15),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

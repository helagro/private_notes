import 'package:flutter/material.dart';
import 'package:opnot/res/colors_main.dart';
import 'package:opnot/res/dimensions.dart';
import 'package:opnot/widgets/app_bar_container.dart';
import 'package:opnot/widgets/app_bar_main.dart';
import 'package:opnot/widgets/editor_options_desktop.dart';
import 'package:opnot/widgets/tag_list.dart';
import 'package:opnot/widgets/tag_list_item.dart';

import '../../widgets/editor.dart';
import '../../widgets/editor_options_mobile.dart';
import '../../widgets/note_list/note_list.dart';
import '../../widgets/note_list_options.dart';

class EditorScreenDesktop extends StatelessWidget {
  const EditorScreenDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Row(
        children: [
          ConstrainedBox(
              constraints: BoxConstraints(maxWidth: Dimensions.tagListWidth),
              child: AppBarContainer(
                content: TagList(),
                appBar: AppBarMain(children: [
                  Container(
                    margin: const EdgeInsets.only(left: 5),
                    child: Text(
                      "Tags",
                      style: TextStyle(
                          color: ColorsMain.primary,
                          fontWeight: FontWeight.w600),
                    ),
                  )
                ]),
              )),
          ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 280),
              child: AppBarContainer(
                appBar: NoteListOptions(),
                content: const NoteList(),
              )),
          Container(
            width: 1,
            color: ColorsMain.background,
          ),
          const Expanded(
              child: AppBarContainer(
                  content: EditorWidget(), appBar: EditorOptionsDesktop())),
        ],
      ),
    ));
  }
}

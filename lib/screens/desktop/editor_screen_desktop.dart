import 'package:flutter/material.dart';
import 'package:opnot/res/colors_main.dart';
import 'package:opnot/res/dimensions.dart';
import 'package:opnot/widgets/app_bars/app_bar_container.dart';
import 'package:opnot/widgets/app_bars/app_bar_main.dart';
import 'package:opnot/widgets/app_bars/editor_options_desktop.dart';
import 'package:opnot/widgets/app_bars/tag_options.dart';
import 'package:opnot/widgets/menu_main/menu_content.dart';
import 'package:opnot/widgets/menu_main/menu_widget.dart';
import 'package:opnot/widgets/tag_list.dart';
import 'package:opnot/widgets/tag_list_item.dart';

import '../../widgets/editor.dart';
import '../../widgets/app_bars/editor_options_mobile.dart';
import '../../widgets/note_list/note_list.dart';
import '../../widgets/app_bars/note_list_options.dart';

class EditorScreenDesktop extends StatelessWidget {
  const EditorScreenDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          LayoutBuilder(builder: ((context, constraints) {
            if (MediaQuery.of(context).size.width <
                Dimensions.minWidthForTagList) {
              return Container();
            }
            return ConstrainedBox(
                constraints: BoxConstraints(maxWidth: Dimensions.tagListWidth),
                child: AppBarContainer(
                  content: const MenuWidget(),
                  appBar: TagOptions(),
                ));
          })),
          ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 280),
              child: const AppBarContainer(
                appBar: NoteListOptions(),
                content: NoteList(),
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
    );
  }
}

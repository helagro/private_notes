import 'package:flutter/material.dart';
import 'package:opnot/widgets/app_bars/app_bar_container.dart';
import 'package:opnot/widgets/app_bars/editor_options_mobile.dart';
import '../../widgets/editor.dart';

class EditorScreenMobile extends StatelessWidget {
  const EditorScreenMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppBarContainer(
          content: const EditorWidget(), appBar: EditorOptionsMobile()),
    );
  }
}

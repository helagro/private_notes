import 'package:flutter/material.dart';
import 'package:private_notes/widgets/editor_options_mobile.dart';
import '../../widgets/editor.dart';

class EditorScreenMobile extends StatelessWidget {
  const EditorScreenMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(children: [EditorOptionsMobile(), EditorWidget()]),
    ));
  }
}

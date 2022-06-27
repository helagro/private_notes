import 'package:flutter/material.dart';
import 'package:opnot/widgets/icon_button_main.dart';

import '../logic/dropbox_handler.dart';

class AccessCodeInput extends StatelessWidget {
  DropboxHandler _dropboxHandler = DropboxHandler.getInstance();
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 450),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration:
                  const InputDecoration(labelText: "Enter access code here"),
            ),
          ),
          IconButtonMain(
              iconData: Icons.send, onPressed: () => doStuff(context))
        ],
      ),
    );
  }

  void doStuff(BuildContext context) async {
    await _dropboxHandler.generateToken(_controller.text);
    print("will upload");

    Navigator.pushNamed(context, "/editor");
    //await dropboxHandler.upload(Note("titel", "coontent"));
  }
}

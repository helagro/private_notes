import 'package:flutter/material.dart';
import 'package:private_notes/logic/dropbox_handler.dart';

import '../data_types/note.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            TextButton(
              child: Text("do something"),
              onPressed: () {
                DropboxHandler().authorize();
              },
            ),
            TextField(
              onChanged: (value) {
                doStuff(value);
              },
            )
          ],
        ),
      ),
    );
  }

  void doStuff(value) async {
    DropboxHandler dropboxHandler = DropboxHandler.getInstance();
    await dropboxHandler.token(value);
    print("will upload");
    await dropboxHandler.upload(Note("titel", "content"));
  }
}

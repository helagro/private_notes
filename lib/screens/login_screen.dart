import 'package:flutter/material.dart';
import 'package:opnot/logic/dropbox_handler.dart';

import '../data_types/note.dart';

class LoginScreen extends StatelessWidget {
  DropboxHandler dropboxHandler = DropboxHandler.getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              TextButton(
                child: Text("do something"),
                onPressed: () {
                  dropboxHandler.authorize();
                },
              ),
              TextField(
                onChanged: (value) {
                  doStuff(value, context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void doStuff(value, context) async {
    await dropboxHandler.generateToken(value);
    print("will upload");
    Navigator.pushNamed(context, "/editor");
    //await dropboxHandler.upload(Note("titel", "coontent"));
  }
}

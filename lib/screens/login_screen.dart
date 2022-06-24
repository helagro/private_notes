import 'package:flutter/material.dart';
import 'package:private_notes/logic/dropbox_handler.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        child: Text("do something"),
        onPressed: () {
          DropboxHandler().authorize();
        },
      ),
    );
  }
}

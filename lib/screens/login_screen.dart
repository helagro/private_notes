import 'package:flutter/material.dart';
import 'package:private_notes/logic/dropbox_handler.dart';

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
                DropboxHandler().token(value);
              },
            )
          ],
        ),
      ),
    );
  }
}

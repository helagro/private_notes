import 'package:flutter/material.dart';
import 'package:opnot/logic/dropbox_handler.dart';
import 'package:opnot/widgets/access_code_input.dart';

import '../data_types/note.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  DropboxHandler dropboxHandler = DropboxHandler.getInstance();
  bool showAccessCodeField = false;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Container(
                  margin: EdgeInsets.only(bottom: screenHeight * 0.2),
                  child: Column(
                    children: [
                      TextButton(
                        style: ButtonStyle(
                            fixedSize:
                                MaterialStateProperty.all(const Size(300, 45)),
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xff0061fe)),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white)),
                        onPressed: onConnectDropboxPress,
                        child: const Text("Connect Dropbox"),
                      ),
                      Container(
                        height: 5,
                      ),
                      showAccessCodeField ? AccessCodeInput() : Container()
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onConnectDropboxPress() {
    dropboxHandler.authorize();
    setState(() {
      showAccessCodeField = true;
    });
  }
}

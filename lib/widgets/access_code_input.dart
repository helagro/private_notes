import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opnot/widgets/icon_button_main.dart';

import '../logic/dropbox_handler.dart';

class AccessCodeInput extends StatefulWidget {
  @override
  State<AccessCodeInput> createState() => _AccessCodeInputState();
}

class _AccessCodeInputState extends State<AccessCodeInput> {
  final DropboxHandler _dropboxHandler = DropboxHandler.getInstance();
  final TextEditingController _controller = TextEditingController();
  bool _authCodeFormatIsValid = false;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 450),
      child: Row(
        children: [
          Expanded(
            child: CupertinoTextField(
              controller: _controller,
              placeholder: "Enter access code here",
              onChanged: onChanged,
            ),
          ),
          _authCodeFormatIsValid
              ? IconButtonMain(
                  iconData: CupertinoIcons.arrow_right_circle,
                  onPressed: () => submitCode(context))
              : Container()
        ],
      ),
    );
  }

  void onChanged(String value) {
    final bool newAuthCodeFormatIsValid = value.isNotEmpty;

    if (newAuthCodeFormatIsValid != _authCodeFormatIsValid) {
      setState(() {
        _authCodeFormatIsValid = newAuthCodeFormatIsValid;
      });
    }
  }

  void submitCode(BuildContext context) async {
    await _dropboxHandler.generateToken(_controller.text);

    if (!mounted) return;
    Navigator.pushNamed(context, "/editor");
    //await dropboxHandler.upload(Note("titel", "coontent"));
  }
}

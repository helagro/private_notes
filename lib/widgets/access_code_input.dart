import 'package:flutter/cupertino.dart';
import 'package:opnot/widgets/icon_button_main.dart';

import '../logic/dropbox/dropbox_handler.dart';

class AccessCodeInput extends StatefulWidget {
  const AccessCodeInput({Key? key}) : super(key: key);

  @override
  State<AccessCodeInput> createState() => _AccessCodeInputState();
}

class _AccessCodeInputState extends State<AccessCodeInput> {
  final TextEditingController _controller = TextEditingController();
  bool authCodeFormatIsValid = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: ConstrainedBox(
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
            authCodeFormatIsValid
                ? IconButtonMain(
                    iconData: CupertinoIcons.arrow_right_circle,
                    onPressed: () => submitCode(context))
                : Container()
          ],
        ),
      ),
    );
  }

  void onChanged(String value) {
    final bool newAuthCodeFormatIsValid = value.isNotEmpty;

    if (newAuthCodeFormatIsValid != authCodeFormatIsValid) {
      setState(() {
        authCodeFormatIsValid = newAuthCodeFormatIsValid;
      });
    }
  }

  void submitCode(BuildContext context) async {
    await DropboxHandler.getAuth().aquireToken(_controller.text);

    if (!mounted) return;
    Navigator.pushNamed(context, "/editor");
  }
}

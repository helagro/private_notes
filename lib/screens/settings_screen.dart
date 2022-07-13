import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opnot/main.dart';
import 'package:opnot/res/colors_main.dart';
import 'package:opnot/widgets/app_bar_main.dart';
import 'package:opnot/widgets/icon_button_main.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
          child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 450, maxHeight: 300),
          child: Container(
            color: Theme.of(context).colorScheme.primaryContainer,
            margin: const EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                AppBarMain(children: [
                  IconButtonMain(
                    iconData: Icons.arrow_back,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ]),
                Text("Settings",
                    style: TextStyle(
                        fontSize: 30,
                        height: 1.5,
                        color: ColorsMain.textColor)),
                Container(
                    margin: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Flexible(
                              child: Text(
                                "Encryption password",
                                softWrap: true,
                                style: TextStyle(fontSize: 18),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: CupertinoTextField(
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: true,
                              ),
                            )
                          ],
                        ),
                      ],
                    )),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 120,
                      child: TextButton(
                          onPressed: () {
                            print("save");
                          },
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                  const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Theme.of(context)
                                      .colorScheme
                                      .secondaryContainer)),
                          child: const Text("Save",
                              style: TextStyle(fontSize: 16))),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}

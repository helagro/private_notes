import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opnot/res/colors_main.dart';
import 'package:opnot/widgets/action_button.dart';
import 'package:opnot/widgets/app_bars/app_bar_main.dart';
import 'package:opnot/widgets/icon_button_main.dart';
import 'package:opnot/widgets/input_row.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsMain.background,
      body: SafeArea(
          child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 450, maxHeight: 300),
          child: Container(
            color: ColorsMain.primaryContainer,
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
                      children: const [
                        InputRow(
                            labelText: "Encryption password",
                            inputWidget: CupertinoTextField(
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                            )),
                      ],
                    )),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                        height: 50,
                        width: 120,
                        child: ActionButton(
                          title: "Save",
                          onPressed: save,
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }

  void save() {}
}

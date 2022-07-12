import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400, maxHeight: 300),
          child: Container(
            color: Colors.red,
            margin: const EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                const Text("Settings", style: TextStyle(fontSize: 30)),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: const [
                    Text("Encyption password"),
                    Expanded(
                      child: CupertinoTextField(
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                      ),
                    )
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          print("save");
                        },
                        child: Text("Save"))
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

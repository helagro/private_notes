import 'package:flutter/material.dart';

class NoteListOptions extends StatefulWidget {
  const NoteListOptions({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NoteListOptionsState();
}

class _NoteListOptionsState extends State<NoteListOptions> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SizedBox.expand(
          child: Container(
            padding: const EdgeInsets.all(30),
            color: Colors.red,
              child: Row(children: const [
                
              ]),
            ),
        ));
  }
}

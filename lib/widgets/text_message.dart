import 'package:flutter/material.dart';

class TextMessage extends StatelessWidget {
  final String _message;

  const TextMessage(this._message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      child: Text(
        _message,
        style: const TextStyle(fontSize: 20),
        textAlign: TextAlign.center,
      ),
    );
  }
}

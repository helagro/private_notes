import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputRow extends StatelessWidget {
  const InputRow({Key? key, required this.labelText, required this.inputWidget})
      : super(key: key);

  final String labelText;
  final Widget inputWidget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(
            labelText,
            softWrap: true,
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: inputWidget,
        )
      ],
    );
  }
}

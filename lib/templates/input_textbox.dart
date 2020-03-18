import 'package:employee_public_transport/templates/text_field_decorator.dart';
import 'package:flutter/material.dart';

class InputTextbox extends StatelessWidget {
  final String _text;
  final TextEditingController _controller;
  final TextInputType _keyboardType;

  InputTextbox(this._text, this._controller, this._keyboardType);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: _controller,
          keyboardType: _keyboardType,
          decoration: textFieldDecorator(_text),
        ),
        SizedBox(height: 10.0),
      ],
    );
  }
}
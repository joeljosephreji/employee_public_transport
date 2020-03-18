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
          decoration: InputDecoration(
              labelText: _text,
              labelStyle: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green))),
        ),
        SizedBox(height: 10.0),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OTPTextFields extends StatefulWidget {
  final int digitCount;

  const OTPTextFields({
    Key? key,
    required this.digitCount,
  }) : super(key: key);

  @override
  _OTPTextFieldsState createState() => _OTPTextFieldsState();
}

class _OTPTextFieldsState extends State<OTPTextFields> {
  final List<TextEditingController> _digitControllers = [];
  final List<FocusNode> _digitNodes = [];
  final List<FocusNode> _listenerNodes = [];
  final List<bool> _deleteFlags = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.digitCount; i++) {
      _digitControllers.add(TextEditingController());
      _digitNodes.add(FocusNode());
      _listenerNodes.add(FocusNode());
      _deleteFlags.add(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _digitFields(),
    );
  }

  List<Widget> _digitFields() {
    final List<Widget> _fields = [];
    for (int i = 0; i < widget.digitCount; i++) {
      _fields.add(
        SizedBox(
          width: 30,
          child: RawKeyboardListener(
            focusNode: _listenerNodes[i],
            onKey: (event) {
              if (event.logicalKey == LogicalKeyboardKey.backspace) {
                if (_digitControllers[i].text == "") {
                  if (i > 0) {
                    if (_deleteFlags[i]) {
                      _deleteFlags[i] = false;
                      FocusScope.of(context).requestFocus(_digitNodes[i - 1]);
                    } else {
                      _deleteFlags[i] = true;
                    }
                  }
                }
              }
            },
            child: TextField(
              controller: _digitControllers[i],
              focusNode: _digitNodes[i],
              maxLength: 1,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                if (value != "") {
                  if (i < widget.digitCount - 1) {
                    FocusScope.of(context).requestFocus(_digitNodes[i + 1]);
                  } else {
                    FocusScope.of(context).unfocus();
                  }
                }
              },
              decoration: const InputDecoration(
                counterText: "",
                contentPadding: EdgeInsets.all(0),
              ),
            ),
          ),
        ),
      );
      if (i < widget.digitCount - 1) {
        _fields.add(
          const SizedBox(width: 6),
        );
      }
    }
    return _fields;
  }

  @override
  void dispose() {
    for (int i = 0; i < widget.digitCount; i++) {
      _digitControllers[i].dispose();
      _digitNodes[i].dispose();
    }
    super.dispose();
  }
}

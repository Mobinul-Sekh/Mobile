// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OTPTextFields extends StatefulWidget {
  final int digitCount;
  final GlobalKey<FormState>? formKey;
  final String? error;

  const OTPTextFields({
    Key? key,
    required this.digitCount,
    this.formKey,
    this.error,
  }) : super(key: key);

  @override
  _OTPTextFieldsState createState() => _OTPTextFieldsState();
}

class _OTPTextFieldsState extends State<OTPTextFields> {
  final List<TextEditingController> _digitControllers = [];
  String? error;
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
    error = widget.error;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: widget.formKey ?? GlobalKey<FormState>(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _digitFields(),
          ),
        ),
        if (error != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 9),
            child: Text(
              error!,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .caption
                  ?.copyWith(color: Theme.of(context).errorColor),
            ),
          ),
      ],
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
            child: TextFormField(
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
              validator: (value) {
                if (i == 0) {
                  setState(() {
                    error = null;
                  });
                }
                if (value == null || value == "") {
                  setState(() {
                    error = "Please enter a valid OTP";
                  });
                }
                return null;
              },
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

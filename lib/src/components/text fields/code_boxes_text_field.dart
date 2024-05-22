import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CodeBoxesTextField extends StatefulWidget {
  final void Function(String, int) onChanged;
  final int boxesAmount;

  const CodeBoxesTextField({Key? key, required this.onChanged, required this.boxesAmount}) : super(key: key);

  @override
  createState() => _CodeBoxesTextFieldState();
}

class _CodeBoxesTextFieldState extends State<CodeBoxesTextField> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      widget.boxesAmount,
      (_) => TextEditingController(),
    );
    _focusNodes = List.generate(
      widget.boxesAmount,
      (_) => FocusNode(),
    );
  }

  @override
  void dispose() {
    for (int boxIndex = 0; boxIndex < widget.boxesAmount; boxIndex++) {
      _controllers[boxIndex].dispose();
      _focusNodes[boxIndex].dispose();
    }
    super.dispose();
  }

  void _handleKeyPress(RawKeyEvent event, int index) {
    if (event is RawKeyDownEvent && event.logicalKey == LogicalKeyboardKey.backspace) {
      if (_controllers[index].text.isEmpty && index > 0) {
        _focusNodes[index - 1].requestFocus();
        _controllers[index - 1].clear();
        widget.onChanged('', index - 1);
      }
      else if(_controllers[index].text.isNotEmpty){
        widget.onChanged('', index);
      }
    }
  }

  void _handleValueBoxValueChange(String value, int index){
    if (value.isNotEmpty && value.length == 1) {
      widget.onChanged(value.toUpperCase(), index);
      if (index < widget.boxesAmount - 1) {
        _focusNodes[index + 1].requestFocus();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.boxesAmount,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: SizedBox(
            width: 40,
            child: RawKeyboardListener(
              focusNode: FocusNode(),
              onKey: (event) => _handleKeyPress(event, index),
              child: TextField(
                controller: _controllers[index],
                focusNode: _focusNodes[index],
                onChanged: (value) => _handleValueBoxValueChange(value, index),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
                maxLength: 1,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                autocorrect: false,
                style: const TextStyle(fontSize: 20),
                decoration: const InputDecoration(
                  counter: Offstage(),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'field.dart';
import 'field_wrapper.dart';

class StringField extends Field<String> {
  const StringField({
    super.key,
    required super.title,
    required super.value,
    required super.setValue,
  });

  @override
  StringFieldState createState() => StringFieldState();
}

class StringFieldState extends State<StringField> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    _controller.text = widget.value;
    _controller.addListener(() => widget.setValue(_controller.text));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FieldWrapper(
      title: widget.title,
      child: TextField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
        controller: _controller,
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'field.dart';
import 'field_wrapper.dart';

class StringField extends Field<String> {
  const StringField({
    super.key,
    super.enabled,
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
    _controller.addListener(() {
      if (widget.enabled) {
        widget.setValue(_controller.text);
      }
    });
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
        enabled: widget.enabled,
        readOnly: !widget.enabled,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          fillColor: Colors.grey,
          filled: !widget.enabled,
          disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          enabled: widget.enabled,
        ),
        controller: _controller,
      ),
    );
  }
}

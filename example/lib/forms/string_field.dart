import 'package:fast_noise_flutter_example/forms/field.dart';
import 'package:fast_noise_flutter_example/forms/field_wrapper.dart';
import 'package:flutter/material.dart';

class StringField extends Field<String> {
  const StringField({
    required super.title,
    required super.value,
    required super.setValue,
    super.key,
    super.enabled,
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

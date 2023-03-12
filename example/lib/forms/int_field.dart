import 'package:flutter/material.dart';

import 'field.dart';
import 'string_field.dart';

class IntField extends Field<int> {
  const IntField({
    super.key,
    required super.title,
    required super.value,
    required super.setValue,
  });

  @override
  IntFieldState createState() => IntFieldState();
}

class IntFieldState extends State<IntField> {
  @override
  Widget build(BuildContext context) {
    return StringField(
      title: widget.title,
      value: widget.value.toString(),
      setValue: (v) => widget.setValue(int.parse(v)),
    );
  }
}

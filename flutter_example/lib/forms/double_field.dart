import 'package:flutter/material.dart';

import 'field.dart';
import 'string_field.dart';

class DoubleField extends Field<double> {
  const DoubleField({
    super.key,
    required super.title,
    required super.value,
    required super.setValue,
  });

  @override
  DoubleFieldState createState() => DoubleFieldState();
}

class DoubleFieldState extends State<DoubleField> {
  @override
  Widget build(BuildContext context) {
    return StringField(
      title: widget.title,
      value: widget.value.toString(),
      setValue: (v) => widget.setValue(double.parse(v)),
    );
  }
}

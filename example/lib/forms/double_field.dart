import 'package:fast_noise_flutter_example/forms/field.dart';
import 'package:fast_noise_flutter_example/forms/string_field.dart';
import 'package:flutter/material.dart';

class DoubleField extends Field<double> {
  const DoubleField({
    super.key,
    super.enabled,
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
      enabled: widget.enabled,
      value: widget.value.toString(),
      setValue: (v) => widget.setValue(double.parse(v)),
    );
  }
}

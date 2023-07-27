import 'package:fast_noise_flutter_example/forms/field.dart';
import 'package:fast_noise_flutter_example/forms/string_field.dart';
import 'package:flutter/material.dart';

class IntField extends Field<int> {
  const IntField({
    required super.title,
    required super.value,
    required super.setValue,
    super.key,
    super.enabled,
  });

  @override
  IntFieldState createState() => IntFieldState();
}

class IntFieldState extends State<IntField> {
  @override
  Widget build(BuildContext context) {
    return StringField(
      title: widget.title,
      enabled: widget.enabled,
      value: widget.value.toString(),
      setValue: (v) => widget.setValue(int.parse(v)),
    );
  }
}

import 'package:fast_noise_flutter_example/forms/field.dart';
import 'package:fast_noise_flutter_example/forms/field_wrapper.dart';
import 'package:flutter/material.dart';

class EnumField<T extends Enum> extends Field<T> {
  final List<T> values;

  const EnumField({
    required super.title,
    required super.value,
    required super.setValue,
    required this.values,
    super.key,
    super.enabled,
  });

  @override
  EnumFieldState<T> createState() => EnumFieldState<T>();
}

class EnumFieldState<T extends Enum> extends State<EnumField<T>> {
  @override
  Widget build(BuildContext context) {
    return FieldWrapper(
      title: widget.title,
      child: DropdownButton<T>(
        isExpanded: true,
        value: widget.value,
        items: widget.values
            .map(
              (e) => DropdownMenuItem(
                value: e,
                child: Text(e.toString()),
              ),
            )
            .toList(),
        onChanged: widget.enabled ? (v) => widget.setValue(v!) : null,
      ),
    );
  }
}

import 'package:flutter/material.dart';

abstract class Field<T> extends StatefulWidget {
  final String title;
  final T value;
  final void Function(T) setValue;
  final bool enabled;

  const Field({
    required this.title,
    required this.value,
    required this.setValue,
    super.key,
    this.enabled = true,
  });
}

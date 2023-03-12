import 'package:flutter/material.dart';

abstract class Field<T> extends StatefulWidget {
  final String title;
  final T value;
  final void Function(T) setValue;

  const Field({
    super.key,
    required this.title,
    required this.value,
    required this.setValue,
  });
}

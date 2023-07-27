import 'package:flutter/material.dart';

class FieldWrapper extends StatelessWidget {
  final String title;
  final Widget child;

  const FieldWrapper({
    required this.child,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title),
        const SizedBox(width: 8),
        Expanded(
          child: child,
        ),
      ],
    );
  }
}

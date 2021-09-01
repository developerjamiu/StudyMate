import 'package:flutter/material.dart';
import 'package:study_mate/shared/enums/priority.dart';

import '../enums/department.dart';
import '../enums/level.dart';

class CustomDropdown<T> extends StatelessWidget {
  const CustomDropdown({
    Key? key,
    this.value,
    required this.items,
    required this.hintText,
    this.onChanged,
    this.validator,
    this.labelText,
  }) : super(key: key);

  final List<T> items;
  final T? value;
  final String? labelText;
  final void Function(T?)? onChanged;
  final String hintText;
  final String? Function(T?)? validator;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DropdownButtonFormField(
      onChanged: onChanged,
      value: value,
      validator: validator,
      items: items.map((item) {
        if (item is Level) {
          return DropdownMenuItem<T>(
            value: item,
            child: Text(item.name),
          );
        }
        if (item is Department) {
          return DropdownMenuItem<T>(
            value: item,
            child: Text(item.name),
          );
        }
        if (item is Priority) {
          return DropdownMenuItem<T>(
            value: item,
            child: Text(item.name),
          );
        }
        return DropdownMenuItem<T>(
          value: item,
          child: Text(item.toString()),
        );
      }).toList(),
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 3, color: Color(0xFFF7F7F7)),
          borderRadius: BorderRadius.circular(6),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Color(0xFFE0E0E0)),
          borderRadius: BorderRadius.circular(6),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: theme.primaryColor),
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}

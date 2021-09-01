import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? labelText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool? enabled;
  final TextInputType? keyboardType;
  final TextStyle? labelStyle;
  final TextInputAction textInputAction;
  final int? maxLines;

  const CustomTextField({
    Key? key,
    this.labelText,
    this.controller,
    this.validator,
    this.suffixIcon,
    this.enabled,
    this.keyboardType,
    this.labelStyle,
    this.obscureText = false,
    this.maxLines = 1,
    this.textInputAction = TextInputAction.next,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      enabled: enabled,
      controller: controller,
      validator: validator,
      textInputAction: textInputAction,
      obscureText: obscureText,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        errorStyle: TextStyle(color: theme.errorColor),
        alignLabelWithHint: true,
        labelStyle: labelStyle,
        suffixIcon: suffixIcon,
        contentPadding: EdgeInsets.all(16),
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
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: theme.errorColor),
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}

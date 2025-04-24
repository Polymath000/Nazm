import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String? hintText;
  final void Function(String)? onChanged;
  final bool enabled;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final String? initialValue;
  final String? emptyValidatorMessage;
  final String? emailValidatorMessage;
  String? Function(String?)? customValidator = (p0) {
    return;
  };
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry contentPadding;
  final Color textColor;
  final Color enabledBorderColor;
  final Color focusedBorderColor;
  final Color errorBorderColor;
  final Color disabledBorderColor;
  final Color fillColor;
  final bool filled;
  final Color cursorColor;
  final Color labelColor;
  final Color hintColor;
  final String? semanticLabel;
  final bool validatorRequired;
  CustomTextField({
    super.key,
    required this.validatorRequired,
    this.label = "",
    this.hintText,
    this.onChanged,
    this.enabled = true,
    this.obscureText = false,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.initialValue,
    this.emptyValidatorMessage,
    this.emailValidatorMessage,
    this.customValidator,
    this.padding = const EdgeInsets.only(bottom: 20),
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    this.textColor = Colors.black,
    this.enabledBorderColor = const Color.fromARGB(255, 0, 0, 0),
    this.focusedBorderColor = const Color.fromARGB(255, 1, 5, 253),
    this.errorBorderColor = Colors.red,
    this.disabledBorderColor = const Color.fromARGB(255, 160, 160, 160),
    this.fillColor = const Color.fromARGB(255, 250, 250, 250),
    this.filled = true,
    this.cursorColor = const Color.fromARGB(255, 1, 161, 253),
    this.labelColor = const Color.fromARGB(255, 0, 0, 0),
    this.hintColor = const Color.fromARGB(255, 0, 0, 0),
    this.semanticLabel,
  });

  final emailRegex = RegExp(
    r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}$',
  );

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel ?? label,
      child: Padding(
        padding: padding,
        child: TextFormField(
          initialValue: initialValue,
          style: TextStyle(color: textColor, fontSize: 16),
          cursorColor: cursorColor,
          obscureText: obscureText,
          keyboardType: _getKeyboardType(),
          textCapitalization: textCapitalization,
          maxLines: maxLines,
          minLines: minLines,
          maxLength: maxLength,
          validator: validatorRequired ? _defaultValidator : customValidator,
          onChanged: onChanged,
          enabled: enabled,
          decoration: InputDecoration(
            labelText: label,
            hintText: hintText,
            filled: filled,
            fillColor: fillColor.withOpacity(0.5),
            contentPadding: contentPadding,
            labelStyle: TextStyle(color: labelColor, fontSize: 16),
            hintStyle: TextStyle(color: hintColor, fontSize: 16),
            floatingLabelStyle: TextStyle(color: focusedBorderColor),
            disabledBorder: _buildBorder(disabledBorderColor),
            enabledBorder: _buildBorder(enabledBorderColor),
            focusedBorder: _buildBorder(focusedBorderColor),
            errorBorder: _buildBorder(errorBorderColor),
            focusedErrorBorder: _buildBorder(errorBorderColor),
            errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
          ),
        ),
      ),
    );
  }

  InputBorder _buildBorder(Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color, width: 1.5),
      borderRadius: BorderRadius.circular(10),
      gapPadding: 0,
    );
  }

  String? _defaultValidator(String? value) {
    if (value == null || value.isEmpty) {
      return emptyValidatorMessage ?? '$label cannot be empty';
    }

    if (keyboardType == TextInputType.emailAddress &&
        !emailRegex.hasMatch(value)) {
      return emailValidatorMessage ?? 'Please enter a valid email address';
    }

    return null;
  }

  TextInputType? _getKeyboardType() {
    if (keyboardType != null) return keyboardType;
    if (label.toLowerCase().contains('email'))
      return TextInputType.emailAddress;
    if (label.toLowerCase().contains('phone')) return TextInputType.phone;
    return TextInputType.text;
  }
}

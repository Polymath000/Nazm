import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PasswordTextField extends StatefulWidget {
  final String label;
  final String? hintText;
  final void Function(String)? onChanged;
  final String? emptyValidatorMessage;
  final String? weakPasswordMessage;
  final bool validateStrength;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry contentPadding;
  final Color textColor;
  final Color enabledBorderColor;
  final Color focusedBorderColor;
  final Color errorBorderColor;
  final Color iconColor;
  final Color fillColor;
  final bool filled;
  final Color cursorColor;
  final Color labelColor;
  final Color hintColor;
  final String? semanticLabel;
  final int? minPasswordLength;

  const PasswordTextField({
    super.key,
    required this.label,
    this.hintText,
    this.onChanged,
    this.emptyValidatorMessage,
    this.weakPasswordMessage,
    this.validateStrength = false,
    this.padding = const EdgeInsets.only(bottom: 20),
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    this.textColor = Colors.black,
    this.enabledBorderColor = const Color.fromARGB(255, 0, 0, 0),
    this.focusedBorderColor = const Color.fromARGB(255, 2, 61, 119),
    this.errorBorderColor = Colors.red,
    this.iconColor = Colors.black,
    this.fillColor = const Color.fromARGB(255, 250, 250, 250),
    this.filled = true,
    this.cursorColor = const Color.fromARGB(255, 2, 61, 119),
    this.labelColor = Colors.black,
    this.hintColor = const Color.fromARGB(255, 0, 0, 0),
    this.semanticLabel,
    this.minPasswordLength = 6,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _isPasswordVisible = false;
  bool _isPasswordStrong = false;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: widget.semanticLabel ?? widget.label,
      child: Padding(
        padding: widget.padding,
        child: TextFormField(
          style: TextStyle(color: widget.textColor, fontSize: 16),
          cursorColor: widget.cursorColor,
          obscureText: !_isPasswordVisible,
          validator: _validatePassword,
          onChanged: (value) {
            if (widget.validateStrength) {
              setState(() {
                _isPasswordStrong = _checkPasswordStrength(value);
              });
            }
            widget.onChanged?.call(value);
          },
          decoration: InputDecoration(
            labelText: widget.label,
            hintText: widget.hintText ?? '••••••••',
            filled: widget.filled,
            fillColor: widget.fillColor.withOpacity(0.5),
            contentPadding: widget.contentPadding,
            labelStyle: TextStyle(color: widget.labelColor, fontSize: 16),
            hintStyle: TextStyle(color: widget.hintColor, fontSize: 16),
            floatingLabelStyle: TextStyle(color: widget.focusedBorderColor),
            suffixIcon: _buildPasswordVisibilityToggle(),
            enabledBorder: _buildBorder(widget.enabledBorderColor),
            focusedBorder: _buildBorder(widget.focusedBorderColor),
            errorBorder: _buildBorder(widget.errorBorderColor),
            focusedErrorBorder: _buildBorder(widget.errorBorderColor),
            errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordVisibilityToggle() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.validateStrength && _isPasswordVisible)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Icon(
              _isPasswordStrong ? Icons.check_circle : Icons.warning,
              color: _isPasswordStrong ? Colors.green : Colors.orange,
              size: 20,
            ),
          ),
        IconButton(
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
          icon: Icon(
            _isPasswordVisible
                ? FontAwesomeIcons.eye
                : FontAwesomeIcons.eyeSlash,
            color: widget.iconColor,
            size: 20,
          ),
        ),
      ],
    );
  }

  InputBorder _buildBorder(Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color, width: 1.5),
      borderRadius: BorderRadius.circular(10),
      gapPadding: 0,
    );
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return widget.emptyValidatorMessage ?? 'Please enter your password';
    }

    if (widget.validateStrength && !_checkPasswordStrength(value)) {
      return widget.weakPasswordMessage ??
          'Password must be at least ${widget.minPasswordLength} characters';
    }

    return null;
  }

  bool _checkPasswordStrength(String password) {
    return password.length >= (widget.minPasswordLength ?? 6);
  }
}

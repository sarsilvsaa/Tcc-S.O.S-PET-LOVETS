import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MaskedTextInputFormatter extends TextInputFormatter {
  final String mask;

  MaskedTextInputFormatter({required this.mask});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String maskedText = '';
    int maskIndex = 0;

    for (int i = 0; i < newValue.text.length; i++) {
      if (maskIndex >= mask.length) {
        break;
      }

      if (mask[maskIndex] == '#') {
        if (RegExp(r'\d').hasMatch(newValue.text[i])) {
          maskedText += newValue.text[i];
        }
      } else {
        maskedText += mask[maskIndex];
      }

      maskIndex++;
    }

    return TextEditingValue(
      text: maskedText,
      selection: TextSelection.collapsed(offset: maskedText.length),
    );
  }
}

class CustomInputField extends StatefulWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final TextInputType? keyboardType;
  final String? hintText;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;

  const CustomInputField({
    this.controller,
    this.initialValue,
    this.keyboardType,
    this.hintText,
    this.obscureText = false,
    this.inputFormatters,
    this.validator,
  });

  @override
  _CustomInputFieldState createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool _obscure = false;

  @override
  void initState() {
    super.initState();
    if (widget.obscureText) {
      _obscure = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFf1f0f5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextFormField(
        controller: widget.controller,
        initialValue: widget.initialValue,
        keyboardType: widget.keyboardType,
        obscureText: _obscure,
        obscuringCharacter: '*',
        validator: widget.validator,
        inputFormatters: widget.inputFormatters,
        decoration: new InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          hintText: widget.hintText,
          suffixIcon: widget.obscureText
              ? Padding(
                  padding: EdgeInsets.all(4),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(64),
                      child: Icon(
                        _obscure ? Icons.visibility : Icons.visibility_off,
                      ),
                      onTap: () {
                        setState(() {
                          _obscure = !_obscure;
                        });
                      },
                    ),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final void Function(bool? value) onChanged;
  final String? labelText;
  final Widget? label;
  const CustomCheckbox({
    this.value = false,
    required this.onChanged,
    this.labelText,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
        ),
        if (labelText != null)
          GestureDetector(
            child: Text(labelText!),
            onTap: () => onChanged(!value),
          )
        else if (label != null)
          GestureDetector(
            child: label,
            onTap: () => onChanged(!value),
          )
      ],
    );
  }
}

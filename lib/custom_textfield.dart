import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final String labelText;
  final String hint;
  final int? minimuLine;
  final int? maximumLine;
  final TextEditingController controller;
  final TextInputType inputType;
  final bool isobscureText;
  final String? obscureCharacter;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const CustomTextfield({super.key, required this.labelText, required this.hint, this.minimuLine, this.maximumLine, this.inputType=TextInputType.text, this.isobscureText = false, this.obscureCharacter = "*",this.prefixIcon, this.suffixIcon, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      minLines: minimuLine,
      maxLines: maximumLine,
      keyboardType: inputType,
      obscureText: isobscureText,
      obscuringCharacter: obscureCharacter!,
      decoration: InputDecoration(
        label: Text(labelText),
        hintText: hint,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(width: 1, color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            width: 2,
            color: Color(0xff0DCBA8),
          ),
        ),
      ),
    );
  }
}

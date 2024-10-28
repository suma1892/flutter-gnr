import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final String errorMessage;
  final bool obscureText;
  final TextInputType keyboardType;
  final IconData? icon;

  const TextInput({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.errorMessage = '',
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Email cannot be empty';
            }
            // Regex untuk validasi format email
            String pattern =
                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
            RegExp regExp = RegExp(pattern);
            if (!regExp.hasMatch(value)) {
              return 'Enter a valid email';
            }
            return null; // Kembali null jika tidak ada kesalahan
          },
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
            prefixIcon: icon != null ? Icon(icon) : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.blue),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          ),
        ),
      ],
    );
  }
}

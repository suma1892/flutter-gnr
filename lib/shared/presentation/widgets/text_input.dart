import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final String errorMessage;
  final bool obscureText;
  final TextInputType keyboardType;
  final IconData? icon;
  final String? Function(String?)? validator; // Parameter validator tambahan

  const TextInput({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.errorMessage = '',
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.icon,
    this.validator, // Assign validator sebagai parameter opsional
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          validator: validator ?? (value) { // Menggunakan validator custom atau default
            if (value == null || value.isEmpty) {
              return errorMessage.isNotEmpty ? errorMessage : 'This field cannot be empty';
            }
            return null; // Kembali null jika tidak ada kesalahan
          },
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
            prefixIcon: icon != null ? Icon(icon) : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.blue),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          ),
        ),
      ],
    );
  }
}

import 'package:bloc_online_shop/Config/Theme/Colors/g_color.dart';
import 'package:flutter/material.dart';

class TextField1 extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final String? errorMsg;
  final String? Function(String?)? onChanged;

  const TextField1(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText,
      required this.keyboardType,
      this.suffixIcon,
      this.onTap,
      this.prefixIcon,
      this.validator,
      this.errorMsg,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: GColor.black),
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onTap: onTap,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.tealAccent),
        ),
        fillColor: Theme.of(context).brightness == Brightness.light
            ? const Color.fromARGB(255, 225, 241, 255)
            : Colors.grey.shade200,
        filled: true,
        hintStyle: TextStyle(color: Colors.grey[500]),
        errorText: errorMsg,
      ),
      onChanged: onChanged,
    );
  }
}

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final bool obscureText;
  final TextInputType keyboardType;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.icon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {

    return TextFormField(

      controller: controller,

      obscureText: obscureText,

      keyboardType: keyboardType,

      validator: (value) {

        if (value == null || value.trim().isEmpty) {

          return "Champ obligatoire";

        }

        if (keyboardType == TextInputType.emailAddress) {

          if (!RegExp(
                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
              .hasMatch(value)) {

            return "Email invalide";

          }

        }

        if (obscureText) {

          if (value.length < 6) {

            return "Minimum 6 caractères";

          }

        }

        return null;

      },

      decoration: InputDecoration(

        hintText: hint,

        prefixIcon: Icon(icon),

        filled: true,

        fillColor: Colors.white,

        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Color(0xff1565C0),
            width: 2,
          ),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),

      ),

    );

  }

}
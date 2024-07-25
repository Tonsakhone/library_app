import 'package:flutter/material.dart';

class PasswordInput extends StatelessWidget {
  final String hander;
  final TextEditingController controller;
  final bool closePassword;
  const PasswordInput({super.key, required this.hander, required this.controller, required this.closePassword});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.white),
      child: TextFormField(
        obscureText: closePassword,
        controller: controller,
        decoration: InputDecoration(
          fillColor: Colors.black,
          hoverColor: Colors.black,
          focusColor: Colors.black,
          label: Text(
            hander,
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.white, width: 2),
          ),
        ),
      ),
    );
  }
}

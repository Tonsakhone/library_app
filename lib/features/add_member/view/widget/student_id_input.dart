import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StudentIdInput extends StatelessWidget {
  final String hander;
  final TextEditingController controller;
  const StudentIdInput({super.key, required this.hander, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.white),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(8),
        ],
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

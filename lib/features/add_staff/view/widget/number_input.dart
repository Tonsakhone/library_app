import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberInput extends StatelessWidget {
  final String label;
  final bool readOnly;
  final TextEditingController controller;
  const NumberInput({super.key, required this.label, required this.readOnly, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.white),
      child: TextFormField(
        keyboardType: TextInputType.number,
        readOnly: readOnly,
        controller: controller,
        inputFormatters: [
          LengthLimitingTextInputFormatter(8),
        ],
        decoration: InputDecoration(
          fillColor: Colors.black,
          hoverColor: Colors.black,
          focusColor: Colors.black,
          label: Text(
            label,
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

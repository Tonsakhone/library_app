import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReadInputBox extends StatelessWidget {
  final String hander;
  const ReadInputBox({super.key, required this.hander});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.white),
      child: TextFormField(
        readOnly: true,
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

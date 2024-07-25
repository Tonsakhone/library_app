import 'package:flutter/material.dart';

class RentInfoLine extends StatelessWidget {
  final String hander;
  final String detail;
  const RentInfoLine({super.key, required this.hander, required this.detail});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Text(
            hander,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          trailing: Text(
            detail,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Divider(height: 10, color: Colors.grey[300]),
        )
      ],
    );
  }
}

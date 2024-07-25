import 'package:flutter/material.dart';

class MenuBox extends StatelessWidget {
  final String title;
  final String image;
  final Function() onPressed;
  final Color textColor;
  final Color backgroundColors;
  const MenuBox(
      {super.key, required this.title, required this.image, required this.onPressed, required this.textColor, required this.backgroundColors});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size.width,
        height: size.height * 0.2,
        decoration: BoxDecoration(color: backgroundColors, borderRadius: const BorderRadius.all(Radius.circular(15))),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  width: size.width,
                  decoration: BoxDecoration(image: DecorationImage(image: AssetImage(image))),
                ),
              ),
              const SizedBox(height: 18),
              Expanded(
                  child: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

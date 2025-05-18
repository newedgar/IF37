import 'package:flutter/material.dart';
import 'package:if37/script/custom_keyboard.dart';

class BlissKey extends StatelessWidget {
  final Widget icon;
  final VoidCallback? onPressed;
  final String translation;
  final Color? buttonColor;

  const BlissKey({
    super.key,
    required this.icon,
    required this.translation,
    this.buttonColor,
    this.onPressed,
  });


  getIcon() => icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed ?? () {
        CustomKeyboard().addKeyPresed(this);
        //TODO make update home page to show keys 
      },
      child: Container(
        width: 50,
        height: 50,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: buttonColor ?? Colors.grey[300],
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(25),
              offset: const Offset(2, 2),
              blurRadius: 4,
            ),
          ],
        ),
        child: Center(
          child: icon
        ),
      ),
    );
  }
}
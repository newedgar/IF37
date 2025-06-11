import 'package:flutter/material.dart';
import 'package:speaky/script/custom_keyboard.dart';


class BlissSymbole extends StatelessWidget {
  final Widget icon;
  final VoidCallback? onPressed;
  final String translation;
  final Color? buttonColor;

  const BlissSymbole({
    super.key,
    required this.icon,
    required this.translation,
    this.buttonColor,
    this.onPressed,
  });


  Widget getIcon() => icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed ?? () {
        CustomKeyboard().addKeyPresed(this);
      },
      child: Tooltip(
        message: translation,
        child: Container(
          width: 50,
          height: 50,
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
      ),
    );
  }
}
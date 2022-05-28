import 'package:flutter/material.dart';

class PublicButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final Color color;
  final Color textColor;
  final double buttonHeight;
  final double buttonWidth;
  final TextStyle? textStyle;

  const PublicButton({required this.onTap, required this.title, required this.color, required this.textColor, required this.buttonHeight, required this.buttonWidth, this.textStyle});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialButton(
      onPressed: onTap,
      textColor: textColor,
      color: color,
      child: SizedBox(
        // width: double.infinity,
        child: FittedBox(
          fit: BoxFit.contain,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: textStyle,
          ),
        ),
      ),
      height: size.height * buttonHeight,
      minWidth: size.width * buttonWidth,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
    );
  }
}

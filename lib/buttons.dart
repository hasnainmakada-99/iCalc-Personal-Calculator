import 'package:flutter/cupertino.dart';

class customButton extends StatelessWidget {
  final color;
  final textColor;
  final String buttonText;
  final buttonTaped;
  const customButton({
    Key? key,
    required this.color,
    required this.textColor,
    required this.buttonText,
    required this.buttonTaped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTaped,
      child: Padding(
        padding: const EdgeInsets.all(0.2),
        child: ClipRect(
          child: Container(
            color: color,
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                  color: textColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

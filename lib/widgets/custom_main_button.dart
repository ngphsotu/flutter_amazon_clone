import '/utils/utils.dart';
import 'package:flutter/material.dart';

class CustomMainButton extends StatelessWidget {
  //
  final Color color;
  final Widget child;
  final bool isLoading;
  final VoidCallback onPressed;

  const CustomMainButton({
    Key? key,
    required this.color,
    required this.child,
    required this.isLoading,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    Size screenSize = Utils().getScreenSize();

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: color,
        fixedSize: Size(
          screenSize.width * 0.5,
          40,
        ),
      ),
      child: !isLoading
          ? child
          : const Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
    );
  }
}

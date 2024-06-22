import 'package:flutter/material.dart';

class ArrowButton extends StatelessWidget {
  final ArrowDirection direction;
  final VoidCallback onPressed;
  final Color containerColor;
  final double iconSize;

  const ArrowButton({
    Key? key,
    required this.direction,
    required this.containerColor,
    required this.onPressed,
    required this.iconSize
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: containerColor,
      ),
      child: IconButton(
        iconSize: iconSize,
        alignment: Alignment.center,
        icon: Transform.rotate(
          angle: direction.angle,
          child: Image.asset('assets/icons/arrow_white.png'),
        ),
        onPressed: onPressed,
      ),
    );
  }
}

enum ArrowDirection {
  right,
  up,
  left,
  down,
}

extension ArrowDirectionExtension on ArrowDirection {
  double get angle {
    switch (this) {
      case ArrowDirection.right:
        return 0;
      case ArrowDirection.up:
        return 270 * 3.1415926535 / 180;
      case ArrowDirection.left:
        return 180 * 3.1415926535 / 180;
      case ArrowDirection.down:
        return 90 * 3.1415926535 / 180;
      default:
        return 0;
    }
  }
}

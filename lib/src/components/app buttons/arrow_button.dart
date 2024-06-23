import 'package:findmyrestaurant/src/enums/images%20enums/images_names.dart';
import 'package:findmyrestaurant/src/enums/images%20enums/images_paths_sections_enum.dart';
import 'package:findmyrestaurant/src/services/images_reader_service.dart';
import 'package:findmyrestaurant/styles/app_colors.dart';
import 'package:flutter/material.dart';

class ArrowButton extends StatelessWidget {
  final ArrowDirection direction;
  final VoidCallback onPressed;
  final Color containerColor;
  final double iconSize;
  final bool active;

  final String _iconPath = ImagesReaderService.instance.getImagePath(ImagesPathsSections.icons, ImagesNames.arrowWhite);

  ArrowButton({
    Key? key,
    required this.direction,
    required this.containerColor,
    required this.onPressed,
    required this.iconSize,
    required this.active
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: active ? containerColor : AppColors.disabledBtnColor,
      ),
      child: IconButton(
        iconSize: iconSize,
        alignment: Alignment.center,
        icon: Transform.rotate(
          angle: direction.angle,
          child: Image.asset(_iconPath),
        ),
        onPressed: active ? onPressed : null,
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

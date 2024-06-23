import 'package:findmyrestaurant/src/enums/images%20enums/images_names.dart';
import 'package:findmyrestaurant/src/enums/images%20enums/images_paths_sections_enum.dart';
import 'package:findmyrestaurant/src/services/images_reader_service.dart';
import 'package:findmyrestaurant/styles/app_colors.dart';
import 'package:flutter/material.dart';

class ImageCheckboxCard extends StatefulWidget {
  final String label;
  final String imagePath;
  final bool isSelected;
  final ValueChanged<bool> onSelected;

  const ImageCheckboxCard({
    Key? key,
    required this.label,
    required this.imagePath,
    required this.isSelected,
    required this.onSelected,
  }) : super(key: key);

  @override
  State<ImageCheckboxCard> createState() => _ImageCheckboxCardState();
}

class _ImageCheckboxCardState extends State<ImageCheckboxCard> {
  late bool _isSelected;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.isSelected;
  }

  @override
  void didUpdateWidget(covariant ImageCheckboxCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isSelected != widget.isSelected) {
      _isSelected = widget.isSelected;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
          widget.onSelected(_isSelected);
        });
      },
      child: Card(
        shadowColor: AppColors.darkGray,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: _isSelected ? AppColors.primaryColor : AppColors.transparent,
            width: 3,
          ),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    widget.imagePath,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        ImagesReaderService.instance.getImagePath(ImagesPathsSections.extra, ImagesNames.noImagePlaceholder),
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.fill,
                      );
                    },
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.scaleDown,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.label),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Icon(
                size: 40,
                _isSelected ? Icons.check_circle_outline : Icons.circle_outlined,
                color: _isSelected ? AppColors.primaryColor : AppColors.appWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

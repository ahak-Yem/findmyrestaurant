import 'package:findmyrestaurant/styles/app_colors.dart';
import 'package:flutter/material.dart';

class ImageRadioButtonCard extends StatefulWidget {
  final String label;
  final String imagePath;
  final bool isSelected;
  final ValueChanged<bool> onSelected;

  const ImageRadioButtonCard({
    Key? key,
    required this.label,
    required this.imagePath,
    required this.isSelected,
    required this.onSelected,
  }) : super(key: key);

  @override
  State<ImageRadioButtonCard> createState() => _ImageRadioButtonCardState();
}

class _ImageRadioButtonCardState extends State<ImageRadioButtonCard> {
  late bool _isSelected;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.isSelected;
  }

  @override
  void didUpdateWidget(covariant ImageRadioButtonCard oldWidget) {
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: _isSelected ? AppColors.primaryColor : AppColors.transparent,
            width: 2,
          ),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  widget.imagePath,
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.label),
                ),
              ],
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Icon(
                _isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                color: _isSelected ? AppColors.appWhite : AppColors.gray,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

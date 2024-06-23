import 'package:flutter/material.dart';
import 'package:findmyrestaurant/src/enums/images%20enums/images_names.dart';
import 'package:findmyrestaurant/src/enums/images%20enums/images_paths_sections_enum.dart';
import 'package:findmyrestaurant/src/services/images_reader_service.dart';

class LoadingPlaceholder extends StatelessWidget {
  final Future<String> _imagePlaceholderFuture;

  LoadingPlaceholder({Key? key})
    : _imagePlaceholderFuture = ImagesReaderService.instance.getImagePathAsync(
      ImagesPathsSections.extra,
      ImagesNames.loadingPlaceholder,
    ), super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _imagePlaceholderFuture,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        else {
          if(!snapshot.hasData || snapshot.data == null) {
            return Container();
          }
          return Image.asset(
            snapshot.data!,
            fit: BoxFit.contain,
          );
        }
      },
    );
  }
}

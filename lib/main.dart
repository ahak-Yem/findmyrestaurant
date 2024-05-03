import 'package:findmyrestaurant/src/utility/images_paths_reader.dart';
import 'package:flutter/material.dart';
import 'src/app.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ImagesPathsReader.instance.initialize();
  runApp(const MyApp());
}

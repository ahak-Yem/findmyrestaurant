import 'package:findmyrestaurant/src/services/images_reader_service.dart';
import 'package:flutter/material.dart';
import 'src/app.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ImagesReaderService.instance.initialize();
  runApp(const MyApp());
}

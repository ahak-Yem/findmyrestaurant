import 'package:findmyrestaurant/src/services/database/database_service.dart';
import 'package:findmyrestaurant/src/services/dotenv_service.dart';
import 'package:findmyrestaurant/src/services/images_reader_service.dart';
import 'package:flutter/material.dart';
import 'src/app.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DotenvService.instance.initialize();
  await DatabaseService.instance.initialize();
  await ImagesReaderService.instance.initialize();
  runApp(const MyApp());
}

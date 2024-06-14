import 'package:findmyrestaurant/src/services/app_launch_service.dart';
import 'package:findmyrestaurant/src/services/database_service.dart';
import 'package:findmyrestaurant/src/services/dotenv_service.dart';
import 'package:findmyrestaurant/src/services/email_service.dart';
import 'package:findmyrestaurant/src/services/images_reader_service.dart';
import 'package:findmyrestaurant/src/services/survey_service.dart';
import 'package:flutter/material.dart';
import 'src/app.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ImagesReaderService.instance.initialize();
  await DotenvService.instance.initialize(); // Should be before EmailService
  await DatabaseService.instance.initialize();
  await EmailService.instance.initialize();
  await AppLaunchService.instance.initialize(); // Should be after DatabaseService
  await SurveyService.instance.initialize();
  runApp(const MyApp());
}

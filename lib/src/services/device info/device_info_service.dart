import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfoService{
  static final DeviceInfoService  _instance = DeviceInfoService._internal();

  static DeviceInfoService get instance => _instance;

  factory DeviceInfoService() => _instance;
  
  DeviceInfoService._internal();

  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  Future<String> get deviceID async{
    if(Platform.isAndroid) {
      return await _getAndroidDeviceId();
    }
    else if(Platform.isIOS) {
      return await _getIosDeviceId();
    }
    return "";
  }

  Future<String> _getAndroidDeviceId() async{
    AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
    var id = androidInfo.id;
    return id;
  }
   
  Future<String> _getIosDeviceId() async{
    IosDeviceInfo iosInfo = await  _deviceInfo.iosInfo;
    String id = iosInfo.identifierForVendor ?? "Unknown";
    return id;
  }
}
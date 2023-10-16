import 'package:bmp_flutter_sdk/bmp_flutter_sdk.dart';

class AkamaiBMPExt {
  static final AkamaiBMPExt instance = AkamaiBMPExt._internal();
  static const String kSD_default_mobile = 'default-mobile';
  static const int kSD_TimeOut = 30;
  static const int kSD_Sampling_Time = 500;

  factory AkamaiBMPExt() {
    return instance;
  }

  AkamaiBMPExt._internal();

  Future<String?> getSensorDataIn() async {
    final startTime = DateTime.now();
    String? sensorData = await AkamaiBMP.getSensorData();
    while (sensorData == kSD_default_mobile || sensorData == null) {
      await Future.delayed(Duration(milliseconds: kSD_Sampling_Time));
      sensorData = await AkamaiBMP.getSensorData();
      var fetchTime = DateTime.now();
      if (fetchTime.difference(startTime).inSeconds >=
          kSD_TimeOut) {
        return sensorData;
      }
    }
    return sensorData;
  }

}
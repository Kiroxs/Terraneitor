import 'package:flutter/material.dart';

class ConfigProvider extends ChangeNotifier {
  String ip = '244.178.44.111';

  void setIp(String newIp) {
    ip = newIp;
    print("IP: $ip");
    notifyListeners();
  }

  String getIp() {
    return ip;
  }
}

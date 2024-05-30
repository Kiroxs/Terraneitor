import 'package:flutter/material.dart';

class ConfigProvider extends ChangeNotifier {
  String ip = '';

  void setIp(String newIp) {
    ip = newIp;
    print("IP: $ip");
    notifyListeners();
  }

  String getIp() {
    return ip;
  }
}

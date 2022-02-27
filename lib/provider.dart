import 'package:flutter/material.dart';

class Token extends ChangeNotifier {
  String _token = "0";

  get token => _token;

  void setToken(token) {
    _token = token;
    notifyListeners();
  }
}

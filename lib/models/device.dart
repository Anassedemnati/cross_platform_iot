import 'package:flutter/material.dart';

class Device with ChangeNotifier{
  final int id;
  final String name;
  final String typeOfDevice;
  bool isOn;
  final String macAddress;
  final String ipAddress;

  Device({
    required this.id,
    required this.name,
    required this.typeOfDevice,
    required this.isOn,
    required this.macAddress,
    required this.ipAddress,
  });
}
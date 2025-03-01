import 'package:cross_platform_iot/models/device.dart';
import 'package:flutter/material.dart';

class DeviceProvider with ChangeNotifier {
  List<Device> _devices = [
    Device(
      id: 1,
      name: "Living Room Light",
      typeOfDevice: "Light",
      isOn: false,
      macAddress: "00:00:00:00:00:00",
      ipAddress: "109.10.12.1",
    ),
    Device(
      id: 2,
      name: "Garage Door",
      typeOfDevice: "Garage",
      isOn: false,
      macAddress: "00:00:00:00:00:01",
      ipAddress: "12.251.21.21",
    ),
    Device(
      id: 3,
      name: "Bedroom Light",
      typeOfDevice: "Light",
      isOn: true,
      macAddress: "00:00:00:00:00:02",
      ipAddress: "12.251.21.88",
    ),
    Device(
      id: 4,
      name: "Kitchen Light",
      typeOfDevice: "Light",
      isOn: true,
      macAddress: "00:00:00:00:00:03",
      ipAddress: "12.251.21.33",
    ),
  ];

  List<Device> get devices => _devices;

  void toggleDevice(int id) {
    final index = _devices.indexWhere((device) => device.id == id);
    if (index != -1) {
      _devices[index].isOn = !_devices[index].isOn;
      notifyListeners();
    }
  }
}
class Devices {
  final int id;
  final String name;
  final String typeOfDevice;
  final bool isOn;
  final String macAddress;
  final String ipAddress;

  Devices({
    required this.id,
    required this.name,
    required this.typeOfDevice,
    required this.isOn,
    required this.macAddress,
    required this.ipAddress,
  });
}
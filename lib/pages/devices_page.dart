import 'package:cross_platform_iot/models/Device.dart';
import 'package:flutter/material.dart';


final List<Device> devices = [
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

// Custom widget for displaying each device
class DeviceItem extends StatelessWidget {
  final Device device;

  const DeviceItem({super.key, required this.device});

  @override
  Widget build(BuildContext context) {
    return InkWell( 
      onTap: () {
        //  Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => DeviceDetailPage( device: device),
        //   ),
        // );
        Navigator.pushNamed(context, '/device-detail', arguments: device);
      }, 
      child: Card(
      child: ListTile(
        leading: Icon(
          device.typeOfDevice == 'Light'
              ? Icons.lightbulb
              : Icons.garage,
          color: device.isOn ? Colors.green : Colors.red,
        ),
        title: Text(device.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Type: ${device.typeOfDevice}'),
            Text('IP: ${device.ipAddress}'),
            Text('MAC: ${device.macAddress}'),
          ],
        ),
      ),
    ),
    );
    
  }
}

class DevicesPage extends StatelessWidget {
  const DevicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Devices',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: ListView.builder(
        itemCount: devices.length,
        itemBuilder: (context, index) {
          return DeviceItem(device: devices[index]);
        },
      ),
    );
  }
}

import 'package:cross_platform_iot/models/Device.dart';
import 'package:cross_platform_iot/providers/device_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



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
    final devices = Provider.of<DeviceProvider>(context).devices;

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

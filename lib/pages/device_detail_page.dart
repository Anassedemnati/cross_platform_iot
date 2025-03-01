import 'package:cross_platform_iot/models/device.dart';
import 'package:cross_platform_iot/providers/device_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeviceDetailPage extends StatelessWidget {
  final Device device;

  const DeviceDetailPage({super.key, required this.device});

  @override
  Widget build(BuildContext context) {
    //get the device from the provider
    final deviceFromProvider = Provider.of<DeviceProvider>(context)
        .devices
        .firstWhere((device) => device.id == device.id);
    return Scaffold(
      appBar: AppBar(
        title: Text('${deviceFromProvider.name} Details',
          style: const TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).colorScheme.primary,
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Device Name: ${deviceFromProvider.name}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Type: ${deviceFromProvider.typeOfDevice}'),
            const SizedBox(height: 8),
            Text('IP Address: ${deviceFromProvider.ipAddress}'),
            const SizedBox(height: 8),
            Text('MAC Address: ${deviceFromProvider.macAddress}'),
            const SizedBox(height: 8),
            Text('Status: ${deviceFromProvider.isOn ? "On" : "Off"}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // change the device status when the button is pressed
                Provider.of<DeviceProvider>(context, listen: false)
                  .toggleDevice(deviceFromProvider.id);
          
              },
              child: Text(deviceFromProvider.isOn ? 'Turn Off' : 'Turn On'),
            ),
          ],
        ),
      ),
    );
  }
}

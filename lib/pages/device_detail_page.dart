import 'package:cross_platform_iot/models/Device.dart';
import 'package:flutter/material.dart';

class DeviceDetailPage extends StatelessWidget {
  final Device device;

  const DeviceDetailPage({super.key, required this.device});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${device.name} Details',
          style: const TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).colorScheme.primary,
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Device Name: ${device.name}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Type: ${device.typeOfDevice}'),
            const SizedBox(height: 8),
            Text('IP Address: ${device.ipAddress}'),
            const SizedBox(height: 8),
            Text('MAC Address: ${device.macAddress}'),
            const SizedBox(height: 8),
            Text('Status: ${device.isOn ? "On" : "Off"}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // print('Turn ${device.isOn ? 'Off' : 'On'}');
 
               Navigator.pop(context);
            
              
              },
              child: Text(device.isOn ? 'Turn Off' : 'Turn On'),
            ),
          ],
        ),
      ),
    );
  }
}

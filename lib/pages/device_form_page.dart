import 'package:cross_platform_iot/models/device.dart';
import 'package:cross_platform_iot/providers/device_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeviceFormPage extends StatelessWidget {
  final Device? device;
  const DeviceFormPage({super.key, this.device});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController(text: device?.name ?? '');
    final typeController =
        TextEditingController(text: device?.typeOfDevice ?? '');
    final ipController = TextEditingController(text: device?.ipAddress ?? '');
    final macController = TextEditingController(text: device?.macAddress ?? '');

    return Scaffold(
      appBar: AppBar(
        title: Text(device == null ? 'Add Device' : 'Edit Device'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Device Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a device name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: typeController,
                decoration: const InputDecoration(labelText: 'Device Type'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a device type';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: ipController,
                decoration: const InputDecoration(labelText: 'IP Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an IP address';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: macController,
                decoration: const InputDecoration(labelText: 'MAC Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a MAC address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    final newDevice = Device(
                      id: device?.id ?? DateTime.now().millisecondsSinceEpoch,
                      name: nameController.text,
                      typeOfDevice: typeController.text,
                      isOn: device?.isOn ?? false,
                      macAddress: macController.text,
                      ipAddress: ipController.text,
                    );

                    final provider =
                        Provider.of<DeviceProvider>(context, listen: false);
                    if (device == null) {
                      provider.addDevice(newDevice);
                    } else {
                      provider.updateDevice(newDevice);
                    }

                    Navigator.pop(context);
                  }
                },
                child: Text(device == null ? 'Add Device' : 'Update Device'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

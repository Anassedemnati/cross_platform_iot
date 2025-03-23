import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:cross_platform_iot/models/device.dart';
import 'package:cross_platform_iot/providers/device_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool isScanning = false;
  String scanStatus = 'Scan a QR code';

  @override
  void initState() {
    super.initState();
    _requestCameraPermission();
  }

  Future<void> _requestCameraPermission() async {
    // Check if running on iOS simulator
    bool isSimulator =
        !kIsWeb && Platform.isIOS && !(await Permission.camera.isGranted);

    if (isSimulator) {
      setState(() {
        scanStatus =
            'Camera not available on iOS simulator.\nPlease use a physical device for testing.';
      });
      return;
    }

    final status = await Permission.camera.request();
    if (status.isDenied) {
      setState(() {
        scanStatus = 'Camera permission denied';
      });
    }
  }

  @override
  void reassemble() {
    super.reassemble();
    if (controller != null) {
      // Pause camera on Android when reassembling
      if (Platform.isAndroid) {
        controller!.pauseCamera();
      }
      // Resume camera
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: _buildQrView(context),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(scanStatus),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          await controller?.toggleFlash();
                        },
                        child: const Icon(Icons.flash_on),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () async {
                          await controller?.flipCamera();
                        },
                        child: const Icon(Icons.flip_camera_ios),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // Get screen dimensions
    var scanArea = MediaQuery.of(context).size.width * 0.7;

    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Theme.of(context).primaryColor,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
      onPermissionSet: (ctrl, permission) {
        if (!permission) {
          setState(() {
            scanStatus = 'Camera permission denied';
          });
        }
      },
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
      isScanning = true;
      scanStatus = 'Scanning...';
    });

    controller.scannedDataStream.listen((scanData) {
      if (isScanning && scanData.code != null) {
        setState(() {
          isScanning = false;
          scanStatus = 'Processing QR code...';
        });

        _processScannedData(scanData);
      }
    });
  }

  void _processScannedData(Barcode scanData) {
    final deviceProvider = Provider.of<DeviceProvider>(context, listen: false);
    final deviceId = int.tryParse(scanData.code ?? '');

    if (deviceId != null) {
      final device = Device(
        id: deviceId,
        name: 'New Device',
        typeOfDevice: 'Unknown',
        ipAddress: 'Unknown',
        macAddress: 'Unknown',
        isOn: false,
      );
      deviceProvider.addDevice(device);
      Navigator.pop(context);
    } else {
      // Handle invalid QR code data
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid QR code data')),
      );
      // Re-enable scanning
      setState(() {
        isScanning = true;
        scanStatus = 'Scan a QR code';
      });
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

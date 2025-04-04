import 'package:cross_platform_iot/models/device.dart';
import 'package:cross_platform_iot/pages/device_detail_page.dart';
import 'package:cross_platform_iot/pages/device_form_page.dart';
import 'package:cross_platform_iot/pages/devices_page.dart';
import 'package:cross_platform_iot/pages/location_page.dart';
import 'package:cross_platform_iot/pages/scan_page.dart';
import 'package:cross_platform_iot/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/device_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DeviceProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Home Dashboard',
      theme: ThemeData(
        indicatorColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            secondary: Colors.blueAccent,
            primary: Colors.blueAccent),
      ),
      home: const HomeScreen(),
      routes: {
        '/devices': (context) => const DevicesPage(),
        '/device-detail': (context) => DeviceDetailPage(
          device: ModalRoute.of(context)!.settings.arguments as Device),
        '/settings': (context) => const SettingsPage(),
        '/scan': (context) => const ScanPage(),
        '/location': (context) => const LocationPage(), // Add this line

      },
      onGenerateRoute: (settings) {
        if (settings.name == '/device-form') {
          final device = settings.arguments as Device?;
          return MaterialPageRoute(
            builder: (context) => DeviceFormPage(device: device),
          );
        }
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //int _currentIndex = 0;
  bool isLightOn = false;
  bool isGarageOpen = false;
  double temperature = 22.0;
  double humidity = 50.0;
  bool isPoolPumpOn = false;
  bool isIrrigationPumpOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Theme.of(context).colorScheme.primary, Colors.black],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        NetworkImage('https://via.placeholder.com/150'),
                  ),
                  Text(
                    'John Doe',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              trailing: const Icon(Icons.arrow_forward),
              title: const Text('Dashboard'),
              onTap: () {
              },
            ),
            const Divider(
              height: 0,
              thickness: 0.5,
              color: Colors.grey,
            ),
            ListTile(
              leading: const Icon(Icons.devices),
              trailing: const Icon(Icons.arrow_forward),
              title: const Text('Devices'),
              onTap: () {
                Navigator.pushNamed(context, '/devices');
              },
            ),
            const Divider(
              height: 0,
              thickness: 0.5,
              color: Colors.grey,
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              trailing: const Icon(Icons.arrow_forward),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
            const Divider(
              height: 0,
              thickness: 0.5,
              color: Colors.grey,
            ),
            ListTile(
              leading: const Icon(Icons.qr_code_scanner),
              trailing: const Icon(Icons.arrow_forward),
              title: const Text('Scan Device'),
              onTap: () {
                Navigator.pushNamed(context, '/scan');
              },
            ),
            const Divider(
              height: 0,
              thickness: 0.5,
              color: Colors.grey,
            ),
            ListTile(
              leading: const Icon(Icons.location_on),
              trailing: const Icon(Icons.arrow_forward),
              title: const Text('Location'),
              onTap: () {
                Navigator.pushNamed(context, '/location');
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Smart Home Dashboard',
            style: TextStyle(color: Colors.white, fontSize: 24)),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Home Systems Control',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildTemperatureCard(),
                _buildLightControlCard(),
                _buildGarageControlCard(),
                _buildHumidityCard(),
                _buildPoolPumpCard(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget for Temperature Control
  Widget _buildTemperatureCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Temperature', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8.0),
            Text('${temperature.toStringAsFixed(1)}°C',
                style: const TextStyle(fontSize: 28)),
            Slider(
              value: temperature,
              min: 16.0,
              max: 30.0,
              divisions: 28,
              label: temperature.toStringAsFixed(1),
              onChanged: (value) {
                setState(() {
                  temperature = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  // Widget for Light Control
  Widget _buildLightControlCard() {
    return Card(
      color: isLightOn ? Colors.yellow[100] : null,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Lights', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8.0),
            Switch(
              value: isLightOn,
              onChanged: (value) {
                setState(() {
                  isLightOn = value;
                });
              },
            ),
            Text(isLightOn ? 'ON' : 'OFF',
                style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }

  // Widget for Garage Control
  Widget _buildGarageControlCard() {
    return Card(
      color: isGarageOpen ? Colors.green[100] : null,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Garage Door', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8.0),
            Switch(
              value: isGarageOpen,
              onChanged: (value) {
                setState(() {
                  isGarageOpen = value;
                });
              },
            ),
            Text(isGarageOpen ? 'Open' : 'Closed',
                style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }

  // Widget for Humidity Control
  Widget _buildHumidityCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Humidity', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8.0),
            Text('${humidity.toStringAsFixed(1)}%',
                style: const TextStyle(fontSize: 28)),
            Slider(
              value: humidity,
              min: 0.0,
              max: 100.0,
              divisions: 100,
              label: humidity.toStringAsFixed(1),
              onChanged: (value) {
                setState(() {
                  humidity = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  // Widget for Pool Pump Control
  Widget _buildPoolPumpCard() {
    return Card(
      color: isPoolPumpOn ? Colors.blue[100] : null,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Pool Pump', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8.0),
            Switch(
              value: isPoolPumpOn,
              onChanged: (value) {
                setState(() {
                  isPoolPumpOn = value;
                });
              },
            ),
            Text(isPoolPumpOn ? 'ON' : 'OFF',
                style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }

}

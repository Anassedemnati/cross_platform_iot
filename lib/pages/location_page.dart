import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  String _locationMessage = "";
  Position? _currentPosition;

  Future<void> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _locationMessage = "Location permissions are denied forever.";
      });
      return;
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];

    setState(() {
      _currentPosition = position;
      _locationMessage = "City: ${place.locality}, Country: ${place.country}";
    });
  }

  Future<void> _openMap() async {
    if (_currentPosition != null) {
      final url = 'https://www.google.com/maps/search/?api=1&query=${_currentPosition!.latitude},${_currentPosition!.longitude}';
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), mode: LaunchMode.inAppBrowserView);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GPS Location'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_locationMessage),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getCurrentLocation,
              child: const Text('Get Location'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _openMap,
              child: const Text('Open Map'),
            ),
          ],
        ),
      ),
    );
  }
}
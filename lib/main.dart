import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        indicatorColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue, secondary: Colors.blueAccent),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen',
            style: TextStyle(color: Colors.white, fontSize: 24)),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hello World!',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            // Button example
            ElevatedButton(
              onPressed: () {},
              child: const Text('Elevated Button'),
            ),
            const SizedBox(height: 16),
            // Icon example
            const Icon(Icons.favorite, color: Colors.red, size: 32),
            const SizedBox(height: 16),
            // Image example
            Image.network(
              'https://via.placeholder.com/150',
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 16),
            // TextField example
            const TextField(
              decoration: InputDecoration(
                labelText: 'Enter text',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            // Switch example
            Row(
              children: [
                const Text('Enable Notifications'),
                Switch(
                  value: true,
                  onChanged: (bool value) {},
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Checkbox example
            Row(
              children: [
                const Text('Accept Terms'),
                Checkbox(
                  value: true,
                  onChanged: (bool? value) {},
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Slider example
            const Text('Volume'),
            Slider(
              value: 50,
              min: 0,
              max: 100,
              onChanged: (double value) {},
            ),
            const SizedBox(height: 16),
            // DropdownButton example
            const Text('Select an option'),
            DropdownButton<String>(
              value: 'Option 1',
              items: const [
                DropdownMenuItem(value: 'Option 1', child: Text('Option 1')),
                DropdownMenuItem(value: 'Option 2', child: Text('Option 2')),
              ],
              onChanged: (String? newValue) {},
            ),
            const SizedBox(height: 16),
            // ProgressIndicator example
            const Text('Loading'),
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            // ListTile example
            const ListTile(
              leading: Icon(Icons.person),
              title: Text('John Doe'),
              subtitle: Text('Software Engineer'),
            ),
          ],
        ),
      ),
    );
  }
}

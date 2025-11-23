import 'package:flutter/material.dart';
import 'scanner_service.dart';

void main() => runApp(const BetterBiteApp());

class BetterBiteApp extends StatelessWidget {
  const BetterBiteApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BetterBite MVP',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String result = '';
  final ScannerService _scanner = ScannerService();

  void _scan() async {
    final text = await _scanner.scanImage();
    setState(() => result = text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BetterBite')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.camera_alt),
              label: const Text('Scan Ingredients'),
              onPressed: _scan,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SelectableText(result.isEmpty ? 'No scan yet' : result),
            ),
          ],
        ),
      ),
    );
  }
}

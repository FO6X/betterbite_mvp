import 'package:flutter/material.dart';
import 'scanner_service.dart';
import 'risk_engine.dart';

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
  String scanText = '';
  List<String> avoid = ['peanuts', 'gluten', 'lactose']; // demo list
  ({bool safe, List<String> flagged}) verdict = (safe: true, flagged: []);

  final ScannerService _scanner = ScannerService();

  void _scan() async {
    final text = await _scanner.scanImage();
    final res = RiskEngine.check(text, avoid);
    setState(() {
      scanText = text;
      verdict = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BetterBite')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ElevatedButton.icon(
            icon: const Icon(Icons.camera_alt),
            label: const Text('Scan Ingredients'),
            onPressed: _scan,
          ),
          const SizedBox(height: 16),
          if (scanText.isNotEmpty) ...[
            Text('Scanned text:', style: Theme.of(context).textTheme.titleMedium),
            SelectableText(scanText),
            const SizedBox(height: 12),
            Card(
              color: verdict.safe ? Colors.green[50] : Colors.red[50],
              child: ListTile(
                leading: Icon(verdict.safe ? Icons.check_circle : Icons.warning, color: verdict.safe ? Colors.green : Colors.red),
                title: Text(verdict.safe ? 'SAFE' : 'UNSAFE'),
                subtitle: verdict.flagged.isEmpty
                    ? null
                    : Text('Flagged: ${verdict.flagged.join(', ')}'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

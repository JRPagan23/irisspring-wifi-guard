import 'package:flutter/material.dart';
import '../models/device.dart';
import '../services/network_scanner.dart';
import 'tips_modal.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Device> knownDevices = [];
  List<Device> suspiciousDevices = [];
  bool isLoading = false;

  Future<void> startScan() async {
    setState(() {
      isLoading = true;
      knownDevices = [];
      suspiciousDevices = [];
    });

    final result = await NetworkScanner.scanNetwork();

    setState(() {
      knownDevices = result['known'] ?? [];
      suspiciousDevices = result['suspicious'] ?? [];
      isLoading = false;
    });
  }

  void showTips() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black87,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => const TipsModal(
        tips: [
          'Use strong passwords for your Wi-Fi.',
          'Keep your router firmware updated.',
          'Disable WPS to prevent unauthorized access.',
          'Use WPA3 encryption if available.',
          'Regularly scan for unknown devices.',
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0a0f2c), Colors.black],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'IrisSpring Wi-Fi Scanner',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontFamily: 'Orbitron',
                    color: Colors.cyanAccent,
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: isLoading ? null : startScan,
              style: ElevatedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF00CFFF), width: 2),
                foregroundColor: Colors.cyanAccent,
                backgroundColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                shadowColor: Colors.cyanAccent.withOpacity(0.4),
                elevation: 8,
              ),
              child: isLoading
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        color: Colors.cyanAccent,
                        strokeWidth: 3,
                      ),
                    )
                  : const Text(
                      '🔍 Scan Network',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Exo2',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),

            const SizedBox(height: 30),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (knownDevices.isNotEmpty) ...[
                      Text(
                        '✅ Known Devices (${knownDevices.length}):',
                        style: TextStyle(
                          color: Colors.greenAccent.shade400,
                          fontFamily: 'Orbitron',
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...knownDevices.map((d) => Text(
                            ' - ${d.mac} at ${d.ip}',
                            style: TextStyle(
                              color: Colors.cyanAccent.shade100,
                              fontFamily: 'Exo2',
                            ),
                          )),
                      const SizedBox(height: 20),
                    ],

                    if (suspiciousDevices.isNotEmpty) ...[
                      Text(
                        '⚠️ Suspicious Devices (${suspiciousDevices.length}):',
                        style: TextStyle(
                          color: Colors.redAccent.shade400,
                          fontFamily: 'Orbitron',
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...suspiciousDevices.map((d) => Text(
                            ' - ${d.mac} at ${d.ip}',
                            style: TextStyle(
                              color: Colors.redAccent.shade200,
                              fontFamily: 'Exo2',
                            ),
                          )),
                      const SizedBox(height: 20),
                    ],

                    ElevatedButton.icon(
                      onPressed: showTips,
                      icon: const Icon(Icons.cleaning_services_outlined,
                          color: Colors.cyanAccent),
                      label: const Text(
                        'Show Cleanup Tips',
                        style: TextStyle(
                          fontFamily: 'Exo2',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        side:
                            const BorderSide(color: Color(0xFF00CFFF), width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


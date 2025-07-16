import 'package:flutter/material.dart';
import '../models/device.dart';

class ScannerWidget extends StatelessWidget {
  final List<Device> knownDevices;
  final List<Device> suspiciousDevices;

  const ScannerWidget({super.key, required this.knownDevices, required this.suspiciousDevices});

  Widget _deviceList(String title, List<Device> devices, Color borderColor) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: borderColor, width: 2),
          boxShadow: [BoxShadow(color: borderColor.withOpacity(0.6), blurRadius: 10, spreadRadius: 1)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(color: borderColor, fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
            const SizedBox(height: 8),
            if (devices.isEmpty)
              Text('None found', style: TextStyle(color: borderColor.withOpacity(0.6)))
            else
              ...devices.map((d) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text("• ${d.mac} at ${d.ip}", style: TextStyle(color: borderColor, fontSize: 16)),
                  )),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _deviceList('Known Devices', knownDevices, Colors.greenAccent),
        _deviceList('Suspicious Devices', suspiciousDevices, Colors.redAccent),
      ],
    );
  }
}


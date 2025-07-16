import '../models/device.dart';

class NetworkScanner {
  // Static method to simulate a network scan and return known and suspicious devices
  static Future<Map<String, List<Device>>> scanNetwork() async {
    await Future.delayed(const Duration(seconds: 2)); // simulate delay

    List<Device> knownDevices = [
      Device(mac: '00:11:22:33:44:55', ip: '192.168.1.10'),
      Device(mac: '12:34:56:78:90:AB', ip: '192.168.1.12'),
    ];

    List<Device> suspiciousDevices = [
      Device(mac: 'AA:BB:CC:DD:EE:FF', ip: '192.168.1.20', isSuspicious: true),
    ];

    return {
      'known': knownDevices,
      'suspicious': suspiciousDevices,
    };
  }
}


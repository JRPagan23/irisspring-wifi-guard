class Device {
  final String mac;
  final String ip;
  final bool isSuspicious;

  Device({required this.mac, required this.ip, this.isSuspicious = false});
}


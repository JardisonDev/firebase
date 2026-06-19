import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerQrPage extends StatefulWidget {
  const ScannerQrPage({super.key});

  @override
  State<ScannerQrPage> createState() => _ScannerQrPageState();
}

class _ScannerQrPageState extends State<ScannerQrPage> {
  bool lido = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Escanear QR')),
      body: MobileScanner(
        onDetect: (capture) {
          if (lido) return;

          final barcode = capture.barcodes.first;

          if (barcode.rawValue != null) {
            lido = true;

            Navigator.pop(context, barcode.rawValue);
          }
        },
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greeny_flutter_app/Presentation/Screens/QRCode/UI/qr_scanner_overlay.dart';
import 'package:greeny_flutter_app/business_logic/repositories/redeem_repository.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRCode extends StatefulWidget {
  const QRCode({Key? key}) : super(key: key);

  @override
  State<QRCode> createState() => _QRCodeState();
}

class _QRCodeState extends State<QRCode> {
  MobileScannerController cameraController = MobileScannerController();
  final _redeemRepo = RedeemRepository();
  String barcodeValue = '';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MobileScanner(
          allowDuplicates: true,
          controller: cameraController,
          onDetect: (Barcode barcode, MobileScannerArguments? args) async {
            if (barcodeValue != barcode.rawValue!) {
              barcodeValue = barcode.rawValue!;
              var message = await _redeemRepo.redeemCode(barcode.rawValue!);
              return ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                ),
              );
            }
          },
        ),
        QRScannerOverlay(overlayColour: Colors.black.withOpacity(0.5))
      ],
    );
  }
}

import 'package:eshop/ui/qr/qr_scan_screen.dart';
import 'package:eshop/ui/qr/widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class BarcodeScanPage extends StatefulWidget {
  @override
  State<BarcodeScanPage> createState() => _BarcodeScanPageState();
}

class _BarcodeScanPageState extends State<BarcodeScanPage> {
  String barcode='Unknown';

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text('Barkod Tarama')),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Tarama sonucu',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white54,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8,),
          Text(
            '$barcode',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 72,),
          ButtonWidget(
            text: 'Taramayı başlat',
            onClicked: scanBarcode,
          ),
        ],
      ),
    ),
  );


  Future<void> scanBarcode() async{
    try{
      final barkod=await FlutterBarcodeScanner.scanBarcode(
          'ff6666',
          'İptal',
          true,
          ScanMode.BARCODE
      );

      if (!mounted) return;

      setState(() {
        this.barcode=barcode;
      });
    }
    on PlatformException {
      barcode='Platform sürümü alınamadı';
    }
  }
}

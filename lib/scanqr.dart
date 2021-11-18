import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:tharawatSeas/aslDetailsFromQr.dart';

import 'homePage.dart';

class ScanScreen extends StatefulWidget {
  static const String routeName = '/ScanScreen';

  @override
  _ScanState createState() => new _ScanState();
}

class _ScanState extends State<ScanScreen> {
  String barcode = "scan now";

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text('QR Code Scanner'),
        ),
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: RaisedButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    splashColor: Colors.blueGrey,
                    onPressed: () => scan(),
                    child: const Text('START CAMERA SCAN')),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  barcode,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ));
  }

  Future<void> scan() async {
    try {
      final qrResult = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);

      if (qrResult == "-1") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return HomePage();
            },
          ),
        );
      } else {
        var result = json.decode(qrResult);

        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return AslDetailsFromQr(
            assetNameAr: result["assetNameAr"].toString(),
            assetNameEn: result["assetNameEn"].toString(),
            classificationNameAr: result["classificationNameAr"].toString(),
            classificationNameEn: result["classificationNameEn"].toString(),
            purchaseDate: result["purchaseDate"].toString(),
            purchasePrice: result["purchasePrice"].toString(),
            assetDescription: result["assetDescription"].toString(),
          );
        }));

        if (!mounted) return;

        setState(() {
          this.barcode = qrResult;
          print(result);
        });
      }
    } on PlatformException {
      barcode = 'Failed';
    }
  }
}

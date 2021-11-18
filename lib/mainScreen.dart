import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:tharawatSeas/HBmodel.dart';

import 'package:tharawatSeas/navigationDrawer.dart';

import 'aslDetails.dart';
import 'aslDetailsFromQr.dart';
import 'constant.dart';

import 'package:http/http.dart' as http;

import 'generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homePage.dart';

class MainScreen extends StatefulWidget {
  static const String routeName = '/MainScreen';

  @override
  _MainScreenState createState() => _MainScreenState();
}

//text over flow
// padding
// scan cancel

class Assets {
  final String assetNameAr;
  final String assetNameEn;
  final int purchasePrice;
  final String purchaseDate;

  Assets(this.assetNameAr, this.assetNameEn, this.purchasePrice,
      this.purchaseDate);
}

class _MainScreenState extends State<MainScreen> {
  bool loading = true;
  HBmodel? data;
  String? barcode;
  int pageNum = 1;

  var myFormat = DateFormat('d-MM-yyyy');

  int? itemCount;

  getDataFromApi(int pageNo) async {
    loading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('bearer')!;
    var headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'http://faragmosa-001-site16.itempurl.com/api/AssetApi/GetAssetsForList'));
    request.body = json.encode({"PageNo": pageNo, "PageSize": 10});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      data =
          HBmodel.fromJson(json.decode(await response.stream.bytesToString()));
      setState(() {
        print(data!.responseData!.length);
        itemCount = data!.responseData!.length;
        loading = false;
      });
    } else {
      print(response.reasonPhrase);
    }
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

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    getDataFromApi(pageNum);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: mPrimaryTextColor,
          title: Text(LocaleKeys.ShowAssets.tr()),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.arrow_forward,
                  color: mBackgroundColor,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ]),
      drawer: NavigationDrawer(),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : data!.responseData!.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.cyanAccent.withOpacity(0.5),
                        border: Border.all(
                          color: Colors.transparent,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text(
                              "نأســف لا يـوجد اصــول مرتبطه بهــذا المــوقـع",
                              style: TextStyle(
                                  color: mPrimaryTextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'عــوده',
                                style: TextStyle(fontSize: 20),
                              ),
                              style: ElevatedButton.styleFrom(
                                  primary: mSecondTextColor),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        LocaleKeys.Welcome.tr(),
                        style: TextStyle(
                            color: mPrimaryTextColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(36),
                          ),
                          color: mPrimaryTextColor,
                          onPressed: () {
                            scan();
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            alignment: Alignment.center,
                            child: Text(
                              LocaleKeys.Scan_To_See_Your_Aasl_Details.tr(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                        child: Wrap(
                          children: List.generate(
                              data!.responseData!.length,
                              (index) => GestureDetector(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return AslDetails(
                                          astDetails:
                                              data!.responseData![index],
                                        );
                                      }));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          color: Colors.cyan.withOpacity(0.2),
                                          border: Border.all(
                                            color: Colors.transparent,
                                            width: 0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                                width: double.infinity,
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Ctxt(data!
                                                        .responseData![index]
                                                        .assetNameAr!),
                                                    Ctxt(data!
                                                        .responseData![index]
                                                        .assetNameEn!),
                                                    Ctxt(data!
                                                        .responseData![index]
                                                        .purchasePrice
                                                        .toString()),
                                                    Ctxt(myFormat
                                                        .format(DateTime.parse(
                                                            data!
                                                                .responseData![
                                                                    index]
                                                                .purchaseDate!))
                                                        .toString())
                                                  ],
                                                ))
                                          ],
                                        ),
                                      ),
                                    ),
                                  )),
                        ),
                      ),
                      itemCount! < 10
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  pageNum--;
                                  getDataFromApi(pageNum);
                                });
                              },
                              icon: Icon(Icons.arrow_back),
                              color: mPrimaryTextColor,
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      pageNum--;
                                      getDataFromApi(pageNum);
                                    });
                                  },
                                  icon: Icon(Icons.arrow_back),
                                  color: mPrimaryTextColor,
                                ),
                                Text(
                                  "Page : " + pageNum.toString(),
                                  style: TextStyle(color: mPrimaryTextColor),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      pageNum++;
                                      getDataFromApi(pageNum);
                                    });
                                  },
                                  icon: Icon(Icons.arrow_forward),
                                  color: mPrimaryTextColor,
                                ),
                              ],
                            )
                    ],
                  ),
                ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget Ctxt(String txt) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        txt,
        style: TextStyle(
          color: mSecondTextColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.cyan.withOpacity(0.2),
      elevation: 0,
      centerTitle: true,
      title: Text(
        LocaleKeys.AppName.tr(),
        style: TextStyle(
            color: mPrimaryTextColor,
            fontSize: 30,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}

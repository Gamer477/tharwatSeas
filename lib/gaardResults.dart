import 'dart:convert';
import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tharawatSeas/sGaardModel.dart';

import 'constant.dart';
import 'gResultModel.dart';
import 'generated/locale_keys.g.dart';
import 'navigationDrawer.dart';
import 'package:http/http.dart' as http;

class GaardResults extends StatefulWidget {
  final String selectedLocation;
  final String selectedLagna;
  final String locationsId;
  final String committeeId;
  final String gaardNotes;

  const GaardResults(
      {Key? key,
      required this.selectedLocation,
      required this.selectedLagna,
      required this.locationsId,
      required this.committeeId,
      required this.gaardNotes})
      : super(key: key);

  @override
  _GaardResultsState createState() => _GaardResultsState();
}

// ignore: unused_element
Future<SGModel>? _futGSModel;

class _GaardResultsState extends State<GaardResults> {
  List<TextEditingController> _controllers = [];
  final ItemScrollController _itemScrollController = ItemScrollController();

  void _scrollToIndex(int index) {
    _itemScrollController.scrollTo(
        index: index,
        duration: Duration(seconds: 2),
        curve: Curves.easeInOutCubic);
  }

  String? barcode;

  String? recievedIdFromQr;

  int? indexOfQr;

  var recievedAssetsId = [];

  Future<void> scan() async {
    try {
      final qrResult = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);

      if (qrResult == "-1") {
        Navigator.of(context).pop();
      } else {
        var result = json.decode(qrResult);

        recievedIdFromQr = result["assetId"].toString();

        if (!mounted) return;

        setState(() {
          indexOfQr = recievedAssetsId.indexOf(recievedIdFromQr);
          this.barcode = qrResult;
          print(result);
        });

        _scrollToIndex(indexOfQr!);
      }
    } on PlatformException {
      barcode = 'Failed';
    }
  }

  bool _validate = false;

  bool activeValue = false;

  DateTime selectedDate = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  bool loading = true;

  GRModel? gaardResultFuture;

  List<Map<String, dynamic>> assetMap = [];

  String url =
      "http://faragmosa-001-site16.itempurl.com/api/InventoryApi/SaveInventory";

  Future<SGModel> saveGData(List<Map<String, dynamic>> map) async {
    final assetsData = {
      "InventoryId": "00000000-0000-0000-0000-000000000000",
      "InventoryCode": 0,
      "InventoryDate": formatter.format(selectedDate).toString(),
      "CommitteeId": widget.committeeId,
      "LocationId": widget.locationsId,
      "Notes": widget.gaardNotes,
      "TbInventoryAssets": map
    };

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('bearer')!;

    final response = await http.post(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token'
        },
        body: json.encode(assetsData));

    print("Save Response : " + response.body);

    if (response.statusCode == 200) {
      print("Success");
      showToast(LocaleKeys.SavedSuccessfully.tr());
      return SGModel.fromJson(jsonDecode(response.body));
    } else {
      showToast("Failed");
      throw Exception('Failed to create album.');
    }
  }

  void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue[900],
        textColor: Colors.white,
        fontSize: 16.0);
  }

  getAssetsByLocation(String locationsID) async {
    print("here in getassetbylocation");
    print(widget.locationsId);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('bearer')!;
    var headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            'http://faragmosa-001-site16.itempurl.com/api/InventoryApi/GetAssetsBylocation'));
    request.body = json.encode({"LocationId": "$locationsID"});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print("hi");
      // // var body = await response.stream.bytesToString();

      // // print("Show Response : " + body);

      gaardResultFuture =
          GRModel.fromJson(json.decode(await response.stream.bytesToString()));

      print("respone lenght : " +
          gaardResultFuture!.responseData!.length.toString());

      for (var i = 0; i < gaardResultFuture!.responseData!.length; i++) {
        _controllers.add(new TextEditingController());

        recievedAssetsId
            .add(gaardResultFuture!.responseData![i].assetId.toString());
      }

      print(assetMap);

      setState(() {
        loading = false;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    getAssetsByLocation(widget.locationsId);

    super.initState();
  }

  void dispose() {
    // Clean up the focus node when the Form is disposed.

    for (TextEditingController c in _controllers) {
      c.dispose();
    }

    super.dispose();
  }

  // ignore: non_constant_identifier_names
  Widget Ctxt(String txt, Color color) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          txt,
          style: TextStyle(
            color: color,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget cellText(String lable, String txt) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Ctxt(lable, mPrimaryTextColor!),
        Ctxt(":", Colors.black),
        Ctxt(txt, mSecondTextColor!)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mPrimaryTextColor,
          title: Text(LocaleKeys.Gaard.tr()),
        ),
        drawer: NavigationDrawer(),
        body: loading
            ? Center(child: CircularProgressIndicator())
            : gaardResultFuture!.responseData!.isEmpty
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
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(36),
                              ),
                              color: mSecondTextColor,
                              onPressed: () {
                                scan();
                              },
                              child: Container(
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                alignment: Alignment.center,
                                child: Text(
                                  LocaleKeys.ScanToSeeAsset.tr(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: ScrollablePositionedList.builder(
                                  itemScrollController: _itemScrollController,
                                  itemCount:
                                      gaardResultFuture!.responseData!.length,
                                  addRepaintBoundaries: true,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          children: [
                                            Column(
                                              children: [
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                IntrinsicHeight(
                                                    child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          10.0, 0, 10.0, 0),
                                                  child: Container(
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      color: index == indexOfQr
                                                          ? Colors.green
                                                              .withOpacity(0.5)
                                                          : Colors.cyanAccent
                                                              .withOpacity(0.5),
                                                      border: Border.all(
                                                        color:
                                                            Colors.transparent,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        cellText(
                                                            LocaleKeys.AssetName
                                                                .tr(),
                                                            gaardResultFuture!
                                                                .responseData![
                                                                    index]
                                                                .assetNameAr
                                                                .toString()),
                                                        cellText(
                                                            LocaleKeys.BarCode
                                                                .tr(),
                                                            gaardResultFuture!
                                                                .responseData![
                                                                    index]
                                                                .assetBarcode
                                                                .toString()),
                                                        Ctxt(
                                                            LocaleKeys.Status
                                                                .tr(),
                                                            mPrimaryTextColor!),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  10.0,
                                                                  0,
                                                                  10.0,
                                                                  0),
                                                          child: Row(
                                                            children: <Widget>[
                                                              Checkbox(
                                                                value: gaardResultFuture!
                                                                    .responseData![
                                                                        index]
                                                                    .isActive,
                                                                onChanged:
                                                                    (value) {
                                                                  setState(() {
                                                                    gaardResultFuture!
                                                                        .responseData![
                                                                            index]
                                                                        .isActive = value!;
                                                                    print(value
                                                                        .toString());
                                                                  });
                                                                },
                                                              ),
                                                              Text(
                                                                  LocaleKeys
                                                                          .AvaliableNotAvailable
                                                                      .tr(),
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        20.0,
                                                                    color:
                                                                        mSecondTextColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  )),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: TextField(
                                                            controller:
                                                                _controllers[
                                                                    index],
                                                            minLines: 5,
                                                            maxLines: 5,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  OutlineInputBorder(),
                                                              labelText: LocaleKeys
                                                                      .AddNotes
                                                                  .tr(),
                                                              errorText: _validate
                                                                  ? LocaleKeys
                                                                          .ValueEmpty
                                                                      .tr()
                                                                  : null,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ))
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(40.0, 5, 40.0, 5),
                            child: Container(
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(36),
                                ),
                                color: mPrimaryTextColor,
                                onPressed: () {
                                  for (var i = 0;
                                      i <
                                          gaardResultFuture!
                                              .responseData!.length;
                                      i++) {
                                    assetMap.add({
                                      "AssetId": gaardResultFuture!
                                          .responseData![i].assetId
                                          .toString(),
                                      "IsExists": gaardResultFuture!
                                          .responseData![i].isActive,
                                      "AssetNote":
                                          _controllers[i].text.toString()
                                    });
                                  }

                                  print(assetMap);
                                  setState(() {
                                    _futGSModel = saveGData(assetMap);
                                  });

                                  assetMap.clear();
                                },
                                child: Container(
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  child: Text(
                                    LocaleKeys.Save.tr(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ));
  }
}

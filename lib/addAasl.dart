import 'dart:convert';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tharawatSeas/SDAssetModel.dart';
import 'package:tharawatSeas/homePage.dart';
import 'package:tharawatSeas/locationModel.dart';
import 'classificationModel.dart';
import 'constant.dart';
import 'generated/locale_keys.g.dart';
import 'navigationDrawer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;
import 'supplierModel.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddAasl extends StatefulWidget {
  static const String routeName = '/AddAasl';

  @override
  _AddAaslState createState() => _AddAaslState();
}

// ignore: unused_element
Future<SDModel>? _futHSModel;
double? lat, long;

class _AddAaslState extends State<AddAasl> {
  PickedFile? uploadImage;
  final _nameArabicController = TextEditingController();
  final _nameEnglishController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _report1Controller = TextEditingController();
  final _report2Controller = TextEditingController();
  final _barCodeController = TextEditingController();
  //static final kInitialPosition = LatLng(-33.8567844, 151.213108);
  String? _myAssetSupplierSelection;
  List<String> supplierData = [];
  List<String> supplierDataId = [];
  var indexOfAssetSupplier;

  String? _myAssetClassificationSelection;
  List<String> classificationData = [];
  List<String> classificationDataId = [];
  var indexOfAssetClassification;

  String? _myAssetLocationSelection;
  List<String> locationData = [];
  List<String> locationDataId = [];
  var indexOfAssetLocation;

  String url =
      "http://faragmosa-001-site16.itempurl.com/api/assetapi/SaveAsset";
  String uploadImageUrl =
      "http://faragmosa-001-site16.itempurl.com/api/Uploader/upload/AssetImages";
  DateTime selectedDate = DateTime.now();

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

  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));

    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Future<String> uploadImagefun() async {
    var request = http.MultipartRequest('POST', Uri.parse(uploadImageUrl));
    request.files
        .add(await http.MultipartFile.fromPath('image', uploadImage!.path));
    var res = await request.send();
    print("ssssssssssssssssssssssssssssssss-${res.reasonPhrase!}");
    return res.reasonPhrase!;
  }

  Future<SDModel> saveData(
      String assetId,
      String assetNameAr,
      String assetNameEn,
      String classificationId,
      String assetBarcode,
      String purchaseDate,
      double purchasePrice,
      double latitude,
      double longitude,
      String assetDescription,
      String qrcode,
      String supplierId,
      String locationId) async {
    final assetsData = {
      "AssetId": assetId,
      "AssetNameAr": assetNameAr,
      "AssetNameEn": assetNameEn,
      "ClassificationId": classificationId,
      "BaseBarcode": assetBarcode,
      "PurchaseDate": purchaseDate,
      "PurchasePrice": purchasePrice,
      "Latitude": latitude,
      "Longitude": longitude,
      "AssetDescription": assetDescription,
      "Qrcode": qrcode,
      "SupplierId": supplierId,
      "LocationId": locationId,
    };

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('bearer')!;

    final response = await http.post(Uri.parse(url),
        headers: <String, String>{
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(assetsData));

    print(response.body);

    //showLoadingDialog(context, _LoaderDialog);

    if (response.statusCode == 200) {
      //Navigator.of(_LoaderDialog.currentContext, rootNavigator: true).pop();
      if (jsonDecode(response.body)["response_code"] == "500") {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Error"),
                content: Text("Please Insert Base Barcode"),
                actions: [
                  FlatButton(
                    child: Text("Ok"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      } else {
        print("Success");
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Success"),
                content: Text("Asset Added Successfully"),
                actions: [
                  FlatButton(
                    child: Text("Ok"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
        return SDModel.fromJson(jsonDecode(response.body));
      }
      return SDModel.fromJson(jsonDecode(response.body));
    } else {
      showToast("Failed");
      throw Exception('Failed to create album.');
    }
  }

  Future<ClassificationModel> getAssetClassificationData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('bearer')!;
    var response = await http.get(
        Uri.http('faragmosa-001-site16.itempurl.com',
            'api/assetapi/GetAssetClassifications'),
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      ClassificationModel strings =
          ClassificationModel.fromJson(json.decode(response.body));

      for (var i = 0; i < strings.responseData!.length; i++) {
        classificationData.add(strings.responseData![i].classificationNameAr!);
        classificationDataId.add(strings.responseData![i].classificationId!);
      }

      print(classificationData.toString());
      print(classificationDataId.toString());

      setState(() {
        loading = false;
      });

      return ClassificationModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<SupplierModel> getAssetSupplierData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('bearer')!;
    var response = await http.get(
        Uri.http('faragmosa-001-site16.itempurl.com',
            'api/assetapi/GetAssetSuppliers'),
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      SupplierModel strings =
          SupplierModel.fromJson(json.decode(response.body));

      for (var i = 0; i < strings.responseData!.length; i++) {
        supplierData.add(strings.responseData![i].supplierNameAr!);
        supplierDataId.add(strings.responseData![i].supplierId!);
      }

      print(supplierData.toString());
      print(supplierDataId.toString());

      setState(() {
        loading = false;
      });

      return SupplierModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<LocationModel> getAssetLocationData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('bearer')!;
    var response = await http.get(
        Uri.http(
            'faragmosa-001-site16.itempurl.com', 'api/assetapi/GetLocations'),
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      LocationModel strings =
          LocationModel.fromJson(json.decode(response.body));

      for (var i = 0; i < strings.responseData!.length; i++) {
        locationData.add(strings.responseData![i].locationNameAr!);
        locationDataId.add(strings.responseData![i].locationId!);
      }

      print(locationData.toString());
      print(locationDataId.toString());

      setState(() {
        loading = false;
      });

      return LocationModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<ClassificationModel>? assetsClassificationDataFuture;
  Future<SupplierModel>? assetsSupplierDataFuture;
  Future<LocationModel>? assetsLocationDataFuture;

  bool loading = true;

  @override
  void initState() {
    assetsClassificationDataFuture = getAssetClassificationData();
    assetsLocationDataFuture = getAssetLocationData();
    assetsSupplierDataFuture = getAssetSupplierData();
    super.initState();
  }

  Future<void> chooseImage() async {
    var choosedImage =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    print(choosedImage!.path);
    setState(() {
      uploadImage = choosedImage;
      print(uploadImage!.path);
    });
  }

  bool _validate = false;

  Widget cTextField(String hint, final controller, bool validator) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          labelStyle: TextStyle(
            color: mPrimaryTextColor,
            fontWeight: FontWeight.bold,
          ),
          labelText: hint,
          errorText: validator ? LocaleKeys.ValueEmpty.tr() : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
            backgroundColor: mPrimaryTextColor,
            title: Text(LocaleKeys.Add_Aasl.tr()),
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
            : Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.withOpacity(0.7),
                  border: Border.all(
                    color: Colors.transparent,
                    width: 0,
                  ),
                  borderRadius: BorderRadius.circular(32),
                ),
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        cTextField(LocaleKeys.AssetnameAr.tr(),
                            _nameArabicController, _validate),
                        cTextField(LocaleKeys.AssetnameEn.tr(),
                            _nameEnglishController, _validate),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                            controller: _priceController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              labelStyle: TextStyle(
                                color: mPrimaryTextColor,
                                fontWeight: FontWeight.bold,
                              ),
                              labelText: LocaleKeys.Price.tr(),
                              errorText:
                                  _validate ? LocaleKeys.ValueEmpty.tr() : null,
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            color: mPrimaryTextColor!.withOpacity(0.5),
                            onPressed: () {
                              _selectDate(context);
                              print(selectedDate.toString());
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              alignment: Alignment.center,
                              child: Text(
                                LocaleKeys.EnterDate.tr(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(20.0)),
                            child: DropdownButton<String>(
                              hint: Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Text(LocaleKeys.Classification.tr()),
                              ),
                              isExpanded: true,
                              items: classificationData.map((String value) {
                                return new DropdownMenuItem<String>(
                                  value: value,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: new Text(value),
                                  ),
                                );
                              }).toList(),
                              value: _myAssetClassificationSelection,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _myAssetClassificationSelection = newValue;

                                  indexOfAssetClassification =
                                      classificationData.indexOf(newValue!);
                                });
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(20.0)),
                            child: DropdownButton<String>(
                              hint: Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Text(LocaleKeys.Supplier.tr()),
                              ),
                              isExpanded: true,
                              items: supplierData.map((String value) {
                                return new DropdownMenuItem<String>(
                                  value: value,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: new Text(value),
                                  ),
                                );
                              }).toList(),
                              value: _myAssetSupplierSelection,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _myAssetSupplierSelection = newValue;

                                  indexOfAssetSupplier =
                                      supplierData.indexOf(newValue!);
                                });
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(20.0)),
                            child: DropdownButton<String>(
                              hint: Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Text(LocaleKeys.Location.tr()),
                              ),
                              isExpanded: true,
                              items: locationData.map((String value) {
                                return new DropdownMenuItem<String>(
                                  value: value,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: new Text(value),
                                  ),
                                );
                              }).toList(),
                              value: _myAssetLocationSelection,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _myAssetLocationSelection = newValue;

                                  indexOfAssetLocation =
                                      locationData.indexOf(newValue!);
                                });
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                            controller: _barCodeController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              labelStyle: TextStyle(
                                color: mPrimaryTextColor,
                                fontWeight: FontWeight.bold,
                              ),
                              labelText: LocaleKeys.BarCode.tr(),
                              errorText:
                                  _validate ? LocaleKeys.ValueEmpty.tr() : null,
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            color: mSecondTextColor!.withOpacity(0.5),
                            onPressed: () async {
                              LocationResult? result = await showLocationPicker(
                                context,
                                "AIzaSyBU6YNVxesC2-qRF2yDgCk7be8QaQz56kQ",
                                initialCenter: LatLng(31.1975844, 29.9598339),
                                automaticallyAnimateToCurrentLocation: true,
                                myLocationButtonEnabled: true,
                                layersButtonEnabled: true,
                              );
                              setState(() {
                                lat = result!.latLng!.latitude;
                                long = result.latLng!.longitude;
                              });
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              alignment: Alignment.center,
                              child: Text(
                                LocaleKeys.Location.tr(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                            controller: _descriptionController,
                            minLines: 5,
                            maxLines: 5,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              labelStyle: TextStyle(
                                color: mPrimaryTextColor,
                                fontWeight: FontWeight.bold,
                              ),
                              labelText: LocaleKeys.AssetDescription.tr(),
                              errorText:
                                  _validate ? LocaleKeys.ValueEmpty.tr() : null,
                            ),
                          ),
                        ),
                        cTextField(LocaleKeys.DeclarationOne.tr(),
                            _report1Controller, _validate),
                        cTextField(LocaleKeys.DeclarationTwo.tr(),
                            _report2Controller, _validate),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _futHSModel = saveData(
                                            "00000000-0000-0000-0000-000000000000",
                                            _nameArabicController.text
                                                .toString(),
                                            _nameEnglishController.text
                                                .toString(),
                                            classificationDataId[
                                                    indexOfAssetClassification]
                                                .toString(),
                                            _barCodeController.text.toString(),
                                            formatter
                                                .format(selectedDate)
                                                .toString(),
                                            double.parse(_priceController.text),
                                            lat ?? 20.332232,
                                            long ?? 2.23332,
                                            _descriptionController.text,
                                            "",
                                            supplierDataId[indexOfAssetSupplier]
                                                .toString(),
                                            locationDataId[indexOfAssetLocation]
                                                .toString());
                                      });

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return HomePage();
                                          },
                                        ),
                                      );
                                    },
                                    color: mSecondTextColor,
                                    child: Text(LocaleKeys.SaveAndClose.tr(),
                                        style: TextStyle(
                                            color: mBackgroundColor,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      LocaleKeys.SaveAndAdd.tr(),
                                      style: TextStyle(
                                          color: mBackgroundColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    color: mPrimaryTextColor,
                                    onPressed: () {
                                      setState(() {
                                        _futHSModel = saveData(
                                            "00000000-0000-0000-0000-000000000000",
                                            _nameArabicController.text
                                                .toString(),
                                            _nameEnglishController.text
                                                .toString(),
                                            classificationDataId[
                                                    indexOfAssetClassification]
                                                .toString(),
                                            _barCodeController.text.toString(),
                                            formatter
                                                .format(selectedDate)
                                                .toString(),
                                            double.parse(_priceController.text),
                                            lat ?? 20.332232,
                                            long ?? 2.23332,
                                            _descriptionController.text,
                                            "",
                                            supplierDataId[indexOfAssetSupplier]
                                                .toString(),
                                            locationDataId[indexOfAssetLocation]
                                                .toString());
                                      });

                                      _barCodeController.clear();
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Column(
                                  children: [
                                    RaisedButton(
                                      onPressed: () {
                                        chooseImage();
                                      },
                                      child: Text('Pick An Image'),
                                    ),
                                    RaisedButton(
                                      onPressed: () {
                                        uploadImagefun();
                                      },
                                      child: Text('Pick An Imagessss'),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
  }
}

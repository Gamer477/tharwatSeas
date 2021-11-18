import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tharawatSeas/committeeModel.dart';
import 'package:tharawatSeas/gaardResults.dart';
import 'package:tharawatSeas/locationModel.dart';
import 'constant.dart';
import 'generated/locale_keys.g.dart';
import 'navigationDrawer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;

class Gaard extends StatefulWidget {
  static const String routeName = '/Gaard';

  @override
  _GaardState createState() => _GaardState();
}

class _GaardState extends State<Gaard> {
  final _text = TextEditingController();

  bool _validate = false;

  String? _myLocationSelection;
  String? _myLagnaSelection;

  List<String> locationsData = [];
  List<String> locationsDataID = [];
  var indexOfLocations;

  List<String> commiteData = [];
  List<String> commiteDataId = [];
  var indexOfCommittee;

  bool loading = true;

  Future<LocationModel>? locationsDataFuture;
  Future<CommitteeModel>? committeeDataFuture;

  Future<LocationModel> getLocationsData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('bearer')!;
    var response = await http.get(
        Uri.http('faragmosa-001-site16.itempurl.com',
            '/api/InventoryApi/GetLocations'),
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      LocationModel strings =
          LocationModel.fromJson(json.decode(response.body));

      for (var i = 0; i < strings.responseData!.length; i++) {
        locationsData.add(strings.responseData![i].locationNameAr!);
        locationsDataID.add(strings.responseData![i].locationId!);
      }

      print(locationsData.toString());
      print(locationsDataID.toString());

      setState(() {
        loading = false;
      });

      return LocationModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<CommitteeModel> getCommitteeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('bearer')!;
    var response = await http.get(
        Uri.http('faragmosa-001-site16.itempurl.com',
            '/api/InventoryApi/GetCommitteeInventory'),
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      CommitteeModel strings =
          CommitteeModel.fromJson(json.decode(response.body));

      for (var i = 0; i < strings.responseData!.length; i++) {
        commiteData.add(strings.responseData![i].committeeNameAr!);
        commiteDataId.add(strings.responseData![i].committeeId!);
      }

      print(commiteData.toString());
      print(commiteDataId.toString());

      setState(() {
        loading = false;
      });

      return CommitteeModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  @override
  void initState() {
    locationsDataFuture = getLocationsData();
    committeeDataFuture = getCommitteeData();
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
            backgroundColor: mPrimaryTextColor,
            title: Text(LocaleKeys.Gaard.tr()),
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
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.withOpacity(0.7),
                      border: Border.all(
                        color: Colors.transparent,
                        width: 0,
                      ),
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        /*Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          LocaleKeys.Gaard.tr(),
                          style: TextStyle(
                              color: mPrimaryTextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        ),
                      ),*/
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(right: 10, left: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(20.0)),
                            child: DropdownButton<String>(
                              underline: new Container(),
                              style: TextStyle(
                                  color: mPrimaryTextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                              hint: Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Text(LocaleKeys.ChooseLocation.tr()),
                              ),
                              isExpanded: true,
                              items: locationsData.map((String value) {
                                return new DropdownMenuItem<String>(
                                  value: value,
                                  child: new Text(value),
                                );
                              }).toList(),
                              value: _myLocationSelection,
                              onChanged: (newValue) {
                                setState(() {
                                  _myLocationSelection = newValue;

                                  indexOfLocations =
                                      locationsData.indexOf(newValue!);
                                });
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(right: 10, left: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(20.0)),
                            child: DropdownButton<String>(
                              underline: new Container(),
                              style: TextStyle(
                                  color: mPrimaryTextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                              hint: Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Text(LocaleKeys.ChooseBoard.tr()),
                              ),
                              isExpanded: true,
                              items: commiteData.map((String value) {
                                return new DropdownMenuItem<String>(
                                  value: value,
                                  child: new Text(value),
                                );
                              }).toList(),
                              value: _myLagnaSelection,
                              onChanged: (newValue) {
                                setState(() {
                                  _myLagnaSelection = newValue;
                                  indexOfCommittee =
                                      commiteData.indexOf(newValue!);
                                });
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                            controller: _text,
                            minLines: 5,
                            maxLines: 5,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelStyle: TextStyle(
                                color: mPrimaryTextColor,
                                fontWeight: FontWeight.bold,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              labelText: LocaleKeys.AddNotes.tr(),
                              errorText:
                                  _validate ? LocaleKeys.ValueEmpty.tr() : null,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(36),
                            ),
                            color: mSecondTextColor,
                            onPressed: () {
                              setState(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return GaardResults(
                                        selectedLocation: _myLocationSelection!,
                                        selectedLagna: _myLagnaSelection!,
                                        locationsId:
                                            locationsDataID[indexOfLocations]
                                                .toString(),
                                        committeeId:
                                            commiteDataId[indexOfCommittee]
                                                .toString(),
                                        gaardNotes: _text.text.toString(),
                                      );
                                    },
                                  ),
                                );
                              });
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              alignment: Alignment.center,
                              child: Text(
                                LocaleKeys.StartGaard.tr(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ));
  }
}

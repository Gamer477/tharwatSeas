import 'package:flutter/material.dart';

import 'constant.dart';
import 'generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class AslDetailsFromQr extends StatefulWidget {
  final String assetNameAr;
  final String assetNameEn;
  final String classificationNameAr;
  final String classificationNameEn;
  final String purchasePrice;
  final String purchaseDate;
  final String assetDescription;

  const AslDetailsFromQr({
    Key? key,
    required this.assetNameAr,
    required this.assetNameEn,
    required this.classificationNameAr,
    required this.classificationNameEn,
    required this.assetDescription,
    required this.purchaseDate,
    required this.purchasePrice,
  }) : super(key: key);

  @override
  _AslDetailsFromQrState createState() => _AslDetailsFromQrState();
}

class _AslDetailsFromQrState extends State<AslDetailsFromQr> {
  var myFormat = DateFormat('d-MM-yyyy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.cyan.withOpacity(0.2),
              border: Border.all(
                color: Colors.transparent,
                width: 0,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                cellText(
                    LocaleKeys.AssetName.tr(), widget.assetNameAr.toString()),
                cellText(LocaleKeys.AssetDescription.tr(),
                    widget.assetDescription.toString()),
                cellText(
                    LocaleKeys.Price.tr(),
                    myFormat
                        .format(DateTime.parse(widget.purchaseDate.toString()))
                        .toString()),
                cellText(LocaleKeys.Date.tr(), widget.purchaseDate.toString()),
                cellText(LocaleKeys.Classification.tr(),
                    widget.classificationNameAr.toString()),
              ],
            ),
          ),
        ),
      ),
      appBar: buildAppBar(context),
    );
  }

  Widget cellText(String lable, String txt) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Ctxt("$lable : ", mPrimaryTextColor!),
          Ctxt(txt, mSecondTextColor!)
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget Ctxt(String txt, Color colors) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          txt,
          style: TextStyle(
            color: colors,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: mPrimaryTextColor,
      elevation: 0,
      centerTitle: true,
      title: Text(
        LocaleKeys.AppName.tr(),
        style: TextStyle(
            color: mBackgroundColor, fontSize: 30, fontWeight: FontWeight.bold),
      ),
    );
  }
}

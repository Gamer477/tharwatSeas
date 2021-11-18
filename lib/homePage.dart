import 'package:flutter/material.dart';
import 'package:tharawatSeas/addAasl.dart';
import 'package:tharawatSeas/gaard.dart';
import 'package:tharawatSeas/login.dart';
import 'generated/locale_keys.g.dart';
import 'mainScreen.dart';
import 'navigationDrawer.dart';
import 'constant.dart';
import 'package:easy_localization/easy_localization.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/HomePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget commonButton(String txt, var route) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: mPrimaryTextColor,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return route;
                },
              ),
            );
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            alignment: Alignment.center,
            child: Text(
              txt,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          backgroundColor: mPrimaryTextColor,
          centerTitle: true,
          title: Text(
            LocaleKeys.Home.tr(),
            style: TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        drawer: NavigationDrawer(),
        body: SingleChildScrollView(
          child: Center(
              child: Column(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  "assets/logo.jpg",
                  height: 200,
                  width: 200,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                LocaleKeys.PleaseChoose.tr(),
                style: TextStyle(
                    color: mPrimaryTextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              commonButton(LocaleKeys.ShowAssets.tr(), MainScreen()),
              commonButton(LocaleKeys.Add_Aasl.tr(), AddAasl()),
              commonButton(LocaleKeys.Gaard.tr(), Gaard()),
              commonButton(LocaleKeys.Logout.tr(), LoginScreen()),
            ],
          )),
        ));
  }
}

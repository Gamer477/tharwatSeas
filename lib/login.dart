import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tharawatSeas/generated/locale_keys.g.dart';
import 'package:tharawatSeas/loginModel.dart';
import 'constant.dart';
import 'homePage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

//loader
//error label

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _text = TextEditingController();
  final _textPas = TextEditingController();
  bool _validate = false;
  bool _validatePas = false;
  bool? passVisability;

  // ignore: non_constant_identifier_names
  final GlobalKey<State> _LoaderDialog = new GlobalKey<State>();

  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(left: 130, right: 130),
          child: Dialog(
              key: key,
              backgroundColor: Colors.white,
              child: Container(
                width: 60.0,
                height: 60.0,
                child: Image.network(
                  "https://previews.123rf.com/images/iulika1/iulika11804/iulika1180400024/98593522-circular-loading-sign-waiting-symbol-blue-icon-isolated-on-white-background-vector-illustration-.jpg",
                  height: 60,
                  width: 60,
                ),
              )),
        );
      },
    );
  }

  String url = "http://faragmosa-001-site16.itempurl.com/api/UserApi/login";

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

  Future<LoginModel> saveData(
    String usernameApi,
    String passwordApi,
  ) async {
    final assetsData = {
      "Username": usernameApi,
      "Password": passwordApi,
    };

    showLoadingDialog(context, _LoaderDialog);

    final response = await http.post(Uri.parse(url),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode(assetsData));

    print(response.body);

    if (response.statusCode == 200) {
      Navigator.of(_LoaderDialog.currentContext!, rootNavigator: true).pop();
      if (jsonDecode(response.body)["response_code"] == "500") {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Error"),
                content: Text("username or password is wrong"),
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
        showToast(LocaleKeys.SavedSuccessfully.tr());
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(
            'bearer', (jsonDecode(response.body))["response_token"]);

        await prefs.setString("username",
            (jsonDecode(response.body))["response_data"]["userName"]);

        await prefs.setString(
            "email", (jsonDecode(response.body))["response_data"]["email"]);

        await prefs.setString("password", passwordApi);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return HomePage();
            },
          ),
        );
        return LoginModel.fromJson(jsonDecode(response.body));
      }
      return LoginModel.fromJson(jsonDecode(response.body));
    } else {
      showToast("Failed");
      throw Exception('Failed');
    }
  }

  @override
  void initState() {
    passVisability = true;
    super.initState();
  }

  @override
  void dispose() {
    _text.dispose();
    _textPas.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Image.asset(
                'assets/logo.jpg',
                width: 250,
                height: 250,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 30,
                ),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.withOpacity(0.7),
                  border: Border.all(
                    color: Colors.transparent,
                    width: 0,
                  ),
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: _text,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelStyle: TextStyle(
                            color: mPrimaryTextColor,
                            fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        prefixIcon: Icon(
                          Icons.email_rounded,
                          color: mPrimaryTextColor,
                        ),
                        labelText: LocaleKeys.Username.tr(),
                        errorText:
                            _validate ? LocaleKeys.ValueEmpty.tr() : null,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _textPas,
                      obscureText: passVisability!,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelStyle: TextStyle(
                            color: mPrimaryTextColor,
                            fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        labelText: LocaleKeys.Enter_Password.tr(),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: mPrimaryTextColor,
                        ),
                        suffixIcon: IconButton(
                          color: mPrimaryTextColor,
                          icon: Icon(passVisability!
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              passVisability = !passVisability!;
                            });
                          },
                        ),
                        errorText:
                            _validatePas ? LocaleKeys.ValueEmpty.tr() : null,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 55),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(36),
                        ),
                        color: mPrimaryTextColor,
                        onPressed: () {
                          // EasyLocalization.of(context).locale == Locale("ar")
                          //    ? EasyLocalization.of(context).locale = Locale("en")
                          //    : EasyLocalization.of(context).locale = Locale("ar");
                          setState(() {
                            if (_text.text.isEmpty || _textPas.text.isEmpty) {
                              if (_text.text.isEmpty) {
                                _validate = true;
                              } else {
                                _validatePas = true;
                              }
                            } else {
                              _validate = false;
                              _validatePas = false;
                              saveData(_text.text, _textPas.text);
                            }
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          alignment: Alignment.center,
                          child: Text(
                            LocaleKeys.Login.tr(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: mBackgroundColor,
      elevation: 0,
      centerTitle: true,
      title: Text(
        LocaleKeys.Login.tr(),
        style: TextStyle(
          color: mPrimaryTextColor,
        ),
      ),
    );
  }
}

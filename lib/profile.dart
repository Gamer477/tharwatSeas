import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'generated/locale_keys.g.dart';
import 'navigationDrawer.dart';
import 'constant.dart';
import 'package:easy_localization/easy_localization.dart';

class Profile extends StatefulWidget {
  static const String routeName = '/Profile';

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? usernameShared;
  String? emailShared;
  String? passwordShared;

  bool passVisability = true;

  bool _loading = true;

  getShared() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    usernameShared = prefs.getString('username');
    emailShared = prefs.getString('email');
    passwordShared = prefs.getString('password');

    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState

    super.initState();
    getShared();
  }

  @override
  Widget build(BuildContext context) {
    print(usernameShared);
    return new Scaffold(
        appBar: AppBar(
          backgroundColor: mPrimaryTextColor,
          centerTitle: true,
          title: Text(
            LocaleKeys.Profile.tr(),
            style: TextStyle(
                color: mBackgroundColor,
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
        ),
        drawer: NavigationDrawer(),
        body: _loading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
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
                      LocaleKeys.Welcome.tr(),
                      style: TextStyle(
                          color: mPrimaryTextColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IntrinsicHeight(
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                              color: Colors.white.withOpacity(0.5),
                            ),
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                    enabled: false,
                                    initialValue: usernameShared,
                                    decoration: new InputDecoration(
                                      labelText: "Username",
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                    enabled: false,
                                    initialValue: emailShared,
                                    decoration: new InputDecoration(
                                      labelText: "Email",
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                    enabled: false,
                                    initialValue: passwordShared,
                                    obscureText: true,
                                    decoration: new InputDecoration(
                                      labelText: "Password",
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        )),
                  ],
                )),
              ));
  }
}

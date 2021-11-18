import 'package:flutter/material.dart';
import 'generated/locale_keys.g.dart';
import 'pageRoutes.dart';
import 'package:easy_localization/easy_localization.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          createDrawerHeader(),
          createDrawerBodyItem(
            icon: Icons.home,
            text: LocaleKeys.Home.tr(),
            onTap: () =>
                Navigator.pushReplacementNamed(context, PageRoutes.homepage),
          ),
          createDrawerBodyItem(
            icon: Icons.slideshow,
            text: LocaleKeys.ShowAssets.tr(),
            onTap: () =>
                Navigator.pushReplacementNamed(context, PageRoutes.home),
          ),
          createDrawerBodyItem(
            icon: Icons.account_circle,
            text: LocaleKeys.Profile.tr(),
            onTap: () =>
                Navigator.pushReplacementNamed(context, PageRoutes.profile),
          ),
          createDrawerBodyItem(
            icon: Icons.event_note,
            text: LocaleKeys.Gaard.tr(),
            onTap: () =>
                Navigator.pushReplacementNamed(context, PageRoutes.gaard),
          ),
          Divider(),
          createDrawerBodyItem(
            icon: Icons.add,
            text: LocaleKeys.Add_Aasl.tr(),
            onTap: () =>
                Navigator.pushReplacementNamed(context, PageRoutes.addAsal),
          ),
          createDrawerBodyItem(
            icon: Icons.scanner,
            text: LocaleKeys.scanQrCode.tr(),
            onTap: () =>
                Navigator.pushReplacementNamed(context, PageRoutes.scanqr),
          ),
          createDrawerBodyItem(
              icon: Icons.language,
              text: LocaleKeys.ChangeLanguage.tr(),
              onTap: () {
                EasyLocalization.of(context)!.locale == Locale("ar")
                    // ? EasyLocalization.of(context)!.locale = Locale("en")
                    // : EasyLocalization.of(context)!.locale = Locale("ar");
                    ? EasyLocalization.of(context)!.setLocale(Locale('en'))
                    : EasyLocalization.of(context)!.setLocale(Locale('ar'));
              }),
          ListTile(
            title: Text(LocaleKeys.Logout.tr()),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget createDrawerBodyItem(
      {IconData? icon, String? text, GestureTapCallback? onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text!),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  Widget createDrawerHeader() {
    return DrawerHeader(
        margin: EdgeInsets.fromLTRB(0, 40.0, 0, 0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage('assets/logo.jpg'))),
        child: Stack(children: <Widget>[
          Text("",
              style: TextStyle(
                  color: Colors.blue[900],
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500)),
        ]));
  }
}

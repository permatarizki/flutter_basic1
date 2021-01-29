import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:package_info/package_info.dart';
import 'package:prokit_flutter/main/utils/AppColors.dart';
import 'package:prokit_flutter/main/utils/AppConstant.dart';
import 'package:prokit_flutter/main/utils/AppWidget.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../main.dart';

class SettingScreen extends StatefulWidget {
  static String tag = '/SettingScreen';

  @override
  SettingScreenState createState() => SettingScreenState();
}

class SettingScreenState extends State<SettingScreen> {
  AdmobInterstitial interstitialAd;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    interstitialAd = await showInterstitialAd();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() async {
    super.dispose();

    if (await interstitialAd?.isLoaded) {
      interstitialAd?.show();

      //interstitialAd?.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: boldTextStyle(size: 22)),
        backgroundColor: appStore.appBarColor,
        leading: BackButton(
          color: appStore.textPrimaryColor,
          onPressed: () {
            finish(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              settingItem(
                context,
                "Documentation",
                onTap: () async {
                  launch(DocumentationUrl, forceWebView: true, enableJavaScript: true);
                },
                leading: Image.asset('images/app/ic_documentation.png', height: 24, width: 24, color: appColorPrimary),
              ),
              Divider(height: 0),
              settingItem(
                context,
                "Change Logs",
                onTap: () async {
                  launch(ChangeLogsUrl, forceWebView: true, enableJavaScript: true);
                },
                leading: Image.asset('images/app/ic_change_log.png', height: 24, width: 24, color: appColorPrimary),
              ),
              Divider(height: 0),
              settingItem(
                context,
                "Share App",
                onTap: () async {
                  PackageInfo.fromPlatform().then((value) async {
                    String package = value.packageName;
                    await Share.share('Download $mainAppName from Play Store\n\n\n$PlayStoreUrl$package');
                  });
                },
                leading: Image.asset('images/app/ic_share.png', height: 24, width: 24, color: appColorPrimary),
              ),
              Divider(height: 0),
              settingItem(
                context,
                "Rate us",
                onTap: () {
                  PackageInfo.fromPlatform().then((value) async {
                    String package = value.packageName;
                    launch('$PlayStoreUrl$package');
                  });
                },
                leading: Image.asset('images/app/ic_rate_app.png', height: 24, width: 24, color: appColorPrimary),
              ),
              Divider(height: 0),
              settingItem(
                context,
                "Dark Mode",
                onTap: () {
                  appStore.toggleDarkMode();
                  setState(() {});
                },
                leading: Image.asset('images/app/ic_theme.png', height: 24, width: 24, color: appColorPrimary),
                detail: Switch(
                  value: appStore.isDarkModeOn,
                  onChanged: (s) {
                    appStore.toggleDarkMode(value: s);
                    setState(() {});
                  },
                ).withHeight(24),
              ),
              Divider(height: 0),
              50.height,
              Container(
                margin: EdgeInsets.only(left: 16),
                child: Text('Our New Product', style: boldTextStyle(size: 14, color: Colors.black)),
              ),
              10.height,
              commonCacheImageWidget('https://codecanyon.img.customer.envatousercontent.com/files/312512033/Preview.jpg?auto=compress%2Cformat&q=80&fit=crop&crop=top&max-h=8000&max-w=590&s=fa6aac75b36d1558f5e86ddd1fdcaba1', 200,
                      width: context.width(), fit: BoxFit.fill)
                  .paddingOnly(left: 8, right: 8)
                  .onTap(() {
                launch(MimikCloneUrl, forceWebView: true, enableJavaScript: true);
              })
            ],
          ),
          Positioned(bottom: 0, child: AdMobAdWidget()),
        ],
      ),
    );
  }
}

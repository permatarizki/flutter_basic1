import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:prokit_flutter/main/model/AppModel.dart';
import 'package:prokit_flutter/main/utils/AppColors.dart';
import 'package:prokit_flutter/main/utils/AppImages.dart';
import 'package:prokit_flutter/main/utils/AppWidget.dart';

import '../../main.dart';
import 'ThemeList.dart';

class ProKitScreenListing extends StatefulWidget {
  static String tag = "/ProKitScreenListing";
  final ProTheme proTheme;

  ProKitScreenListing(this.proTheme);

  @override
  ProKitScreenListingState createState() => ProKitScreenListingState();
}

class ProKitScreenListingState extends State<ProKitScreenListing> {
  var width;
  var height;
  var selectedTab = 0;
  List<ProTheme> list = List<ProTheme>();
  List<Color> colors = [appCat1, appCat2, appCat3];

  @override
  void initState() {
    super.initState();
    if (widget.proTheme.sub_kits != null) {
      list.addAll(widget.proTheme.sub_kits);
    }
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Observer(
      builder: (_) => Scaffold(
        appBar: appBar(
          context,
          widget.proTheme.title_name ?? widget.proTheme.name,
          actions: [
            Tooltip(
              message: 'Dark Mode',
              child: Switch(
                value: appStore.isDarkModeOn,
                activeColor: appColorPrimary,
                onChanged: (s) {
                  appStore.toggleDarkMode(value: s);
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 80),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(16),
                child: widget.proTheme.show_cover ? Image.asset(app_bg_cover_image, height: height / 4) : null,
              ),
              ThemeList(list),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/defaultTheme/model/DTChatMessageModel.dart';
import 'package:prokit_flutter/main/utils/AppColors.dart';
import 'package:prokit_flutter/main/utils/AppWidget.dart';

import '../../main.dart';

Widget priceWidget(int price, {bool applyStrike = false, double fontSize, Color textColor}) {
  return Text(
    applyStrike ? '$price' : '\$$price',
    style: TextStyle(
      decoration: applyStrike ? TextDecoration.lineThrough : TextDecoration.none,
      color: textColor != null
          ? textColor
          : applyStrike
              ? appStore.textSecondaryColor
              : appStore.textPrimaryColor,
      fontSize: fontSize != null
          ? fontSize
          : applyStrike
              ? 15
              : 18,
      fontWeight: FontWeight.bold,
    ),
  );
}

class DotIndicator extends StatefulWidget {
  static String tag = '/DotIndicator';
  final List<Widget> pages;
  var selectedIndex = 0;
  Color indicatorColor;
  final Function onDotTap;

  DotIndicator({@required this.pages, this.selectedIndex, this.indicatorColor, this.onDotTap});

  @override
  DotIndicatorState createState() => DotIndicatorState();
}

class DotIndicatorState extends State<DotIndicator> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: widget.pages.asMap().entries.map((entry) {
          int idx = entry.key;

          return AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: 10,
            width: widget.selectedIndex == idx ? 20 : 10,
            margin: EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(16),
              color: widget.selectedIndex == idx ? widget.indicatorColor ?? white : Colors.transparent,
              border: Border.all(color: widget.indicatorColor ?? viewLineColor),
            ),
          ).onTap(() {
            widget.onDotTap(idx);
          });
        }).toList(),
      ),
    );
  }
}

Widget dot() {
  return Container(
    height: 7,
    width: 7,
    decoration: BoxDecoration(color: Colors.black12, shape: BoxShape.circle),
  );
}

Gradient defaultThemeGradient() {
  return LinearGradient(
    colors: [
      appColorPrimary,
      appColorPrimary.withOpacity(0.5),
    ],
    tileMode: TileMode.mirror,
    begin: Alignment.topCenter,
    end: Alignment.bottomLeft,
  );
}

Widget errorWidget(BuildContext context, String image, String title, String desc, {bool showRetry = false, Function onRetry}) {
  return Container(
    constraints: dynamicBoxConstraints(),
    height: context.height(),
    child: Stack(
      children: [
        Image.asset(
          image,
          height: context.height(),
          width: context.width(),
          fit: BoxFit.fitWidth,
        ),
        Positioned(
          bottom: 50,
          left: 20,
          right: 20,
          child: Container(
            decoration: boxDecorationRoundedWithShadow(8, backgroundColor: appStore.isDarkModeOn ? Colors.black26 : Colors.white70),
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title, style: boldTextStyle(size: 24)),
                4.height,
                Text(desc, style: secondaryTextStyle(size: 14), textAlign: TextAlign.center).paddingOnly(left: 20, right: 20),
                Column(
                  children: [
                    30.height,
                    RaisedButton(
                      onPressed: () {
                        onRetry();
                      },
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      color: white,
                      child: Text('RETRY', style: primaryTextStyle(color: textPrimaryColor)),
                    )
                  ],
                ).visible(showRetry),
              ],
            ),
          ),
        )
      ],
    ),
  ).center();
}

Widget totalItemCountWidget(int count) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text('Total Items', style: boldTextStyle()),
      Text('$count items', style: boldTextStyle()),
    ],
  );
}

Widget totalAmountWidget(int subTotal, int shippingCharges, int totalAmount) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Sub Total', style: boldTextStyle(size: 18)),
          priceWidget(subTotal),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Shipping Charges', style: boldTextStyle(size: 18)),
          priceWidget(shippingCharges),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Total Amount', style: boldTextStyle(size: 18)),
          priceWidget(totalAmount),
        ],
      ),
      20.height,
    ],
  );
}

class ChatMessageWidget extends StatelessWidget {
  const ChatMessageWidget({
    Key key,
    @required this.isMe,
    @required this.data,
  }) : super(key: key);

  final bool isMe;
  final DTChatMessageModel data;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: isMe.validate() ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
          margin: isMe.validate()
              ? EdgeInsets.only(top: 3.0, bottom: 3.0, right: 0, left: (dynamicWidth(context) * 0.25).toDouble())
              : EdgeInsets.only(top: 4.0, bottom: 4.0, left: 0, right: (dynamicWidth(context) * 0.25).toDouble()),
          decoration: BoxDecoration(
            color: !isMe ? appColorPrimary : appStore.appBarColor,
            boxShadow: defaultBoxShadow(),
            borderRadius: isMe.validate()
                ? BorderRadius.only(bottomLeft: Radius.circular(10), topLeft: Radius.circular(10), bottomRight: Radius.circular(0), topRight: Radius.circular(10))
                : BorderRadius.only(bottomLeft: Radius.circular(0), topLeft: Radius.circular(10), bottomRight: Radius.circular(10), topRight: Radius.circular(10)),
            border: Border.all(color: isMe ? Theme.of(context).dividerColor : Colors.transparent),
          ),
          child: Column(
            crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(child: Text(data.msg, style: primaryTextStyle(color: !isMe ? white : appStore.textPrimaryColor))),
              Text(data.time, style: secondaryTextStyle(color: !isMe ? white : appStore.textSecondaryColor, size: 12))
            ],
          ),
        ),
      ],
    );
  }
}

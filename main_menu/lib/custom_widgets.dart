import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MenuEntry extends StatelessWidget {
  final BuildContext context;
  final String label;
  final String iconName;
  final int entryIndex;
  final Function changePage;
  final Function isHighLighted;
  final Widget correspondingWidget;

  MenuEntry(
      {Key key,
      this.context,
      this.label,
      this.iconName,
      this.entryIndex,
      this.changePage,
      this.isHighLighted,
      this.correspondingWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          changePage(entryIndex, correspondingWidget);
        },
        child: Container(
          margin: EdgeInsets.all(3.0),
          decoration: BoxDecoration(
              color: (isHighLighted(entryIndex) == true
                  ? Colors.blueGrey[700]
                  : Colors.blueGrey[800]),
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          child: Row(
            children: [
              Container(
                child: SvgPicture.asset(iconName),
                margin: EdgeInsets.all(5.0),
              ),
              Text(label, style: Theme.of(context).textTheme.headline3),
            ],
          ),
        ));
  }
}

class CustomTitle extends StatelessWidget {
  final Function openMenuFunction;
  final String title;

  const CustomTitle({Key key, this.openMenuFunction, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
          margin: EdgeInsets.all(2.0),
          child: InkWell(
            child: Icon(Icons.menu),
            onTap: openMenuFunction,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          )),
      Expanded(
          child: Center(
              child: Text(title, style: Theme.of(context).textTheme.headline2)))
    ]);
  }
}

class ExchangeRateEntry extends StatelessWidget {
  final String fullName;
  final String code;
  final double bid;
  final double ask;

  const ExchangeRateEntry(
      {Key key, this.fullName, this.code, this.bid, this.ask})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(3.0),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: (Colors.blueGrey[800]),
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        child: Row(children: [
          Text(code.toUpperCase(),
              style: Theme.of(context).textTheme.headline2),
          Expanded(
              child: Center(
            child: Row(
              children: [
                Text(ask.toString(),
                    style: Theme.of(context).textTheme.headline2),
                Icon(
                  Icons.swap_horizontal_circle,
                  color: Colors.brown[50],
                ),
                Text(bid.toString(),
                    style: Theme.of(context).textTheme.headline2)
              ],
            ),
          ))
        ]));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MenuEntry extends StatefulWidget {
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
  _MenuEntryState createState() => _MenuEntryState();
}

class _MenuEntryState extends State<MenuEntry> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          widget.changePage(widget.entryIndex, widget.correspondingWidget);
        },
        child: Container(
          margin: EdgeInsets.all(3.0),
          decoration: BoxDecoration(
              color: (widget.isHighLighted(widget.entryIndex) == true
                  ? Colors.blueGrey[700]
                  : Colors.blueGrey[800]),
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          child: Row(
            children: [
              Container(
                child: SvgPicture.asset(widget.iconName),
                margin: EdgeInsets.all(5.0),
              ),
              Text(widget.label, style: Theme.of(context).textTheme.headline2),
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
      Text(title)
    ]);
  }
}
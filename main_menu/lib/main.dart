import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'currency_page.dart';
import 'unit_page.dart';
import 'options_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unit Currency Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          headline1: TextStyle(
              fontSize: 36.0,
              fontFamily: 'Sans',
              fontWeight: FontWeight.w300,
              color: Colors.brown[50]),
          headline2: TextStyle(
              fontSize: 24.0,
              fontFamily: 'Sans',
              fontWeight: FontWeight.w200,
              color: Colors.brown[50]),
        ),
      ),
      home: MainMenu(title: 'Unit Currency Converter'),
    );
  }
}

class MainMenu extends StatefulWidget {
  MainMenu({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> with TickerProviderStateMixin {
  List<bool> highLightedButton = List.filled(3, false);
  Widget currentPage;

  void changePage(int index, Widget newTopWidget) {
    if (highLightedButton[index] == true) return;

    setState(() {
      currentPage = Container(
        width: 200,
        height: 200,
        child: newTopWidget,
      );

      for (int i = 0; i < highLightedButton.length; i++)
        highLightedButton[i] = false;
      highLightedButton[index] = true;
    });
  }

  bool isHighLighted(int index) => highLightedButton[index];

  @override
  void initState() {
    changePage(0, UnitConverterPage());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Scaffold(
          backgroundColor: Colors.blueGrey[900],
          body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset("svg/logo_circlecompass.svg"),
                Container(
                    margin: EdgeInsets.fromLTRB(0.0, 20.0, 50.0, 50.0),
                    child: Text(
                      "Konwenter definiowalnych miar i walut",
                      style: Theme.of(context).textTheme.headline1,
                    )),
                MenuEntry(
                    context: context,
                    label: "Konwerter Miar",
                    iconName: "svg/unit_speedometer.svg",
                    entryIndex: 0,
                    isHighLighted: isHighLighted,
                    changePage: changePage,
                    correspondingWidget: UnitConverterPage()),
                MenuEntry(
                    context: context,
                    label: "Konwerter Walut",
                    iconName: "svg/currency_money.svg",
                    entryIndex: 1,
                    isHighLighted: isHighLighted,
                    changePage: changePage,
                    correspondingWidget: CurrencyConverterPage()),
                MenuEntry(
                    context: context,
                    label: "Opcje",
                    iconName: "svg/options_paintroller.svg",
                    entryIndex: 2,
                    isHighLighted: isHighLighted,
                    changePage: changePage,
                    correspondingWidget: OptionsrPage()),
              ])),
      currentPage
    ]);
  }
}

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

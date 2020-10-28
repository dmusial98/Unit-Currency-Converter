import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'currency_page.dart';
import 'unit_page.dart';

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

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    List<bool> isSelected = [false, false, false];
    return Stack(
      children: <Widget>[
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
              RotatedBox(
                quarterTurns: 1,
                child: ToggleButtons(
                    borderWidth: 0.0,
                    borderColor: Colors.blueGrey[900],
                    children: <Widget>[
                      RotatedBox(
                          quarterTurns: 3,
                          child: MenuEntry(
                              context: context,
                              label: "Konwerter Miar",
                              iconName: "svg/unit_speedometer.svg")),
                      RotatedBox(
                          quarterTurns: 3,
                          child: MenuEntry(
                              context: context,
                              label: "Konwerter Walut",
                              iconName: "svg/currency_money.svg")),
                      RotatedBox(
                          quarterTurns: 3,
                          child: MenuEntry(
                              context: context,
                              label: "Opcje",
                              iconName: "svg/options_paintroller.svg")),
                    ],
                    isSelected: isSelected,
                    onPressed: (int index) {
                      setState(() {
                        isSelected.map((e) => e = false);
                        isSelected[index] = true;
                      });
                    }),
              ),
            ],
          ),
        ),
        // Container(
        //   width: 200,
        //   height: 200,
        //   child: UnitConverterPage(),
        // )
      ],
    );
  }
}

class MenuEntry extends StatefulWidget {
  final BuildContext context;
  final String label;
  final String iconName;

  const MenuEntry({Key key, this.context, this.label, this.iconName})
      : super(key: key);

  @override
  _MenuEntryState createState() => _MenuEntryState();
}

class _MenuEntryState extends State<MenuEntry> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(3.0),
      decoration: BoxDecoration(
          color: Colors.blueGrey[800],
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
    );
  }
}

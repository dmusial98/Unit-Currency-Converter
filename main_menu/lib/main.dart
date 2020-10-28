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
  List<bool> isSelected = List<bool>(3);

  void setOneSelected(int index) {
    for (int i = 0; i < isSelected.length; i++) isSelected[i] = false;
    isSelected[index] = true;
  }

  @override
  Widget build(BuildContext context) {
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
              GestureDetector(
                  onTap: () {
                    setState(() {
                      setOneSelected(0);
                    });
                  },
                  child: MenuEntry(
                      context: context,
                      label: "Konwerter Miar",
                      iconName: "svg/unit_speedometer.svg",
                      isSelected: isSelected[0])),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      setOneSelected(1);
                    });
                  },
                  child: MenuEntry(
                      context: context,
                      label: "Konwerter Walut",
                      iconName: "svg/currency_money.svg",
                      isSelected: isSelected[1])),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      setOneSelected(2);
                    });
                  },
                  child: MenuEntry(
                      context: context,
                      label: "Opcje",
                      iconName: "svg/options_paintroller.svg",
                      isSelected: isSelected[2])),
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
  final bool isSelected;

  MenuEntry({Key key, this.context, this.label, this.iconName, this.isSelected})
      : super(key: key);

  @override
  _MenuEntryState createState() => _MenuEntryState();
}

class _MenuEntryState extends State<MenuEntry> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(3.0),
      decoration: BoxDecoration(
          color: (Colors.blueGrey[widget.isSelected ? 700 : 800]),
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

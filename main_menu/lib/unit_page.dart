import 'package:flutter/material.dart';

class UnitConverterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Home());
  }
}

class Home extends StatelessWidget {
  final unitType = [_TabContent(UnitType.weight), _TabContent(UnitType.length)];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: unitType.length,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.blueGrey[900],
            automaticallyImplyLeading: false,
            title: Text("Konwerter Miar"),
            bottom: TabBar(
              isScrollable: true,
              tabs: [for (final tab in unitType) Tab(text: tab.title)],
            ),
          ),
          body: TabBarView(
            children: [
              for (final tab in unitType)
                Container(
                  child: tab.getContent(),
                )
            ],
          )),
    );
  }
}

class _TabContent {
  UnitType unitType;
  String title;
  List<_UnitMeasure> unitsMeasure = new List<_UnitMeasure>();
  StatelessWidget content;

  _TabContent(this.unitType) {
    if (this.unitType == UnitType.weight) {
      title = "Masa";
      this.unitsMeasure.add(_UnitMeasure("kilogram", UnitType.weight, "kg"));
      this.unitsMeasure.add(new _UnitMeasure("gram", UnitType.weight, "g"));
      this.unitsMeasure.add(new _UnitMeasure("dekagram", UnitType.weight, "dag"));
      this.unitsMeasure.add(new _UnitMeasure("miligram", UnitType.weight, "mg"));
      this.unitsMeasure.add(new _UnitMeasure("funt", UnitType.weight, "lb"));
      this.unitsMeasure.add(new _UnitMeasure("uncja", UnitType.weight, "oz"));
      this.unitsMeasure.add(new _UnitMeasure("tona", UnitType.weight, "t"));
      this.unitsMeasure.add(new _UnitMeasure("kwintal", UnitType.weight, "q"));
      this.unitsMeasure.add(new _UnitMeasure("unit (jedn. masy atomowej)", UnitType.weight, "u"));
      this.unitsMeasure.add(new _UnitMeasure("karat", UnitType.weight, "ct"));
      this.unitsMeasure.add(new _UnitMeasure("Jednostka", UnitType.weight, "jed"));
      this.unitsMeasure.add(new _UnitMeasure("Jednostka", UnitType.weight, "jed"));
      this.unitsMeasure.add(new _UnitMeasure("Jednostka", UnitType.weight, "jed"));
      this.unitsMeasure.add(new _UnitMeasure("Jednostka", UnitType.weight, "jed"));
      this.unitsMeasure.add(new _UnitMeasure("Jednostka", UnitType.weight, "jed"));
      this.unitsMeasure.add(new _UnitMeasure("Jednostka", UnitType.weight, "jed"));
      this.unitsMeasure.add(new _UnitMeasure("Jednostka", UnitType.weight, "jed"));
    } else if (this.unitType == UnitType.length) {
      title = "Długość";
      unitsMeasure.add(new _UnitMeasure("metr", UnitType.length, "m"));
      unitsMeasure.add(new _UnitMeasure("kilometr", UnitType.length, "km"));
      unitsMeasure.add(new _UnitMeasure("decymetr", UnitType.length, "dm"));
      unitsMeasure.add(new _UnitMeasure("centymetr", UnitType.length, "cm"));
      unitsMeasure.add(new _UnitMeasure("milimetr", UnitType.length, "mm"));
      unitsMeasure.add(new _UnitMeasure("mila morska", UnitType.length, "INM"));
      unitsMeasure.add(new _UnitMeasure("mila angielska", UnitType.length, "LM"));
      unitsMeasure.add(new _UnitMeasure("łokieć", UnitType.length, "ell"));
      unitsMeasure.add(new _UnitMeasure("stopa", UnitType.length, "ft"));
      unitsMeasure.add(new _UnitMeasure("jard", UnitType.length, "yd"));
      this.unitsMeasure.add(new _UnitMeasure("Jednostka", UnitType.length, "jed"));
      this.unitsMeasure.add(new _UnitMeasure("Jednostka", UnitType.length, "jed"));
      this.unitsMeasure.add(new _UnitMeasure("Jednostka", UnitType.length, "jed"));
      this.unitsMeasure.add(new _UnitMeasure("Jednostka", UnitType.length, "jed"));
      this.unitsMeasure.add(new _UnitMeasure("Jednostka", UnitType.length, "jed"));
      this.unitsMeasure.add(new _UnitMeasure("Jednostka", UnitType.length, "jed"));
      this.unitsMeasure.add(new _UnitMeasure("Jednostka", UnitType.length, "jed"));
    }
  }

  StatelessWidget getContent() {
    return Container(
      color: Colors.blueGrey[900],
      child: Scrollbar(
        //TODO: dopisac zawartosc ListView
        child: ListView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      children: [
        for (final unit in unitsMeasure)
          ListTile(
            leading: ExcludeSemantics(
              child: CircleAvatar(child: Text(unit.abbreviation),
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,)
            ),

            title: Text(
              unit.name,
              style: TextStyle(
                  fontSize: 24.0,
                  fontFamily: 'Sans',
                  fontWeight: FontWeight.w500,
                  color: Colors.brown[50]),
            ),
            tileColor: Colors.blueGrey[800],
          )
      ],
    )));
  }
}

class _UnitMeasure {
  String name;
  String abbreviation;
  UnitType type;

  _UnitMeasure(this.name, this.type, this.abbreviation);
}

enum UnitType { weight, length }

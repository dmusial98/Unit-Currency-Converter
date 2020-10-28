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
      this.unitsMeasure.add(_UnitMeasure("kilogram", UnitType.weight));
      this.unitsMeasure.add(new _UnitMeasure("gram", UnitType.weight));
      this.unitsMeasure.add(new _UnitMeasure("dekagram", UnitType.weight));
      this.unitsMeasure.add(new _UnitMeasure("miligram", UnitType.weight));
      this.unitsMeasure.add(new _UnitMeasure("funt", UnitType.weight));
      this.unitsMeasure.add(new _UnitMeasure("uncja", UnitType.weight));
      this.unitsMeasure.add(new _UnitMeasure("tona", UnitType.weight));
      this.unitsMeasure.add(new _UnitMeasure("kwintal", UnitType.weight));
      this.unitsMeasure.add(new _UnitMeasure("junit", UnitType.weight));
      this.unitsMeasure.add(new _UnitMeasure("karat", UnitType.weight));
      this.unitsMeasure.add(new _UnitMeasure("Jednostka", UnitType.weight));
      this.unitsMeasure.add(new _UnitMeasure("Jednostka", UnitType.weight));
      this.unitsMeasure.add(new _UnitMeasure("Jednostka", UnitType.weight));
      this.unitsMeasure.add(new _UnitMeasure("Jednostka", UnitType.weight));
      this.unitsMeasure.add(new _UnitMeasure("Jednostka", UnitType.weight));
      this.unitsMeasure.add(new _UnitMeasure("Jednostka", UnitType.weight));
      this.unitsMeasure.add(new _UnitMeasure("Jednostka", UnitType.weight));
    } else if (this.unitType == UnitType.length) {
      title = "Długość";
      unitsMeasure.add(new _UnitMeasure("metr", UnitType.length));
      unitsMeasure.add(new _UnitMeasure("kilometr", UnitType.length));
      unitsMeasure.add(new _UnitMeasure("decymetr", UnitType.length));
      unitsMeasure.add(new _UnitMeasure("centymetr", UnitType.length));
      unitsMeasure.add(new _UnitMeasure("milimetr", UnitType.length));
      unitsMeasure.add(new _UnitMeasure("mila morska", UnitType.length));
      unitsMeasure.add(new _UnitMeasure("mila lądowa", UnitType.length));
      unitsMeasure.add(new _UnitMeasure("łokieć", UnitType.length));
      unitsMeasure.add(new _UnitMeasure("stopa", UnitType.length));
      unitsMeasure.add(new _UnitMeasure("jard", UnitType.length));
      this.unitsMeasure.add(new _UnitMeasure("Jednostka", UnitType.length));
      this.unitsMeasure.add(new _UnitMeasure("Jednostka", UnitType.length));
      this.unitsMeasure.add(new _UnitMeasure("Jednostka", UnitType.length));
      this.unitsMeasure.add(new _UnitMeasure("Jednostka", UnitType.length));
      this.unitsMeasure.add(new _UnitMeasure("Jednostka", UnitType.length));
      this.unitsMeasure.add(new _UnitMeasure("Jednostka", UnitType.length));
      this.unitsMeasure.add(new _UnitMeasure("Jednostka", UnitType.length));
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
            //TODO: Ogarnąć później ikonę
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
  String skrot;
  UnitType type;

  _UnitMeasure(this.name, this.type);
}

enum UnitType { weight, length }

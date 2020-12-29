import 'package:flutter/material.dart';
import 'package:main_menu/database/unit_measure_db/unit_measure_dao.dart';
import 'package:main_menu/database/unit_measure_db/unit_measure_db.dart';
import 'package:main_menu/database/unit_type_db/unit_type_dao.dart';
import 'package:main_menu/database/unit_type_db/unit_type_db.dart';

class AddUnitsPage extends StatefulWidget {
  final UnitMeasureDao unitMeasureDao;
  final UnitTypeDao unitTypeDao;
  final List<List<UnitMeasureDB>> unitsMeasure;
  final List<UnitTypeDB> unitTypes;

  const AddUnitsPage(
      {Key key,
        this.unitMeasureDao,
        this.unitTypeDao,
        this.unitsMeasure,
        this.unitTypes})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AddUnitsPageState(this.unitMeasureDao, this.unitTypeDao,
        this.unitsMeasure, this.unitTypes);
  }
}

class _AddUnitsPageState extends State<AddUnitsPage> {
  final UnitMeasureDao unitMeasureDao;
  final UnitTypeDao unitTypeDao;
  final List<List<UnitMeasureDB>> unitsMeasure;
  final List<UnitTypeDB> unitTypes;

  var typeIndex = 0;
  var measureIndex = 0;
  var baseMeasureIndex = 0;

  String newUnitName;
  String newUnitAbbreviation;
  String newUnitEquation;
  String newReversedUnitEquation;

  List<DropdownMenuItem<int>> typeDDMI = new List<DropdownMenuItem<int>>();

  TextEditingController nameController = new TextEditingController();
  TextEditingController abbreviationController = new TextEditingController();
  TextEditingController equationController = new TextEditingController();
  TextEditingController reversedEquationController = new TextEditingController();

  final TextStyle mainStyle = new TextStyle(
      fontSize: 18.0,
      fontFamily: 'Sans',
      fontWeight: FontWeight.w300,
      color: Colors.brown[50]);

  _AddUnitsPageState(
      this.unitMeasureDao, this.unitTypeDao, this.unitsMeasure, this.unitTypes);

  @override
  void initState() {
    super.initState();
    _changeType ();
    nameController.addListener(() {
      newUnitName = nameController.text;
    });
    abbreviationController.addListener(() {
      newUnitAbbreviation = abbreviationController.text;
    });
    equationController.addListener(() {
      newUnitEquation = equationController.text;
    });
    reversedEquationController.addListener(() {
      newReversedUnitEquation = reversedEquationController.text;
    });
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    abbreviationController.dispose();
    equationController.dispose();
  }

  _changeType () {
    typeDDMI.clear();
    // baseMeasureDDMI.clear();
    // measureDDMI.clear();

    unitTypes
        .map((e) => typeDDMI.add(new DropdownMenuItem<int>(
        value: typeDDMI.length,
        child: new Text(e.name,
            style: mainStyle))))
        .toList();

    typeDDMI.add(new DropdownMenuItem(
        value: typeDDMI.length,
        child: new Text("Dodaj typ jednostki",
            style: mainStyle)));
  }

  _addUnit() {
    unitsMeasure[typeIndex].add(UnitMeasureDB(
        null,
        newUnitName,
        newUnitAbbreviation,
        typeIndex + 1,
        newUnitEquation,
        newReversedUnitEquation,
        0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
          backgroundColor: Colors.blueGrey[900],
          title: Text("Dodaj jednostkę/kategorię",
              style: Theme.of(context).textTheme.headline2)),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Kategoria jednostek: ",
                  style: Theme.of(context).textTheme.headline4),
              DropdownButton<int>(
                items: typeDDMI,
                dropdownColor: Colors.blueGrey[800],
                icon: Icon(Icons.keyboard_arrow_down),
                value: typeDDMI[typeIndex].value,
                onChanged: (newIndex) {
                  setState(() {
                    typeIndex = newIndex;
                  });
                },
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Nazwa jednostki: ", style: Theme.of(context).textTheme.headline4),
              Expanded(
                  child: TextField(
                      controller: nameController,
                      style: Theme.of(context).textTheme.headline4
                  ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Skrót jednostki: ", style: Theme.of(context).textTheme.headline4),
              Expanded(
                  child: TextField(
                      controller: abbreviationController,
                      style: Theme.of(context).textTheme.headline4
                  ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Równanie: ", style: Theme.of(context).textTheme.headline4),
              Expanded(
                  child: TextField(
                      controller: equationController,
                      style: Theme.of(context).textTheme.headline4
                  ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Pomocnicze równanie: ", style: Theme.of(context).textTheme.headline4),
              Expanded(
                  child: TextField(
                      controller: reversedEquationController,
                      style: Theme.of(context).textTheme.headline4
                  ))
            ],
          )
        ],
      ),
      bottomNavigationBar: ButtonBar(
        alignment: MainAxisAlignment.center,
        children: [
          RaisedButton(
              color: Colors.blue[700],
              onPressed: () {
                _addUnit();
              },
              child: Text('Dodaj jednostkę',
                  style: Theme.of(context).textTheme.headline4)),
          RaisedButton(
              color: Colors.blue[700],
              onPressed: () {},
              child: Text('Dodaj kategorię',
                  style: Theme.of(context).textTheme.headline4)),
        ],
      ),
    );
  }
}
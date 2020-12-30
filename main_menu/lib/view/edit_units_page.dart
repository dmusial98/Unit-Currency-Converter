import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:main_menu/database/unit_measure_db/unit_measure_dao.dart';
import 'package:main_menu/database/unit_measure_db/unit_measure_db.dart';
import 'package:main_menu/database/unit_type_db/unit_type_dao.dart';
import 'package:main_menu/database/unit_type_db/unit_type_db.dart';
import 'package:main_menu/view/add_units_page.dart';

class EditUnitsPage extends StatefulWidget {
  final UnitMeasureDao unitMeasureDao;
  final UnitTypeDao unitTypeDao;
  final List<List<UnitMeasureDB>> unitsMeasure;
  final List<UnitTypeDB> unitTypes;

  const EditUnitsPage(
      {Key key,
      this.unitMeasureDao,
      this.unitTypeDao,
      this.unitsMeasure,
      this.unitTypes})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _EditUnitsPageState(this.unitMeasureDao, this.unitTypeDao,
        this.unitsMeasure, this.unitTypes);
  }
}

class _EditUnitsPageState extends State<EditUnitsPage> {
  final UnitMeasureDao unitMeasureDao;
  final UnitTypeDao unitTypeDao;
  final List<List<UnitMeasureDB>> unitsMeasure;
  final List<UnitTypeDB> unitTypes;

  var typeIndex = 0;
  var measureIndex = 0;
  var baseMeasureIndex = 0;

  String newUnitName = "";
  String newUnitAbbreviation = "";
  String newUnitEquation = "";
  String newReversedUnitEquation = "";

  List<DropdownMenuItem<int>> measureDDMI = new List<DropdownMenuItem<int>>();
  List<DropdownMenuItem<int>> baseMeasureDDMI =
      new List<DropdownMenuItem<int>>();
  List<DropdownMenuItem<int>> typeDDMI = new List<DropdownMenuItem<int>>();

  TextEditingController nameController = new TextEditingController();
  TextEditingController abbreviationController = new TextEditingController();
  TextEditingController equationController = new TextEditingController();
  TextEditingController reversedEquationController =
      new TextEditingController();

  final TextStyle mainStyle = new TextStyle(
      fontSize: 18.0,
      fontFamily: 'Sans',
      fontWeight: FontWeight.w300,
      color: Colors.brown[50]);

  _EditUnitsPageState(
      this.unitMeasureDao, this.unitTypeDao, this.unitsMeasure, this.unitTypes);

  @override
  void initState() {
    super.initState();
    _changeType();
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

    _fillEditFields();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    abbreviationController.dispose();
    equationController.dispose();
  }

  _fillEditFields() {
    var unit = unitsMeasure[typeIndex][measureIndex];
    nameController.text = unit.name;
    abbreviationController.text = unit.abbreviation;
    equationController.text = unit.equation;
    reversedEquationController.text = unit.equationReversed;

    newUnitName = unit.name;
    newUnitAbbreviation = unit.abbreviation;
    newUnitEquation = unit.equation;
    newReversedUnitEquation = unit.equationReversed;
  }

  _changeType() {
    typeDDMI.clear();
    baseMeasureDDMI.clear();
    measureDDMI.clear();

    unitTypes
        .map((e) => typeDDMI.add(new DropdownMenuItem<int>(
            value: typeDDMI.length,
            child: new Text(e.name,
                style: mainStyle, textAlign: TextAlign.right))))
        .toList();
    unitsMeasure[typeIndex]
        .map((e) => measureDDMI.add(new DropdownMenuItem<int>(
            value: measureDDMI.length,
            child: new Text(e.name,
                style: mainStyle, textAlign: TextAlign.right))))
        .toList();

    measureDDMI.map((e) => baseMeasureDDMI.add(e)).toList();
  }

  _updateUnit() async {
    if (newUnitAbbreviation.isEmpty || newUnitName.isEmpty || newUnitEquation.isEmpty || newReversedUnitEquation.isEmpty) {
      Fluttertoast.showToast(
          msg: "Żadne pole nie może pozostać puste.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER);
      return;
    }

    for (int i = 0; i < unitsMeasure[typeIndex].length; i++) {
      unitsMeasure[typeIndex][i].equation = unitsMeasure[typeIndex][i]
          .equation
          .replaceFirst(unitsMeasure[typeIndex][measureIndex].abbreviation,
              newUnitAbbreviation);
      unitsMeasure[typeIndex][i].equationReversed = unitsMeasure[typeIndex][i]
          .equationReversed
          .replaceFirst(unitsMeasure[typeIndex][measureIndex].abbreviation,
              newUnitAbbreviation);
    }

    unitsMeasure[typeIndex][measureIndex].name = newUnitName;
    unitsMeasure[typeIndex][measureIndex].abbreviation = newUnitAbbreviation;
    unitsMeasure[typeIndex][measureIndex].equation = newUnitEquation;
    unitsMeasure[typeIndex][measureIndex].equationReversed =
        newReversedUnitEquation;

    await unitMeasureDao.updateUnitMeasure(UnitMeasureDB(
        unitsMeasure[typeIndex][measureIndex].id,
        newUnitName,
        newUnitAbbreviation,
        unitsMeasure[typeIndex][measureIndex].type,
        newUnitEquation,
        newReversedUnitEquation,
        unitsMeasure[typeIndex][measureIndex].lastComputedValue));

    Fluttertoast.showToast(
        msg: "Zaktualizowano jednostkę.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER);
  }

  _deleteUnit() async {
    await unitMeasureDao.deleteUnitMeasure(UnitMeasureDB(
        unitsMeasure[typeIndex][measureIndex].id,
        unitsMeasure[typeIndex][measureIndex].name,
        unitsMeasure[typeIndex][measureIndex].abbreviation,
        unitsMeasure[typeIndex][measureIndex].type,
        unitsMeasure[typeIndex][measureIndex].equation,
        unitsMeasure[typeIndex][measureIndex].equationReversed,
        unitsMeasure[typeIndex][measureIndex].lastComputedValue));

    unitsMeasure[typeIndex].removeAt(measureIndex);

    Fluttertoast.showToast(
        msg: "Usunięto jednostkę.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER);
  }

  _deleteUnitType() async {
    for (final unit in unitsMeasure[typeIndex])
      await unitMeasureDao.deleteUnitMeasure(UnitMeasureDB(
          unit.id,
          unit.name,
          unit.abbreviation,
          unit.type,
          unit.equation,
          unit.equationReversed,
          unit.lastComputedValue));

    unitsMeasure[typeIndex].clear();

    await unitTypeDao.deleteUnitType(
        UnitTypeDB(unitTypes[typeIndex].id, unitTypes[typeIndex].name));

    unitsMeasure.removeAt(typeIndex);
    unitTypes.removeAt(typeIndex);

    Fluttertoast.showToast(
        msg: "Usunięto typ jednostki.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER);
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => AddUnitsPage(
          unitMeasureDao: this.unitMeasureDao,
          unitTypeDao: this.unitTypeDao,
          unitTypes: this.unitTypes,
          unitsMeasure: this.unitsMeasure),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
          backgroundColor: Colors.blueGrey[900],
          title: Text("Edytuj jednostki",
              style: Theme.of(context).textTheme.headline2)),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(children: [
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
                    _changeType();
                    _fillEditFields();
                  });
                },
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Jednostka: ", style: Theme.of(context).textTheme.headline4),
              DropdownButton<int>(
                dropdownColor: Colors.blueGrey[800],
                items: measureDDMI,
                icon: Icon(Icons.keyboard_arrow_down),
                value: measureDDMI[measureIndex].value,
                onChanged: (newIndex) {
                  setState(() {
                    measureIndex = newIndex;
                    _fillEditFields();
                  });
                },
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Nazwa: ", style: Theme.of(context).textTheme.headline4),
              Expanded(
                  child: TextField(
                      textAlign: TextAlign.right,
                      controller: nameController,
                      style: Theme.of(context).textTheme.headline4))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Skrót: ", style: Theme.of(context).textTheme.headline4),
              Expanded(
                  child: TextField(
                      textAlign: TextAlign.right,
                      controller: abbreviationController,
                      style: Theme.of(context).textTheme.headline4))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Równanie: ", style: Theme.of(context).textTheme.headline4),
              Expanded(
                  child: TextField(
                      textAlign: TextAlign.right,
                      controller: equationController,
                      style: Theme.of(context).textTheme.headline4))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Pomocnicze równanie: ",
                  style: Theme.of(context).textTheme.headline4),
              Expanded(
                  child: TextField(
                      textAlign: TextAlign.right,
                      controller: reversedEquationController,
                      style: Theme.of(context).textTheme.headline4))
            ],
          ),
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical, //.horizontal
                child: Text(
                    "Definicja jednostki składa się z kilku pól. Nazwa jednostki jest dla użytkownika i może być dowolna. Skrót musi składać się z samych liter i być unikalny w danej kategorii. Równanie i równanie pomocnicze to informacja dla aplikacji jakie są zależności między jednostkami. Równanie może mieć postać: \"kg = g / 1000\" Ważne jest aby druga podana jednostka już istniała w aplikacji i jej skrót był otoczony spacjami. Do definicji możliwe jest użycie wszystkich operatorów dostępynch w języku Dart. Równanie pomocnicze pozwala z naszej jednostki obliczyć inną już dostępną w systemie.",
                    style: Theme.of(context).textTheme.headline4)),
          ),
        ]),
      ),
      bottomNavigationBar: ButtonBar(
        alignment: MainAxisAlignment.center,
        children: [
          RaisedButton(
              color: Colors.blue[700],
              onPressed: () {
                setState(() {
                  _updateUnit();
                });
              },
              child: Text('Aktualizuj',
                  style: Theme.of(context).textTheme.headline4)),
          RaisedButton(
              color: Colors.blue[700],
              onPressed: () {
                _deleteUnit();
              },
              child: Text('Usuń jednostkę',
                  style: Theme.of(context).textTheme.headline4)),
          RaisedButton(
              color: Colors.blue[700],
              onPressed: () {
                _deleteUnitType();
              },
              child: Text('Usuń kategorię',
                  style: Theme.of(context).textTheme.headline4)),
          RaisedButton(
              color: Colors.blue[700],
              onPressed: () {
                Navigator.of(context).push(_createRoute());
              },
              child: Text('Dodaj kategorię/jednostkę',
                  style: Theme.of(context).textTheme.headline4)),
        ],
      ),
    );
  }
}

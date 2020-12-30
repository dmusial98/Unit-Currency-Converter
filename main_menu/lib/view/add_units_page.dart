import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  List<List<UnitMeasureDB>> unitsMeasure;
  List<UnitTypeDB> unitTypes;

  var typeIndex = 0;
  var measureIndex = 0;
  var baseMeasureIndex = 0;

  String newUnitName = "";
  String newUnitAbbreviation = "";
  String newUnitEquation = "";
  String newReversedUnitEquation = "";
  String newUnitTypeName = "";

  List<DropdownMenuItem<int>> typeDDMI = new List<DropdownMenuItem<int>>();

  TextEditingController unitNameController = new TextEditingController();
  TextEditingController abbreviationController = new TextEditingController();
  TextEditingController equationController = new TextEditingController();
  TextEditingController reversedEquationController = new TextEditingController();
  TextEditingController unitTypeNameController = new TextEditingController();

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
    unitNameController.addListener(() {
      newUnitName = unitNameController.text;
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
    unitTypeNameController.addListener(() {
      newUnitTypeName = unitTypeNameController.text;
    });
  }

  @override
  void dispose() {
    super.dispose();
    unitNameController.dispose();
    abbreviationController.dispose();
    equationController.dispose();
    reversedEquationController.dispose();
    unitTypeNameController.dispose();
  }

  _changeType () {
    typeDDMI.clear();

    unitTypes
        .map((e) => typeDDMI.add(new DropdownMenuItem<int>(
        value: typeDDMI.length,
        child: new Text(e.name,
            style: mainStyle))))
        .toList();
  }

  int _getLastUnitId() {
    int lastId = 0;

    for(final unitType in unitsMeasure)
      for(final unit in unitType)
        if(lastId < unit.id)
          lastId = unit.id;

        return lastId;
  }

  _addUnit() async {
    if (newUnitAbbreviation.isEmpty || newUnitEquation.isEmpty || newReversedUnitEquation.isEmpty) {
      Fluttertoast.showToast(
          msg: "Żadne pole nowej jednostki nie może być puste.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER);
      return;
    }

    await unitMeasureDao.insertUnitMeasure(UnitMeasureDB(
        null,
        newUnitName,
        newUnitAbbreviation,
        unitTypes[typeIndex].id,
        newUnitEquation,
        newReversedUnitEquation,
        0));

    unitsMeasure[typeIndex].add(UnitMeasureDB(
        _getLastUnitId() + 1,
        newUnitName,
        newUnitAbbreviation,
        unitTypes[typeIndex].id,
        newUnitEquation,
        newReversedUnitEquation,
        0));

    Fluttertoast.showToast(
        msg: "Dodano jednostkę $newUnitName.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER);
  }

  _addUnitType() async {
    if (newUnitTypeName.isEmpty) {
      Fluttertoast.showToast(
          msg: "Nazwa nowej jednostki nie może być pusta.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER);
      return;
    }

    await unitTypeDao.insertUnitType(UnitTypeDB(
        unitTypes.last.id + 1,
        newUnitTypeName));

    unitTypes.add(UnitTypeDB(unitTypes.last.id + 1, newUnitTypeName));
    unitsMeasure.add(List<UnitMeasureDB>());

    Fluttertoast.showToast(
        msg: "Dodano kategorię $newUnitTypeName.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER);
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
          Padding(
            padding: EdgeInsets.only(bottom: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Nazwa nowej kategorii: ", style: Theme.of(context).textTheme.headline4),
                Expanded(
                    child: TextField(
                        controller: unitTypeNameController,
                        style: Theme.of(context).textTheme.headline4
                    ))
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Kategoria nowej jednostki: ",
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
              Text("Nazwa nowej jednostki: ", style: Theme.of(context).textTheme.headline4),
              Expanded(
                  child: TextField(
                      controller: unitNameController,
                      style: Theme.of(context).textTheme.headline4
                  ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Skrót nowej jednostki: ", style: Theme.of(context).textTheme.headline4),
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
          ),
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical, //.horizontal
                child: Text(
                    "Definicja jednostki składa się z kilku pól. Nazwa jednostki jest dla użytkownika i może być dowolna. Skrót musi składać się z samych liter i być unikalny w danej kategorii. Równanie i równanie pomocnicze to informacja dla aplikacji jakie są zależności między jednostkami. Równanie może mieć postać: \"kg = g / 1000\" Ważne jest aby druga podana jednostka już istniała w aplikacji i jej skrót był otoczony spacjami. Do definicji możliwe jest użycie wszystkich operatorów dostępynch w języku Dart. Równanie pomocnicze pozwala z naszej jednostki obliczyć inną już dostępną w systemie.",
                    style: Theme.of(context).textTheme.headline4)),
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
              onPressed: () {
                _addUnitType();
              },
              child: Text('Dodaj kategorię',
                  style: Theme.of(context).textTheme.headline4)),
        ],
      ),
    );
  }
}

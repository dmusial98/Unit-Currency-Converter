import 'package:flutter/material.dart';
import 'package:main_menu/database/unit_type_db/unit_type_dao.dart';
import 'package:main_menu/database/unit_type_db/unit_type_db.dart';
import 'package:main_menu/view/edit_units_page.dart';
import 'custom_widgets.dart';
import 'package:flutter/cupertino.dart';
import '../database/unit_measure_db/unit_measure_db.dart';
import '../database/unit_measure_db/unit_measure_dao.dart';
import '../unit_converter_model/reorderable_list_item.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';
import 'package:function_tree/function_tree.dart';

class UnitConverterPage extends StatefulWidget {
  final Function openMenuFunction;
  final UnitMeasureDao unitMeasureDao;
  final UnitTypeDao unitTypeDao;

  UnitConverterPage(
      {Key key, this.openMenuFunction, this.unitMeasureDao, this.unitTypeDao})
      : super(key: key);

  @override
  _UnitConverterPageState createState() =>
      _UnitConverterPageState(this.unitMeasureDao, this.unitTypeDao);
}

class _UnitConverterPageState extends State<UnitConverterPage>
    with TickerProviderStateMixin {
  var isLoading = true;
  var tabIndex = 0;
  final UnitMeasureDao unitMeasureDao;
  final UnitTypeDao unitTypeDao;
  List<List<UnitMeasureDB>> unitsMeasure = new List<List<UnitMeasureDB>>();
  List<UnitTypeDB> unitTypes = new List<UnitTypeDB>();
  int indexOfSelectedUnit = 0;
  TabController tabController;
  TextEditingController startValueEditingController;

  _UnitConverterPageState(this.unitMeasureDao, this.unitTypeDao);

  _getData() async {
    unitTypes = await unitTypeDao.getAllUnitTypes();
    for (int i = 1; i <= unitTypes.length; i++)
      unitsMeasure.add(await unitMeasureDao.getUnitsByType(i));

    setState(() {
      isLoading = false;
      _setTabController();
    });
  }

  _setTabController() {
    tabController = new TabController(vsync: this, length: unitTypes.length);
    tabController.addListener(() {
      if (tabController.index != tabController.previousIndex ||
          tabController.indexIsChanging) {
        setState(() {
          tabIndex = tabController.index;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getData();
    _setTabController();
    startValueEditingController = TextEditingController();
    startValueEditingController.text = "1.0";
  }

  int _indexOfKey(Key key) {
    return unitsMeasure[tabIndex]
        .indexWhere((UnitMeasureDB d) => ValueKey(d.id) == key);
  }

  bool _reorderCallback(Key item, Key newPosition) {
    int draggingIndex = _indexOfKey(item);
    int newPositionIndex = _indexOfKey(newPosition);

    final draggedItem = unitsMeasure[tabIndex][draggingIndex];

    setState(() {
      debugPrint("Reordering $item -> $newPosition");
      unitsMeasure[tabIndex].removeAt(draggingIndex);
      unitsMeasure[tabIndex].insert(newPositionIndex, draggedItem);
    });
    return true;
  }

  void _reorderDone(Key item) {
    final draggedItem = unitsMeasure[tabIndex][_indexOfKey(item)];
    debugPrint("Reordering finished for ${draggedItem.name}}");
  }

  _recalculateValues() {
    List<UnitMeasureDB> missingValues, calculatedValues;
    missingValues = new List<UnitMeasureDB>();
    calculatedValues = new List<UnitMeasureDB>();

    unitsMeasure[tabIndex][indexOfSelectedUnit].lastComputedValue =
        double.parse(startValueEditingController.text);

    unitsMeasure[tabIndex].forEach((element) {
      missingValues.add(element);
    });

    missingValues.removeAt(indexOfSelectedUnit);
    calculatedValues.add(unitsMeasure[tabIndex][indexOfSelectedUnit]);

    while (missingValues.isNotEmpty) {
      for (int i = 0; i < missingValues.length; i++) {
        if (_tryCalculateFromEquation(missingValues[i], calculatedValues)) {
          calculatedValues.add(missingValues[i]);
          missingValues.remove(missingValues[i]);
          break;
        }
      }

      for (int i = 0; i < calculatedValues.length; i++) {
        var result = _tryCalculateFromReversedEquation(
            calculatedValues[i], missingValues);
        if (result != null) {
          calculatedValues.add(result);
          missingValues.remove(result);
          break;
        }
      }
    }

    for (int i = 0; i < calculatedValues.length; i++) {
      for (int j = 0; j < unitsMeasure[tabIndex].length; j++) {
        if (calculatedValues[i].id == unitsMeasure[tabIndex][j].id) {
          unitsMeasure[tabIndex][j].lastComputedValue =
              calculatedValues[i].lastComputedValue;
        }
      }
    }
  }

  bool _tryCalculateFromEquation(
      UnitMeasureDB current, List<UnitMeasureDB> calculatedValues) {
    for (int i = 0; i < calculatedValues.length; i++) {
      var equalSignIndex = current.equation.indexOf("=");
      var unitSignIndex = current.equation
          .indexOf(" " + calculatedValues[i].abbreviation + " ");
      if (equalSignIndex < unitSignIndex) {
        var equationBody = current.equation.substring(equalSignIndex + 1);
        equationBody =
            equationBody.replaceAll(calculatedValues[i].abbreviation, "x");
        final equation = equationBody.toSingleVariableFunction();
        current.lastComputedValue =
            equation(calculatedValues[i].lastComputedValue);
        return true;
      }
    }

    return false;
  }

  UnitMeasureDB _tryCalculateFromReversedEquation(
      UnitMeasureDB current, List<UnitMeasureDB> missingValues) {
    for (int i = 0; i < missingValues.length; i++) {
      if (current.equationReversed
          .startsWith(missingValues[i].abbreviation + " ")) {
        var equationBody = current.equationReversed
            .substring(current.equationReversed.indexOf("=") + 1);
        equationBody = equationBody.replaceAll(current.abbreviation, "x");
        final equation = equationBody.toSingleVariableFunction();
        missingValues[i].lastComputedValue =
            equation(current.lastComputedValue);
        return missingValues[i];
      }
    }
    return null;
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => EditUnitsPage(
          unitMeasureDao: this.unitMeasureDao,
          unitTypeDao: this.unitTypeDao,
          unitTypes: this.unitTypes,
          unitsMeasure: this.unitsMeasure),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }

  Widget build(BuildContext context) {
    return isLoading
        ? CircularProgressIndicator()
        : Scaffold(
            backgroundColor: Colors.blueGrey[900],
            appBar: AppBar(
              backgroundColor: Colors.blueGrey[900],
              centerTitle: true,
              automaticallyImplyLeading: false,
              title: CustomTitle(
                  title: "Konwerter Miar",
                  openMenuFunction: widget.openMenuFunction),
              bottom: TabBar(
                isScrollable: false,
                controller: tabController,
                tabs: [
                  for (final unitType in unitTypes) Tab(text: unitType.name)
                ],
              ),
            ),
            body: TabBarView(
              controller: tabController,
              children: [
                for (int i = 0; i < unitTypes.length; i++)
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(top: 25, left: 15),
                            child: Text(
                                unitsMeasure[i][indexOfSelectedUnit].name,
                                style: Theme.of(context).textTheme.headline1)),
                        Padding(
                            padding: EdgeInsets.only(right: 25, top: 40),
                            child: TextField(
                                keyboardType: TextInputType.number,
                                decoration: new InputDecoration(
                                    border: InputBorder.none),
                                controller: startValueEditingController,
                                textAlign: TextAlign.end,
                                style: Theme.of(context).textTheme.headline1)),
                        Expanded(
                            child: ReorderableList(
                                onReorder: this._reorderCallback,
                                onReorderDone: this._reorderDone,
                                child: CustomScrollView(
                                  slivers: <Widget>[
                                    SliverList(
                                      delegate: SliverChildBuilderDelegate(
                                        (BuildContext context, int index) {
                                          return ReorderableListItem(
                                            data: unitsMeasure[i][
                                                index], // first and last attributes affect border drawn during dragging
                                            isFirst: index == 0,
                                            isLast: index ==
                                                unitsMeasure[i].length - 1,
                                            key: ValueKey(
                                                unitsMeasure[i][index].id),
                                          );
                                        },
                                        childCount: unitsMeasure[i].length,
                                      ),
                                    ),
                                  ],
                                ))),
                      ])
              ],
            ),
            bottomNavigationBar:
                ButtonBar(alignment: MainAxisAlignment.center, children: [
              RaisedButton(
                color: Colors.blue[700],
                onPressed: () {
                  Navigator.of(context).push(_createRoute());
                },
                child: Text('Edytuj jednostki',
                    style: Theme.of(context).textTheme.headline4),
              ),
              RaisedButton(
                color: Colors.blue[700],
                onPressed: () {
                  setState(() {
                    _recalculateValues();
                  });
                },
                child: Text('Oblicz',
                    style: Theme.of(context).textTheme.headline4),
              )
            ]));
  }
}

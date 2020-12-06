import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'custom_widgets.dart';
import 'package:flutter/cupertino.dart';
import '../database/unit_measure_db/unit_measure_db.dart';
import '../database/unit_measure_db/unit_measure_dao.dart';
import '../unit_converter_model/reorderable_list_item.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';

class UnitConverterPage extends StatelessWidget {
  final Function openMenuFunction;
  final UnitMeasureDao dao;

  const UnitConverterPage({Key key, this.openMenuFunction, this.dao})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Home(openMenuFunction: openMenuFunction, dao: dao);
  }
}

class Home extends StatefulWidget {
  final Function openMenuFunction;
  final UnitMeasureDao dao;

  Home({Key key, this.openMenuFunction, this.dao}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(this.dao);
}

class _HomePageState extends State<Home> {
  var cardTitles = ["Masa", "Długość"];
  var tabIndex = 0;
  final UnitMeasureDao dao;
  List<List<UnitMeasureDB>> unitsMeasure = new List<List<UnitMeasureDB>>();
  int indexOfSelectedUnit = 0;

  _HomePageState(this.dao);

  Future<List<UnitMeasureDB>> _getUnitsFromDatabase(int index) async {
    unitsMeasure.add(await dao.getUnitsByType(index));

    return await dao.getUnitsByType(index);
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

  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Builder(builder: (BuildContext context) {
          final TabController tabController = DefaultTabController.of(context);
          tabController.addListener(() {
            if (tabController.indexIsChanging) {
              setState(() {
                tabIndex = tabController.index;
              });
            }
          });
          return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: Colors.blueGrey[900],
                automaticallyImplyLeading: false,
                title: CustomTitle(
                    title: "Konwerter Miar",
                    openMenuFunction: widget.openMenuFunction),
                bottom: TabBar(
                  isScrollable: false,
                  tabs: [for (final tab in cardTitles) Tab(text: tab)],
                ),
              ),
              body: GestureDetector(
                  //zmiana indeksu w klasie do poprawnej zmiany elementow w liscie po przesunieciu karty
                  onHorizontalDragDown: (DragDownDetails dragDownDetails) {
                    setState(() {
                      tabIndex = tabController.index;
                    });
                  },
                  child: TabBarView(
                    children: [
                      for (int i = 0; i < cardTitles.length; i++)
                        Column(mainAxisSize: MainAxisSize.max, children: [
                          Container(
                              color: Colors.blueGrey[900],
                              child: SizedBox(
                                  height: 150,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Row(children: [
                                        unitsMeasure.length != 0 ?
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 25, left: 15),
                                              child: Text(
                                                  unitsMeasure[i][indexOfSelectedUnit].name,
                                                  style: TextStyle(
                                                      color:
                                                          Colors.white70,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 30)))
                                          : Padding(
                                              padding: EdgeInsets.only(
                                                  top: 15, left: 15),
                                              child:
                                                  CircularProgressIndicator())
                                      ]),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  right: 25, top: 40),
                                              child:
                                                unitsMeasure.length != 0 ? Text(
                                                    unitsMeasure[i][0].countedValue.toString(),
                                                    style: TextStyle(
                                                        color:
                                                            Colors.deepOrangeAccent,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 40))
                                                    : CircularProgressIndicator()
                                          )
                                        ],
                                      )
                                    ],
                                  ))),
                          Expanded(
                              child: Row(children: [
                                Expanded(
                                  child: Container(
                                    color: Colors.blueGrey[900],
                                    child: FutureBuilder<List<UnitMeasureDB>>(
                                        future: _getUnitsFromDatabase(i),
                                        initialData: List<UnitMeasureDB>(),
                                        builder: (context, snapshot) {
                                          return snapshot.hasData
                                              ? ReorderableList(
                                                  onReorder:
                                                      this._reorderCallback,
                                                  onReorderDone:
                                                      this._reorderDone,
                                                  child: CustomScrollView(
                                                    slivers: <Widget>[
                                                      SliverPadding(
                                                          padding: EdgeInsets.only(
                                                              bottom:
                                                                  MediaQuery.of(context).padding.bottom),
                                                          sliver: SliverList(
                                                            delegate:
                                                                SliverChildBuilderDelegate(
                                                              (BuildContext context, int index) {
                                                                return ReorderableListItem(
                                                                  data:
                                                                      unitsMeasure[i][index], // first and last attributes affect border drawn during dragging
                                                                  isFirst:
                                                                      index == 0,
                                                                  isLast: index == unitsMeasure[i].length - 1,
                                                                  key: ValueKey(
                                                                      unitsMeasure[i][index].id),
                                                                );
                                                              },
                                                              childCount:
                                                                  unitsMeasure[i].length,
                                                            ),
                                                          )),
                                                    ],
                                                  ))
                                              : Center(
                                                  child:
                                                      CircularProgressIndicator());
                                        })))
                          ]))
                        ])
                    ],
                  )));
        }));
  }
}

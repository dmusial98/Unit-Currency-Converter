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

class _HomePageState extends State<Home> with SingleTickerProviderStateMixin {
  var isLoading = true;
  var cardTitles = ["Masa", "Długość"];
  var tabIndex = 0;
  final UnitMeasureDao dao;
  List<List<UnitMeasureDB>> unitsMeasure = new List<List<UnitMeasureDB>>();
  int indexOfSelectedUnit = 0;
  TabController tabController;

  _HomePageState(this.dao);

  _getUnitsFromDatabase() async {
    for (int i = 0; i < cardTitles.length; i++)
      unitsMeasure.add(await dao.getUnitsByType(i));

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    tabController = TabController(vsync: this, length: cardTitles.length);
    tabController.addListener(() {
      if (tabController.index != tabController.previousIndex) {
        setState(() {
          tabIndex = tabController.index;
        });
      }
    });
    _getUnitsFromDatabase();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
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
    return Scaffold(
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
            tabs: [for (final tab in cardTitles) Tab(text: tab)],
          ),
        ),
        body: isLoading
            ? CircularProgressIndicator()
            : TabBarView(
                controller: tabController,
                children: [
                  for (int i = 0; i < cardTitles.length; i++)
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(top: 25, left: 15),
                              child: Text(
                                  unitsMeasure[i][indexOfSelectedUnit].name,
                                  style:
                                      Theme.of(context).textTheme.headline1)),
                          Padding(
                              padding: EdgeInsets.only(right: 25, top: 40),
                              child: Text(
                                  unitsMeasure[i][0].countedValue.toString(),
                                  textAlign: TextAlign.end,
                                  style:
                                      Theme.of(context).textTheme.headline1)),
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
        bottomNavigationBar: ButtonBar(
          alignment: MainAxisAlignment.center,
          children: [
            OutlineButton(
                onPressed: () {},
                child: Text('Kategorie',
                    style: Theme.of(context).textTheme.headline4)),
            OutlineButton(
                child: Text('Jednostki',
                    style: Theme.of(context).textTheme.headline4)),
          ],
        ));
  }
}

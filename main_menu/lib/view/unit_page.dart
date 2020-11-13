import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:main_menu/UnitMeasureDao.dart';
import 'custom_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';
import '../UnitMeasureDB.dart';
import '../UnitMeasureDao.dart';

//TODO: Ogarnac baze danych

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

class UnitMeasure {
  String name;
  String abbreviation;
  UnitType type;
  final Key key;

  UnitMeasure(this.name, this.type, this.abbreviation, this.key);
}

class _HomePageState extends State<Home> {
  final unitType = [UnitType.weight, UnitType.length];
  var cardTitles = ["Masa", "Długość"];
  var tabIndex = 0;
  final UnitMeasureDao dao;
  List<List<UnitMeasureDB>> unitsMeasure = new List<List<UnitMeasureDB>>();

  Future<List<UnitMeasureDB>> _getUnitsFromDatabase(int index) async {
    unitsMeasure.add(await dao.getUnitsByType(index));

    return await dao.getUnitsByType(index);
  }

  _HomePageState(this.dao) {
    // _getUnitsFromDatabase();
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

  DraggingMode _draggingMode = DraggingMode.iOS;

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
              body: GestureDetector( //zmiana indeksu w klasie do poprawnej zmiany elementow w liscie po przesunieciu karty
                  onHorizontalDragDown: (DragDownDetails dragDownDetails) {
                    setState(() {
                      tabIndex = tabController.index;
                    });
                  },
                  child: TabBarView(
                    children: [
                      for (int i = 0; i < cardTitles.length; i++)
                        Container(
                            color: Colors.blueGrey[900],
                            child: FutureBuilder<List<UnitMeasureDB>>(
                                future: _getUnitsFromDatabase(i),
                                initialData: List<UnitMeasureDB>(),
                                builder: (context, snapshot) {
                                  return snapshot.hasData
                                      ? ReorderableList(
                                          onReorder: this._reorderCallback,
                                          onReorderDone: this._reorderDone,
                                          child: CustomScrollView(
                                            slivers: <Widget>[
                                              SliverPadding(
                                                  padding: EdgeInsets.only(
                                                      bottom: MediaQuery.of(context)
                                                              .padding
                                                              .bottom),
                                                  sliver: SliverList(
                                                    delegate:
                                                        SliverChildBuilderDelegate(
                                                      (BuildContext context, int index) {
                                                        return Item(
                                                          data: unitsMeasure[i][index],
                                                          // first and last attributes affect border drawn during dragging
                                                          isFirst: index == 0,
                                                          isLast: index == unitsMeasure[i].length - 1,
                                                          draggingMode: _draggingMode,
                                                          key: ValueKey(unitsMeasure[i][index].id),
                                                        );}, 
                                                        childCount: unitsMeasure[i].length,
                                                    ),
                                                  )),
                                            ],
                                          ))
                                      : Center(
                                          child: CircularProgressIndicator());
                                }))
                    ],
                  )));
        }));
  }
}

class Item extends StatelessWidget {
  Item({this.data, this.isFirst, this.isLast, this.draggingMode, this.key});

  final UnitMeasureDB data;
  final bool isFirst;
  final bool isLast;
  final DraggingMode draggingMode;
  final Key key;

  Widget _buildChild(BuildContext context, ReorderableItemState state) {
    BoxDecoration decoration;

    if (state == ReorderableItemState.dragProxy ||
        state == ReorderableItemState.dragProxyFinished) {
      // slightly transparent background white dragging (just like on iOS)
      decoration = BoxDecoration(color: Colors.blueGrey[900]);
    } else {
      bool placeholder = state == ReorderableItemState.placeholder;
      decoration = BoxDecoration(
          border: Border(
              top: isFirst && !placeholder
                  ? Divider.createBorderSide(context) //
                  : BorderSide.none,
              bottom: isLast && placeholder
                  ? BorderSide.none //
                  : Divider.createBorderSide(context)),
          color: placeholder ? null : Colors.blueGrey[900]);
    }

    // For iOS dragging mode, there will be drag handle on the right that triggers
    // reordering; For android mode it will be just an empty container
    Widget dragHandle = draggingMode == DraggingMode.iOS
        ? ReorderableListener(
            child: Container(
              padding: EdgeInsets.only(right: 18.0, left: 18.0),
              color: Colors.blueGrey[900],
              child: Center(
                child: Icon(Icons.reorder, color: Color(0xFF888888)),
              ),
            ),
          )
        : Container();

    Widget content = Container(
      decoration: decoration,
      child: SafeArea(
          top: false,
          bottom: false,
          child: Opacity(
            // hide content for placeholder
            opacity: state == ReorderableItemState.placeholder ? 0.0 : 1.0,
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                      child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 14.0, horizontal: 14.0),
                    child: Row(children: [
                      ExcludeSemantics(
                          child: CircleAvatar(
                              child: Text(data.abbreviation,
                                  style: Theme.of(context).textTheme.headline4),
                              backgroundColor: Colors.blue[700],
                              foregroundColor: Colors.white)),
                      Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Text(data.name,
                            style: Theme.of(context).textTheme.headline2),
                      )
                    ]),
                  )),
                  // Triggers the reordering
                  dragHandle,
                ],
              ),
            ),
          )),
    );

    return content;
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableItem(key: key, childBuilder: _buildChild);
  }
}

enum DraggingMode {
  iOS,
  Android,
}

enum UnitType { weight, length }

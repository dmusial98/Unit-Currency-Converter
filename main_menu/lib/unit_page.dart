import 'package:flutter/material.dart';
import 'custom_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';

//TODO: Dodac pobieranie indexu tabControllera i okno z jednostka
//TODO: Ogarnac baze danych

class UnitConverterPage extends StatelessWidget {
  final Function openMenuFunction;

  const UnitConverterPage({Key key, this.openMenuFunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Home(openMenuFunction: openMenuFunction));
  }
}

class Home extends StatefulWidget {
  final Function openMenuFunction;
  
  Home({Key key, this.openMenuFunction}) : super(key: key);


  @override
  _HomePageState createState() => _HomePageState();
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
  List<List<UnitMeasure>> unitsMeasure = new List<List<UnitMeasure>>();
  var cardTitles = ["Masa", "Długość"];
  var tabIndex = 0;

  _HomePageState() {
    int index = 0;

    this.unitsMeasure.add(List<UnitMeasure>());

    this
        .unitsMeasure[0]
        .add(UnitMeasure("kilogram", UnitType.weight, "kg", ValueKey(index++)));
    this
        .unitsMeasure[0]
        .add(UnitMeasure("gram", UnitType.weight, "g", ValueKey(index++)));
    this.unitsMeasure[0].add(
        UnitMeasure("dekagram", UnitType.weight, "dag", ValueKey(index++)));
    this
        .unitsMeasure[0]
        .add(UnitMeasure("miligram", UnitType.weight, "mg", ValueKey(index++)));
    this
        .unitsMeasure[0]
        .add(UnitMeasure("funt", UnitType.weight, "lb", ValueKey(index++)));
    this
        .unitsMeasure[0]
        .add(UnitMeasure("uncja", UnitType.weight, "oz", ValueKey(index++)));
    this
        .unitsMeasure[0]
        .add(UnitMeasure("tona", UnitType.weight, "t", ValueKey(index++)));
    this
        .unitsMeasure[0]
        .add(UnitMeasure("kwintal", UnitType.weight, "q", ValueKey(index++)));
    this.unitsMeasure[0].add(UnitMeasure(
        "unit (jedn. masy atomowej)", UnitType.weight, "u", ValueKey(index++)));
    this.unitsMeasure[0].add(
        new UnitMeasure("karat", UnitType.weight, "ct", ValueKey(index++)));
    this.unitsMeasure[0].add(
        UnitMeasure("Jednostka", UnitType.weight, "jed", ValueKey(index++)));
    this.unitsMeasure[0].add(
        UnitMeasure("Jednostka", UnitType.weight, "jed", ValueKey(index++)));
    this.unitsMeasure[0].add(
        UnitMeasure("Jednostka", UnitType.weight, "jed", ValueKey(index++)));
    this.unitsMeasure[0].add(
        UnitMeasure("Jednostka", UnitType.weight, "jed", ValueKey(index++)));
    this.unitsMeasure[0].add(
        UnitMeasure("Jednostka", UnitType.weight, "jed", ValueKey(index++)));
    this.unitsMeasure[0].add(
        UnitMeasure("Jednostka", UnitType.weight, "jed", ValueKey(index++)));
    this.unitsMeasure[0].add(
        UnitMeasure("Jednostka", UnitType.weight, "jed", ValueKey(index++)));

    index = 0;

    this.unitsMeasure.add(List<UnitMeasure>());

    unitsMeasure[1]
        .add(new UnitMeasure("metr", UnitType.length, "m", ValueKey(index++)));
    unitsMeasure[1]
        .add(UnitMeasure("kilometr", UnitType.length, "km", ValueKey(index++)));
    this
        .unitsMeasure[1]
        .add(UnitMeasure("decymetr", UnitType.length, "dm", ValueKey(index++)));
    this.unitsMeasure[1].add(
        UnitMeasure("centymetr", UnitType.length, "cm", ValueKey(index++)));
    this
        .unitsMeasure[1]
        .add(UnitMeasure("milimetr", UnitType.length, "mm", ValueKey(index++)));
    this.unitsMeasure[1].add(
        UnitMeasure("mila morska", UnitType.length, "INM", ValueKey(index++)));
    this.unitsMeasure[1].add(UnitMeasure(
        "mila angielska", UnitType.length, "LM", ValueKey(index++)));
    this
        .unitsMeasure[1]
        .add(UnitMeasure("łokieć", UnitType.length, "ell", ValueKey(index++)));
    this
        .unitsMeasure[1]
        .add(UnitMeasure("stopa", UnitType.length, "ft", ValueKey(index++)));
    this
        .unitsMeasure[1]
        .add(UnitMeasure("jard", UnitType.length, "yd", ValueKey(index++)));
    this.unitsMeasure[1].add(
        UnitMeasure("Jednostka", UnitType.length, "jed", ValueKey(index++)));
    this.unitsMeasure[1].add(
        UnitMeasure("Jednostka", UnitType.length, "jed", ValueKey(index++)));
    this.unitsMeasure[1].add(
        UnitMeasure("Jednostka", UnitType.length, "jed", ValueKey(index++)));
    this.unitsMeasure[1].add(
        UnitMeasure("Jednostka", UnitType.length, "jed", ValueKey(index++)));
    this.unitsMeasure[1].add(
        UnitMeasure("Jednostka", UnitType.length, "jed", ValueKey(index++)));
    this.unitsMeasure[1].add(
        UnitMeasure("Jednostka", UnitType.length, "jed", ValueKey(index++)));
    this.unitsMeasure[1].add(
        UnitMeasure("Jednostka", UnitType.length, "jed", ValueKey(index++)));

    for (final tab in unitsMeasure)
      for (final unit in tab)
        debugPrint("Unit ${unit.key} - ${unit.name}");

  }

  int _indexOfKey(Key key) {
    return unitsMeasure[tabIndex].indexWhere((UnitMeasure d) => d.key == key);
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
      length: unitType.length,
      child: Builder(
        builder: (BuildContext context) {
          final TabController tabController = DefaultTabController.of(context);
          tabController.addListener(() {
            if(tabController.indexIsChanging) {
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
                title: Text("Konwerter Miar"),
                bottom: TabBar(
                  isScrollable: false,
                  tabs: [for (final tab in cardTitles) Tab(text: tab)],
                ),
              ),
              body: TabBarView(
                children: [
                  for (int i = 0; i < cardTitles.length; i++)
                    Container(
                        color: Colors.blueGrey[900],
                        child: ReorderableList(
                            onReorder: this._reorderCallback,
                            onReorderDone: this._reorderDone,
                            child: CustomScrollView(
                              slivers: <Widget>[
                                SliverPadding(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context).padding.bottom),
                                    sliver: SliverList(
                                      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                                          return Item(
                                            data: unitsMeasure[i][index],
                                            // first and last attributes affect border drawn during dragging
                                            isFirst: index == 0,
                                            isLast:
                                            index == unitsMeasure[i].length - 1,
                                            draggingMode: _draggingMode,
                                          );
                                        },
                                        childCount: unitsMeasure[i].length,
                                      ),
                                    )),
                              ],
                            )))
                ],
              )
          );
        }
      )
    );
  }
}

class Item extends StatelessWidget {
  Item({
    this.data,
    this.isFirst,
    this.isLast,
    this.draggingMode,
  });

  final UnitMeasure data;
  final bool isFirst;
  final bool isLast;
  final DraggingMode draggingMode;

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
                        child:
                        Row(
                            children: [
                              ExcludeSemantics(
                                child: CircleAvatar(child: Text(data.abbreviation),
                                  backgroundColor: Colors.blue[700],
                                  foregroundColor: Colors.white,)
                              ),
                              Padding(padding: EdgeInsets.only(left: 5.0),
                              child: Text(data.name,
                                style: TextStyle(fontSize: 24.0,
                                  fontFamily: 'Sans',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.brown[50]))),
                        ]),
                  )),
                  // Triggers the reordering
                  dragHandle,
                ],
              ),
            ),
          )
      ),
    );

    return content;
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableItem(key: data.key, childBuilder: _buildChild);
  }
}

enum DraggingMode {
  iOS,
  Android,
}

enum UnitType { weight, length }

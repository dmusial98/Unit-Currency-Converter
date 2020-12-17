import '../database/unit_measure_db/unit_measure_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';

class ReorderableListItem extends StatelessWidget {
  ReorderableListItem({this.data, this.isFirst, this.isLast, this.key});

  final UnitMeasureDB data;
  final bool isFirst;
  final bool isLast;
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
    Widget dragHandle = ReorderableListener(
      child: Container(
        padding: EdgeInsets.only(right: 18.0, left: 18.0),
        color: Colors.blueGrey[900],
        child: Center(
          child: Icon(Icons.reorder, color: Color(0xFF888888)),
        ),
      ),
    );

    Widget content = Container(
      decoration: decoration,
      padding: new EdgeInsets.all(7.0),
      child: SafeArea(
          top: false,
          bottom: false,
          child: Opacity(
            // hide content for placeholder
            opacity: state == ReorderableItemState.placeholder ? 0.0 : 1.0,
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ExcludeSemantics(
                      child: CircleAvatar(
                          child: Text(data.abbreviation,
                              style: Theme.of(context).textTheme.headline4),
                          backgroundColor: Colors.blue[700],
                          foregroundColor: Colors.white)),
                  Expanded(
                      child: Container(
                          padding: new EdgeInsets.only(left: 5.0),
                          child: Text(data.name,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.headline2))),
                  Text(data.countedValue.toString(),
                      style: TextStyle(
                          color: Colors.blue,
                          fontStyle: FontStyle.normal,
                          fontSize: 20)),

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

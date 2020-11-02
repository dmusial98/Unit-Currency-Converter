import 'package:flutter/material.dart';
import 'custom_widgets.dart';

class UnitConverterPage extends StatelessWidget {
  final Function openMenuFunction;

  const UnitConverterPage({Key key, this.openMenuFunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: CustomTitle(title: "Unit", openMenuFunction: openMenuFunction)),
      body: Center(
        child: Text('Unit converter page'),
      ),
    );
  }
}

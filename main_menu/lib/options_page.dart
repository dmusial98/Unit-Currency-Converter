import 'package:flutter/material.dart';
import 'custom_widgets.dart';

class OptionsPage extends StatelessWidget {
  final Function openMenuFunction;

  const OptionsPage({Key key, this.openMenuFunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomTitle(openMenuFunction: openMenuFunction, title: "Options")),
      body: Center(
        child: Text('Options page'),
      ),
    );
  }
}

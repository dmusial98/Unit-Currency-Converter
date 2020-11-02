import 'package:flutter/material.dart';
import 'custom_widgets.dart';

class CurrencyConverterPage extends StatelessWidget {
  final Function openMenuFunction;

  const CurrencyConverterPage({Key key, this.openMenuFunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
              CustomTitle(title: "Currency", openMenuFunction: openMenuFunction)),
      body: Center(
        child: Text('Currency converter page'),
      ),
    );
  }
}

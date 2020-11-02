import 'package:flutter/material.dart';

class CurrencyConverterPage extends StatelessWidget {
  final Function backToMainMenu;

  const CurrencyConverterPage({Key key, this.backToMainMenu}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            InkWell(child: Icon(Icons.menu), onTap: backToMainMenu),
            Text('Currency')
          ],
        ),
      ),
      body: Center(
        child: Text('Currency converter page'),
      ),
    );
  }
}

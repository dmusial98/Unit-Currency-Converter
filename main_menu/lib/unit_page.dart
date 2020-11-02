import 'package:flutter/material.dart';

class UnitConverterPage extends StatelessWidget {
  final Function backToMainMenu;

  const UnitConverterPage({Key key, this.backToMainMenu}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            InkWell(child: Icon(Icons.menu), onTap: backToMainMenu),
            Text('Unit')
          ],
        ),
      ),
      body: Center(
        child: Text('Unit converter page'),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class OptionsrPage extends StatelessWidget {
  final Function backToMainMenu;

  const OptionsrPage({Key key, this.backToMainMenu}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            InkWell(child: Icon(Icons.menu), onTap: backToMainMenu),
            Text('Options')
          ],
        ),
      ),
      body: Center(
        child: Text('Options page'),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../exchange_rates_model/exchange_rates.dart';
import 'custom_widgets.dart';

class ExchangeConverterPage extends StatefulWidget {
  final Function openMenuFunction;

  const ExchangeConverterPage({Key key, this.openMenuFunction})
      : super(key: key);

  _ExchangeConverterPageState createState() => _ExchangeConverterPageState();
}

class _ExchangeConverterPageState extends State<ExchangeConverterPage> {
  bool isLoading = true;
  List<DropdownMenuItem<int>> units = new List<DropdownMenuItem<int>>();
  ExchangeRates exchangeRates = ExchangeRates();
  TextEditingController inputController;
  int inputIndex = 0;
  int outputIndex = 0;

  final TextStyle mainStyle = new TextStyle(
      fontSize: 32.0,
      fontFamily: 'Sans',
      fontWeight: FontWeight.w300,
      color: Colors.brown[50]);

  _downloadRates() async {
    await exchangeRates.downloadRatesForDay();
    setState(() {
      exchangeRates.rates
          .map((e) => units.add(new DropdownMenuItem<int>(
              value: units.length,
              child: new Text(e.code,
                  style: mainStyle, textAlign: TextAlign.right))))
          .toList();
      isLoading = false;
    });
  }

  @override
  void initState() {
    _downloadRates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[800],
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.blueGrey[900],
            title: CustomTitle(
                title: "Konwerter Walut",
                openMenuFunction: widget.openMenuFunction)),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DropdownButton<int>(
                        items: units,
                        dropdownColor: Colors.blueGrey[800],
                        icon: Icon(Icons.keyboard_arrow_down),
                        value: units[inputIndex].value,
                        onChanged: (value) {
                          setState(() {
                            inputIndex = value;
                          });
                        },
                      ),
                      Container(child: Icon(Icons.swap_horiz, color: Colors.brown[50], size: 32.0), padding: EdgeInsets.all(20.0),),
                      DropdownButton<int>(
                        value: units[outputIndex].value,
                        items: units,
                        dropdownColor: Colors.blueGrey[800],
                        icon: Icon(Icons.keyboard_arrow_down),
                        onChanged: (value) {
                          setState(() {
                            outputIndex = value;
                          });
                        },
                      ),
                    ],
                  ),

                ],
              ));
  }
}

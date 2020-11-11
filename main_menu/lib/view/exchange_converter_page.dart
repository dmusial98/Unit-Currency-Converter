import 'package:flutter/material.dart';
import '../exchange_rates_model/exchange_rates.dart';
import '../custom_widgets.dart';

class ExchangeConverterPage extends StatefulWidget {
  final Function openMenuFunction;

  const ExchangeConverterPage({Key key, this.openMenuFunction})
      : super(key: key);

  _ExchangeConverterPageState createState() => _ExchangeConverterPageState();
}

class _ExchangeConverterPageState extends State<ExchangeConverterPage> {
  bool isLoading = true;
  List<String> units = List<String>();
  ExchangeRates exchangeRates = ExchangeRates();
  String inputUnit;
  String outputUnit;

  _downloadRates() async {
    await exchangeRates.downloadRatesForDay();
    exchangeRates.rates.map((e) => units.add(e.code));

    setState(() {
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
            : Row(
                children: [
                  Text("test"),
                  Column(
                    children: [
                      DropdownButton(
                        value: inputUnit,
                        items:
                            units.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String value) {
                          setState(() {
                            inputUnit = value;
                          });
                        },
                      ),
                      Icon(Icons.swap_horiz),
                      DropdownButton(
                        value: outputUnit,
                        items:
                            units.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String value) {
                          setState(() {
                            outputUnit = value;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ));
  }
}

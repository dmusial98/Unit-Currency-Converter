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
  TextEditingController inputController = new TextEditingController();
  int inputIndex = 0;
  int outputIndex = 0;
  double calculatedValue = 0.0;

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
    inputController.addListener(() {
      setState(() {
        _calculateValue();
      });
    });

    units.add(new DropdownMenuItem<int>(
        value: units.length,
        child: new Text("PLN", style: mainStyle, textAlign: TextAlign.right)));

    _downloadRates();
  }

  _calculateValue() {
    double inputValue = double.tryParse(inputController.text);

    if (inputValue == null){
      calculatedValue = 0.0;
      return;
    }

    if (inputIndex == outputIndex) {
      calculatedValue = inputValue;
      return;
    }

    if (inputIndex == 0) {
      calculatedValue = inputValue * exchangeRates.rates[outputIndex - 1].bid;
      return;
    }

    if (outputIndex == 0) {
      calculatedValue = inputValue / exchangeRates.rates[inputIndex - 1].ask;
      return;
    }

    inputValue *= exchangeRates.rates[inputIndex-1].bid;
    calculatedValue = inputValue / exchangeRates.rates[outputIndex - 1].ask;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[900],
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
                  TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Wprowadź wartość',
                          hintStyle: TextStyle(color: Colors.blueGrey[800])),
                      textAlign: TextAlign.left,
                      controller: inputController,
                      style: TextStyle(
                          fontSize: 48.0,
                          fontFamily: 'Sans',
                          fontWeight: FontWeight.w200,
                          color: Colors.brown[50])),
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
                            _calculateValue();
                          });
                        },
                      ),
                      Container(
                        child: Icon(Icons.swap_horiz,
                            color: Colors.brown[50], size: 32.0),
                        padding: EdgeInsets.all(20.0),
                      ),
                      DropdownButton<int>(
                        value: units[outputIndex].value,
                        items: units,
                        dropdownColor: Colors.blueGrey[800],
                        icon: Icon(Icons.keyboard_arrow_down),
                        onChanged: (value) {
                          setState(() {
                            outputIndex = value;
                            _calculateValue();
                          });
                        },
                      ),
                    ],
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(calculatedValue.toString(),
                        textAlign: TextAlign.end,
                        style: new TextStyle(
                            fontSize: 96.0,
                            fontFamily: 'Sans',
                            fontWeight: FontWeight.w300,
                            color: Colors.brown[50])),
                  )
                ],
              ));
  }
}

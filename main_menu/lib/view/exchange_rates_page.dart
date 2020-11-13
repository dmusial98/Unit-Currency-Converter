import 'package:flutter/material.dart';
import 'custom_widgets.dart';
import '../exchange_rates_model/exchange_rates.dart';
import '../exchange_rates_model/exchange_rates_json.dart';

class ExchangeRatesPage extends StatefulWidget {
  final Function openMenuFunction;

  const ExchangeRatesPage({Key key, this.openMenuFunction}) : super(key: key);

  _CurrencyConverterPage createState() => _CurrencyConverterPage();
}

class _CurrencyConverterPage extends State<ExchangeRatesPage> {
  bool isLoading = true;
  ExchangeRates exchangeRates = ExchangeRates();

  _downloadRates() async {
    await exchangeRates.downloadRatesForDay();
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
                title: "Tabela kursów",
                openMenuFunction: widget.openMenuFunction)),
        body: Container(
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: exchangeRates.rates.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ExchangeRateEntry(
                          rate: exchangeRates.rates[index]);
                    })),
        );
  }
}

class ExchangeRateEntry extends StatelessWidget {
  final ExchangeRate rate;

  const ExchangeRateEntry({Key key, this.rate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(rate.fullName),
          duration: Duration(milliseconds: 1000),
        ));
      },
      child: Container(
          margin: EdgeInsets.all(3.0),
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              color: (Colors.blueGrey[900]),
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          child: Row(children: [
            Text(rate.code.toUpperCase(),
                style: Theme.of(context).textTheme.headline3),
            Spacer(),
            Text(rate.ask.toString(),
                style: Theme.of(context).textTheme.headline2),
            Expanded(
                flex: 1,
                child: Icon(
                  Icons.swap_vert,
                  color: Colors.brown[50],
                )),
            Text(rate.bid.toString(),
                style: Theme.of(context).textTheme.headline2)
          ])),
    );
  }
}

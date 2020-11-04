import 'dart:convert';

import 'package:flutter/material.dart';
import 'custom_widgets.dart';
import 'package:http/http.dart' as http;
import 'exchange_rates.dart';

class CurrencyConverterPage extends StatefulWidget {
  final Function openMenuFunction;

  const CurrencyConverterPage({Key key, this.openMenuFunction})
      : super(key: key);

  _CurrencyConverterPage createState() => _CurrencyConverterPage();
}

class _CurrencyConverterPage extends State<CurrencyConverterPage> {
  bool isLoading = false;
  List<ExchangeRate> exchangeRates;

  _downloadRates() async {
    setState(() {
      isLoading = true;
    });

    final response = await http
        .get("http://api.nbp.pl/api/exchangerates/tables/C?format=json");

    if (response.statusCode == 200) {
      var exchangeRatesForDayList =
          ExchangeRatesForDayList.fromJson(jsonDecode(response.body));

      if (exchangeRatesForDayList.ratesForDay.length != 1)
        throw Exception('Pobrano błędne dane');

      exchangeRates = exchangeRatesForDayList.ratesForDay[0].rates;

      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Nie udało się pobrać danych');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blueGrey[900],
          title: CustomTitle(
              title: "Tabela kursów",
              openMenuFunction: widget.openMenuFunction)),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: exchangeRates != null ? exchangeRates.length : 0,
              itemBuilder: (BuildContext context, int index) {
                return ExchangeRateEntry(
                    fullName: exchangeRates[index].fullName,
                    code: exchangeRates[index].code,
                    bid: exchangeRates[index].bid,
                    ask: exchangeRates[index].ask);
              }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RaisedButton(
          child: Text("Pobierz tabelę kursów"),
          onPressed: _downloadRates,
        ),
      ),
    );
  }
}

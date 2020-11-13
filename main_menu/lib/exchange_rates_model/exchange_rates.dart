import 'package:http/http.dart' as http;
import 'dart:convert';
import 'exchange_rates_json.dart';

class ExchangeRates {
  String tableType;
  String no;
  String tradingDate;
  String effectiveDate;
  List<ExchangeRate> rates;

  ExchangeRates() {
    rates = List<ExchangeRate>();
  }

  void downloadRatesForDay() async {
    final response = await http
        .get("http://api.nbp.pl/api/exchangerates/tables/C?format=json");

    if (response.statusCode == 200) {
      var exchangeRatesForDayList =
          ExchangeRatesForDayList.fromJson(jsonDecode(response.body));

      if (exchangeRatesForDayList.ratesForDay.length != 1)
        throw Exception('Pobrano błędne dane');

      rates = exchangeRatesForDayList.ratesForDay[0].rates;
    } else {
      throw Exception('Nie udało się pobrać danych');
    }
  }
}

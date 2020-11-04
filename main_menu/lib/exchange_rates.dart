class ExchangeRate {
  final String fullName;
  final String code;
  final double bid;
  final double ask;

  ExchangeRate({this.fullName, this.code, this.bid, this.ask});

  factory ExchangeRate.fromJson(Map<String, dynamic> json) {
    return ExchangeRate(
        fullName: json['currency'],
        code: json['code'],
        bid: json['bid'],
        ask: json['ask']);
  }
}

class ExchangeRatesForDay {
  final String tableType;
  final String no;
  final String tradingDate;
  final String effectiveDate;
  final List<ExchangeRate> rates;

  ExchangeRatesForDay(
      {this.tableType,
      this.no,
      this.tradingDate,
      this.effectiveDate,
      this.rates});

  factory ExchangeRatesForDay.fromJson(Map<String, dynamic> json) {
    var list = json['rates'] as List;
    List<ExchangeRate> parsedRates =
        list.map((e) => ExchangeRate.fromJson(e)).toList();

    return ExchangeRatesForDay(
        tableType: json['table'],
        no: json['no'],
        tradingDate: json['tradingDate'],
        effectiveDate: json['effectiveDate'],
        rates: parsedRates);
  }
}

class ExchangeRatesForDayList {
  final List<ExchangeRatesForDay> ratesForDay;

  ExchangeRatesForDayList({this.ratesForDay});

  factory ExchangeRatesForDayList.fromJson(List<dynamic> json) {
    List<ExchangeRatesForDay> parsedExchangeRatesForDays =
        json.map((e) => ExchangeRatesForDay.fromJson(e)).toList();

    return new ExchangeRatesForDayList(ratesForDay: parsedExchangeRatesForDays);
  }
}

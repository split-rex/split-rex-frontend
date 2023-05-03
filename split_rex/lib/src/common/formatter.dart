import 'package:money_formatter/money_formatter.dart';

String mFormat(double amount) {
  MoneyFormatter fmf = MoneyFormatter(
      amount: amount,
      settings: MoneyFormatterSettings(
        symbol: 'IDR',
        thousandSeparator: '.',
        decimalSeparator: ',',
        symbolAndNumberSeparator: ' ',
        fractionDigits: 0,
      ));
  return fmf.output.symbolOnLeft;
}

String homeMFormat(double amount) {
  MoneyFormatter fmf = MoneyFormatter(
      amount: amount,
      settings: MoneyFormatterSettings(
        symbol: 'IDR',
        thousandSeparator: '.',
        decimalSeparator: ',',
        symbolAndNumberSeparator: ' ',
        fractionDigits: 0,
      ));
  if (amount < 100000) {
    return fmf.output.symbolOnLeft;
  } else {
    return fmf.output.compactSymbolOnLeft;
  }
}

String tFormat(double amount) {
  MoneyFormatter fmf = MoneyFormatter(
      amount: amount,
      settings: MoneyFormatterSettings(
        thousandSeparator: '.',
        decimalSeparator: ',',
        symbolAndNumberSeparator: ' ',
        fractionDigits: 0,
      ));

  return fmf.output.nonSymbol;
}

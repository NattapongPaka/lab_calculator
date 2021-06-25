import 'dart:async';

import 'package:calculator/src/utils/index.dart';
import 'package:flutter/foundation.dart';

class CalService {
  final StreamController<String> _controller = StreamController<String>();
  Stream<String> get streamValue => _controller.stream;

  static String _operator;
  static String _valA = '0';
  static String _valB = '0';
  static String _result;
  //static String _display;

  static String get _equation =>
      _valA +
      (_operator != null ? ' ' + _operator : '') +
      (_valB != '0' ? ' ' + _valB : '');

  handleInteger(NumPadKey key) {
    if (key == Keys.unused) {
      return;
    }

    String val = key.value;
    if (_operator == null) {
      _valA = (_valA == '0') ? val : _valA + val;
      _refresh(_valA);
    } else {
      _valB = (_valB == '0') ? val : _valB + val;
      _refresh(_valA + _operator + _valB);
    }
  }

  handleOperator(NumPadKey key) {
    if (_valA == '0') {
      return;
    } else if (key == Keys.equals) {
      _calculate();
    } else {
      _operator = key.value;
      _refresh(_valA + _operator);
    }
  }

  handle({NumPadKey value}) {
    if (value.type == KeyType.FUNCTION) {
      handleFunction(value);
    } else if (value.type == KeyType.INTEGER) {
      handleInteger(value);
    } else if (value.type == KeyType.OPERATOR) {
      handleOperator(value);
    }
  }

  handleFunction(NumPadKey key) {
    if (_valA == '0') {
      return;
    }
    // if (_result != null) {
    //   _condense();
    // }

    Map<NumPadKey, dynamic> table = {
      Keys.clear: () => _clear(),
      // Keys.sign: () => _sign(),
      Keys.percent: () => _percent(),
      Keys.decimal: () => _decimal(),
    };

    table[key]();
    // _refresh();
  }

  _decimal() {
    if (_valB != '0' && !_valB.contains('.')) {
      _valB = _valB + '.';
      _refresh(_valB);
    } else if (_valA != '0' && !_valA.contains('.')) {
      _valA = _valA + '.';
      _refresh(_valA);
    }
  }

  String calcPercent(String x) => (double.parse(x) / 100).toString();

  _percent() {
    if (_valB != '0' && !_valB.contains('.')) {
      _valB = calcPercent(_valB);
      _refresh(_valB);
    } else if (_valA != '0' && !_valA.contains('.')) {
      _valA = calcPercent(_valA);
      _refresh(_valA);
    }
  }

  _calculate() {
    if (_operator == null || _valB == '0') {
      return;
    }

    Map<String, dynamic> table = {
      Keys.divide.value: (a, b) => (a / b),
      Keys.multiply.value: (a, b) => (a * b),
      Keys.subtract.value: (a, b) => (a - b),
      Keys.add.value: (num a, num b) => (a + b)
    };

    var a = num.parse(_valA);
    var b = num.parse(_valB);
    var result = table[_operator](a, b);

    //debugPrint("$a $b $_operator $result");

    String str = result.toString();

    while ((str.contains('.') && str.endsWith('0')) || str.endsWith('.')) {
      str = str.substring(0, str.length - 1);
    }

    _result = str;

    _refresh(_result);

    _condense();
  }

  _condense() {
    _valA = _result;
    _valB = '0';
    _result = _operator = null;
  }

  _clear() {
    _valA = _valB = '0';
    _operator = _result = null;
    _refresh("");
  }

  _refresh(String val) {
    _controller.add(val);
  }

  dispose() {
    _controller?.close();
  }
}

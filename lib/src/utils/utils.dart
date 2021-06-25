import 'package:calculator/src/utils/index.dart';
import 'package:flutter/foundation.dart';

enum KeyType { FUNCTION, OPERATOR, INTEGER }

class Keys {
  static NumPadKey clear = NumPadKey('C');
  //static NumPadKey sign =  NumPadKey('±');
  static NumPadKey percent = NumPadKey('%');
  static NumPadKey divide = NumPadKey('÷');
  static NumPadKey multiply = NumPadKey('x');
  static NumPadKey subtract = NumPadKey('-');
  static NumPadKey add = NumPadKey('+');
  static NumPadKey equals = NumPadKey('=');
  static NumPadKey decimal = NumPadKey('.');

  static NumPadKey zero = NumPadKey('0');
  static NumPadKey one = NumPadKey('1');
  static NumPadKey two = NumPadKey('2');
  static NumPadKey three = NumPadKey('3');
  static NumPadKey four = NumPadKey('4');
  static NumPadKey five = NumPadKey('5');
  static NumPadKey six = NumPadKey('6');
  static NumPadKey seven = NumPadKey('7');
  static NumPadKey eight = NumPadKey('8');
  static NumPadKey nine = NumPadKey('9');
  static NumPadKey unused = NumPadKey('!!');
}

class NumPadKey {
  const NumPadKey(this.value);
  final String value;

  static List<NumPadKey> _functions = [
    Keys.clear,
    //Keys.sign,
    Keys.percent,
    Keys.decimal
  ];

  static List<NumPadKey> _operators = [
    Keys.divide,
    Keys.multiply,
    Keys.subtract,
    Keys.add,
    Keys.equals
  ];

  @override
  String toString() => value;

  bool get isOperator => _operators.contains(this);
  bool get isFunction => _functions.contains(this);
  bool get isInteger => !isOperator && !isFunction;

  KeyType get type => isFunction
      ? KeyType.FUNCTION
      : (isOperator ? KeyType.OPERATOR : KeyType.INTEGER);
}

class NumPad {
  static final List<List<NumPadKey>> numPad = [
    [Keys.clear, Keys.divide, Keys.multiply, Keys.unused],
    [Keys.seven, Keys.eight, Keys.nine, Keys.subtract],
    [Keys.four, Keys.five, Keys.six, Keys.add],
    [Keys.one, Keys.two, Keys.three, Keys.equals],
    [Keys.percent, Keys.zero, Keys.decimal, Keys.unused],
  ];
}

class Spacing {
  static double get xs => 4;
  static double get s => 8;
  static double get m => 16;
  static double get l => 24;
  static double get xl => 32;
  //static double get xx => 40;
  static double get xxl => 64;
}

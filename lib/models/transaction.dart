import 'package:flutter/foundation.dart';

class Transaction {
  String id;
  String title;
  double amount;
  DateTime date;
  String currency = "\$";

  Transaction(
      {@required this.id,
      @required this.title,
      @required this.amount,
      @required this.date}); //named args/KWargs

}

import 'package:flutter/foundation.dart';

class Transaction {
  final int id;
  final String title;
  final double amount;
  final DateTime date;

  Transaction({
    @required this.amount,
    @required this.date,
    @required this.id,
    @required this.title,
  });
}

 List<Transaction> transactions = [
    Transaction(
      amount: 85.53,
      date: DateTime.now().subtract(Duration(days: 1)),
      id: 1,
      title: 'New Book',
    ),
    Transaction(
      amount: 67.54,
      date: DateTime.now(),
      id: 2,
      title: 'Shoes',
    ),
    Transaction(
      amount: 67.54,
      date: DateTime.now(),
      id: 3,
      title: 'Shoes',
    ),
    Transaction(
      amount: 67.54,
      date: DateTime.now(),
      id: 4,
      title: 'Shoes',
    ),
    Transaction(
      amount: 67.54,
      date: DateTime.now(),
      id: 5,
      title: 'Shoes',
    ),
    Transaction(
      amount: 67.54,
      date: DateTime.now(),
      id: 6,
      title: 'Shoes',
    ),
  ];

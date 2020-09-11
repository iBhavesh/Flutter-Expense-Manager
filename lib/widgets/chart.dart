import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './chart_bar.dart';

import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _recentTransactions;

  Chart(this._recentTransactions);

  List<Map<String, Object>> get _groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: (6 - index)));
      var totalSum = 0.0;

      for (var i = 0; i < _recentTransactions.length; i++) {
        if (DateFormat('yMd').format(_recentTransactions[i].date) ==
            DateFormat('yMd').format(weekDay)) {
          totalSum += _recentTransactions[i].amount;
        }
      }

      return {
        "day": DateFormat.E().format(weekDay).substring(0, 1),
        "amount": totalSum,
      };
    });
  }

  double get totalSpending {
    return _groupedTransactionValues.fold(
        0, (previousValue, element) => (previousValue += element['amount']));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(20),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: _groupedTransactionValues.map((data) {
            return Expanded(
              child: ChartBar(
                data['day'],
                data['amount'],
                totalSpending == 0.0
                    ? 0
                    : (data['amount'] as double) / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

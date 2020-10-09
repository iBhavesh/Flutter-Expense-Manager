import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  final Transaction _tx;
  final Function _deleteTransaction;

  TransactionItem(this._tx, this._deleteTransaction);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      elevation: 5,
      child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: FittedBox(
                child: Text('\$${_tx.amount}'),
              ),
            ),
          ),
          title: Text(
            _tx.title,
            style: Theme.of(context).textTheme.headline6,
          ),
          subtitle: Text(
            DateFormat.yMMMd().format(_tx.date),
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          trailing: MediaQuery.of(context).size.width > 400
              ? TextButton.icon(
                  icon: Icon(
                    Icons.delete,
                  ),
                  label: Text(
                    'Delete Transaction',
                  ),
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all(Theme.of(context).errorColor),
                  ),
                  onPressed: () => _deleteTransaction(_tx.id),
                )
              : IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).errorColor,
                  ),
                  onPressed: () => _deleteTransaction(_tx.id),
                )),
    );
  }
}

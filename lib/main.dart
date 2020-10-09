import 'package:flutter/material.dart';

import './widgets/new_transaction.dart';
import './widgets/chart.dart';
import './widgets/transaction_list.dart';

import './models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              button: TextStyle(color: Colors.white),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      title: 'Expense Tracker',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = transactions;

  var _showChart = true;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((element) {
      return element.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addTransaction(String title, double amount, DateTime date) {
    final tx = Transaction(
      amount: amount,
      date: date,
      id: _userTransactions.length,
      title: title,
    );

    setState(() {
      _userTransactions.add(tx);
    });
  }

  void _showAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTransaction(_addTransaction);
      },
    );
  }

  void _deleteTransaction(int id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final _appBar = AppBar(
      title: Text(
        'Expense Tracker',
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _showAddNewTransaction(context),
        )
      ],
    );

    final _mediaQuery = MediaQuery.of(context);
    final _isLandscape =
        _mediaQuery.orientation == Orientation.landscape ? true : false;

    return Scaffold(
      appBar: _appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_isLandscape)
              Container(
                height: (_mediaQuery.size.height -
                        _appBar.preferredSize.height -
                        _mediaQuery.padding.top) *
                    0.2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Show Chart'),
                    Switch(
                        value: _showChart,
                        onChanged: (value) {
                          setState(() {
                            _showChart = value;
                          });
                        }),
                  ],
                ),
              ),
            if (!_isLandscape)
              Container(
                height: (_mediaQuery.size.height -
                        _appBar.preferredSize.height -
                        _mediaQuery.padding.top) *
                    0.3,
                child: Chart(_recentTransactions),
              ),
            if (!_isLandscape)
              Container(
                height: (_mediaQuery.size.height -
                        _appBar.preferredSize.height -
                        _mediaQuery.padding.top) *
                    0.7,
                child: TransactionList(_userTransactions, _deleteTransaction),
              ),
            if (_isLandscape)
              _showChart
                  ? Container(
                      height: (_mediaQuery.size.height -
                              _appBar.preferredSize.height -
                              _mediaQuery.padding.top) *
                          0.7,
                      child: Chart(_recentTransactions),
                    )
                  : Container(
                      height: (_mediaQuery.size.height -
                              _appBar.preferredSize.height -
                              _mediaQuery.padding.top) *
                          0.7,
                      child: TransactionList(
                          _userTransactions, _deleteTransaction),
                    ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () => _showAddNewTransaction(context),
      ),
    );
  }
}

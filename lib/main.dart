import 'package:flutter/material.dart';
import 'package:p1_expenses_planner/widget/chart.dart';
import 'package:p1_expenses_planner/widget/new_transaction.dart';
import 'package:p1_expenses_planner/widget/transactions_list.dart';

import 'model/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal expenses',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        fontFamily: "Quicksand",
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                ),
              ),
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 16,
                fontWeight: FontWeight.bold),
            button: TextStyle(color: Colors.white)),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(id: "t1", title: "new TV", amount: 29.99, date: DateTime.now()),
    Transaction(id: "t2", title: "Beer", amount: 9.10, date: DateTime.now()),
    Transaction(id: "t3", title: "Fuel", amount: 12.45, date: DateTime.now()),
    Transaction(id: "t4", title: "Udemy", amount: 9.99, date: DateTime.now()),
    Transaction(id: "t5", title: "Food", amount: 9.99, date: DateTime.now()),
    Transaction(id: "t6", title: "Coffe", amount: 110.10, date: DateTime.now()),
    Transaction(id: "t7", title: "PS Game", amount: 120, date: DateTime.now()),
  ];

  List<Transaction> get _recentTransaction {
    return _transactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expenses planner"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Chart(_recentTransaction),
          Expanded(
            child: TransactionList(_transactions, _deleteTransaction),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (_) {
          return Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: GestureDetector(
              onTap: () {},
              child: NewTransaction(_addTransaction, _deleteTransaction),
              behavior: HitTestBehavior.opaque,
            ),
          );
        });
  }

  void _addTransaction(String txTitle, double txAmount, DateTime date) {
    print("addTransaction $txTitle $txAmount");
    final newTx = Transaction(
        title: txTitle,
        amount: txAmount,
        date: date,
        id: DateTime.now().millisecondsSinceEpoch.toString());

    setState(() {
      _transactions.add(newTx);
    });
  }

  void _deleteTransaction(String transactionId) {
    print("_deleteTransaction $transactionId");
    setState(() {
      _transactions.removeWhere((tx) {
        return tx.id == transactionId;
      });
    });
  }
}

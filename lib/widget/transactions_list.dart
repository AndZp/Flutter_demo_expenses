import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:p1_expenses_planner/model/transaction.dart';

class TransactionList extends StatelessWidget {
  final DateFormat format = DateFormat('kk:mm, dd.MM.yyyy');
  final List<Transaction> _transactions;
  final Function(String txId) _deleteTransaction;

  TransactionList(this._transactions, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  "No transaction added yet!",
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    height: 200,
                    child: Image.asset(
                      "assets/images/waiting.png",
                      fit: BoxFit.cover,
                    ))
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 20,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text('\$${_transactions[index].amount}'),
                        ),
                      ),
                    ),
                    title: Text(
                      _transactions[index].title,
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(_transactions[index].date),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () => _deleteTransaction(_transactions[index].id)
                    ),
                  ),
                );
              },
              itemCount: _transactions.length,
            ),
    );
    ;
  }
}

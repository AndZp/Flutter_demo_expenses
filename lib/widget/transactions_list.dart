import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:p1_expenses_planner/model/transaction.dart';

class TransactionList extends StatelessWidget {
  final DateFormat format = DateFormat('kk:mm, dd.MM.yyyy');
  final List<Transaction> _transactions;

  TransactionList(this._transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
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
                Transaction tx = _transactions[index];
                return Card(
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Text(
                          "\$ ${tx.amount.toStringAsFixed(2)}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Theme.of(context).primaryColor),
                        ),
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 1,
                        )),
                        padding: EdgeInsets.all(10),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            tx.title,
                            style: Theme.of(context).textTheme.title,
                          ),
                          Text(
                            format.format(tx.date),
                            style: TextStyle(fontSize: 10),
                          )
                        ],
                      )
                    ],
                  ),
                );
              },
              itemCount: _transactions.length,
            ),
    );
    ;
  }
}

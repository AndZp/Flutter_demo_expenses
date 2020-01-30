import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:p1_expenses_planner/model/transaction.dart';

import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  const Chart(this.recentTransaction);

  List<Map<String, Object>> get groupedTransaction {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;
      for (var value in recentTransaction) {
        if (value.date.day == weekDay.day &&
            value.date.month == weekDay.month &&
            value.date.year == weekDay.year) {
          totalSum += value.amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0,1),
        'amount': totalSum.toString()
      };
    });
  }

  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: groupedTransaction.map((data) {
          return  ChartBar(data["day"], double.parse(data["amount"]), 0.5);
        }).toList(),
      ),
    );
  }
}

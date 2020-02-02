import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function(String txTitle, double txAmount, DateTime date) _addTransaction;

  NewTransaction(this._addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleInputController = TextEditingController();
  final amountInputController = TextEditingController();
  DateTime selectedDate;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    labelText: "Title",
                  ),
                  controller: titleInputController,
                ),
                TextField(
                    decoration: InputDecoration(labelText: "Amount"),
                    keyboardType: TextInputType.number,
                    controller: amountInputController,
                    onSubmitted: (_) => _submitTransaction()),
                Container(
                  height: 70,
                  child: Row(
                    children: <Widget>[
                      Expanded(child: Text(selectedDate == null ? "No date chosen" : "Picked date: ${DateFormat.yMd().format(selectedDate)}")),
                      FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        child: Text(
                          "Choose date",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: _presentDatePicker,
                      ),
                    ],
                  ),
                ),
                RaisedButton(
                  child: Text('Add transaction'),
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).textTheme.button.color,
                  onPressed: _submitTransaction,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _presentDatePicker() {
     showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now()).then((date) {
          if(date == null) {
            return;
          }
          setState(() {
            selectedDate = date;
          });
     });
  }

  void _submitTransaction() {
    var title = titleInputController.text;
    var amount = double.parse(amountInputController.text);
    if (title.isNotEmpty && amount >= 0 && selectedDate != null) {
      widget._addTransaction(title, amount, selectedDate);
      Navigator.of(context).pop();
    }
  }
}

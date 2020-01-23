import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function(String txTitle, double txAmount) _addTransaction;

  NewTransaction(this._addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleInputController = TextEditingController();
  final amountInputController = TextEditingController();

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
                    onSubmitted: (_) => submitTransaction()),
                FlatButton(
                  child: Text('Add transaction'),
                  textColor: Colors.purple,
                  onPressed: submitTransaction,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void submitTransaction() {
    var title = titleInputController.text;
    var amount = double.parse(amountInputController.text);
    if (title.isNotEmpty && amount >= 0) {
      widget._addTransaction(title, amount);
      Navigator.of(context).pop();
    }
  }
}

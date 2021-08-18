import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionAdd extends StatefulWidget {
  final Function addTransBtnCallBack;

  TransactionAdd(this.addTransBtnCallBack);

  @override
  _TransactionAddState createState() => _TransactionAddState();
}

class _TransactionAddState extends State<TransactionAdd> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _dateSelected;

  void _submitData() {
    if (_amountController.text.isEmpty) return;

    var title = _titleController.text;
    var amount = double.parse(_amountController.text);

    if (title.isEmpty || amount < 0 || _dateSelected == null) return;

    widget.addTransBtnCallBack(title, amount, _dateSelected);

    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime.now(),
    ).then((datePicked) {
      if (datePicked == null) return;
      setState(() {
        _dateSelected = datePicked;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Title",
              ),
              controller: _titleController,
              keyboardType: TextInputType.text,
              onSubmitted: (_) => _submitData(),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(labelText: "Account"),
              controller: _amountController,
              keyboardType:
                  TextInputType.numberWithOptions(signed: false, decimal: true),
              onSubmitted: (value) => _submitData(),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  _dateSelected == null
                      ? "No Date Selected!"
                      : "Date: ${DateFormat.yMMMd().format(_dateSelected!)}",
                ),
                TextButton(
                  onPressed: _showDatePicker,
                  child: Text(
                    "Choose Date",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
                onPressed: _submitData, child: Text("Add Expenses")),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_flutter/models/transaction_data_model.dart';

class TransactionList extends StatelessWidget {
  final List<TransactionDataModel> transactionList;
  final Function _deleteTransactionCallBack;

  TransactionList(this.transactionList, this._deleteTransactionCallBack);

  @override
  Widget build(BuildContext context) {
    return transactionList.isEmpty
        ? Column(
            children: [
              Text(
                "No transaction added yet!",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 16),
              Container(
                height: 200,
                child: Image.asset(
                  "assets/images/waiting.png",
                  fit: BoxFit.cover,
                ),
              )
            ],
          )
        : ListView.builder(
            itemCount: transactionList.length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.all(8.0),
                elevation: 5,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                        child: Text(
                          "\$${transactionList[index].amount.toStringAsFixed(2)}",
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    transactionList[index].title,
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.start,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transactionList[index].date),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    color: Theme.of(context).accentColor,
                    onPressed: () => _deleteTransactionCallBack(transactionList[index].id),
                  ),
                ),
              );
            },
          );
  }
}

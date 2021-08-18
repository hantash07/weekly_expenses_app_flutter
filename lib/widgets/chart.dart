import 'package:flutter/material.dart';
import 'package:personal_expenses_flutter/models/transaction_data_model.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_flutter/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<TransactionDataModel> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      //If the index is 0 the weekday will return today date
      //If its 1 it will return yesterday date and so on
      final weekDay = DateTime.now().subtract(Duration(days: index));
      final day = DateFormat.E().format(weekDay).substring(0, 1);
      var totalAmount = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        var transaction = recentTransactions[i];
        if (transaction.date.day == weekDay.day &&
            transaction.date.month == weekDay.month &&
            transaction.date.year == weekDay.year) {
          totalAmount += transaction.amount;
        }
      }

      return {"day": day, "amount": totalAmount};
    });
  }

  double get totalAmountPerWeek {
    return groupedTransactionValues.fold(0.0, (previousValue, item) {
      return previousValue + double.parse(item['amount'].toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      margin: EdgeInsets.all(16),
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            var day = data["day"].toString();
            var amount = double.parse(data["amount"].toString());
            var percentage =
                (totalAmountPerWeek == 0.0) ? 0.0 : amount / totalAmountPerWeek;
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(day, amount, percentage),
            );
          }).toList(),
        ),
      ),
    );
  }
}

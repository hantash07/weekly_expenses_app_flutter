// import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personal_expenses_flutter/widgets/chart.dart';
import 'package:personal_expenses_flutter/widgets/transaction_add.dart';
import 'package:personal_expenses_flutter/widgets/transaction_list.dart';

import 'models/transaction_data_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.lightGreen,
        fontFamily: "Quicksand",
        textTheme: ThemeData.light().textTheme.copyWith(
          headline6: TextStyle(
            fontFamily: "OpenSans",
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
              fontFamily: "OpenSans",
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MainPage> {
  final List<TransactionDataModel> _transactionList = [];

  List<TransactionDataModel> get _recentTransactions {
    return _transactionList.where((transaction) {
      return transaction.date
          .isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _openBottomSheet(BuildContext buildContext) {
    showModalBottomSheet(
        context: buildContext,
        builder: (builderContext) {
          return GestureDetector(
            child: TransactionAdd(_addTransaction),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _addTransaction(String title, double amount, DateTime dateAdded) {
    setState(() {
      _transactionList.add(TransactionDataModel(
          id: DateTime.now().toString(),
          title: title,
          amount: amount,
          date: dateAdded));
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactionList.removeWhere((transaction) {
        return transaction.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext buildContext) {
    var appBar = AppBar(
      title: Text("Sample App"),
    );
    var mediaQuery = MediaQuery.of(buildContext);

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.35,
              child: Chart(_recentTransactions),
            ),
            Container(
              height: (mediaQuery.size.height - appBar.preferredSize.height  - mediaQuery.padding.top) * 0.65,
              child: TransactionList(_transactionList, _deleteTransaction),
            ),
          ],
        ),
      ),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () => _openBottomSheet(context),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

import 'package:expenseapp/models/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HiveDataBase {
  //reference out box

  final _myBox = Hive.box("expense_database");

  //writing data
  void saveData(List<ExpenseItem> expenseList) {
    /*
    Hive can only store string and datetime and not custom objects it can with a bit of settings
    so lets convert expense item objects into types that can be stored in our database

    expenselist -> 2d array i.e list of list
    [ExpenseList[expenseobject(name,amount,datatime)]] -> [[name,amount,datetime],[name,amount,datetime]]

    so lets
    */

    List<List<dynamic>> formattedExpenseList = [];
    for (var expense in expenseList) {
      //converting
      List<dynamic> formattedExpense = [
        expense.name,
        expense.amount,
        expense.dateTime
      ];
      formattedExpenseList.add(formattedExpense);
    }
    _myBox.put("ALL_EXPENSES", formattedExpenseList);
  }

  //reading data

  List<ExpenseItem> readData() {
    /*
    reverse of write data
    converting from saved data to expense item ->[name,amount,datatime]
    */

    List savedExpenses = _myBox.get("ALL_EXPENSES") ?? [];
    List<ExpenseItem> expenseList = [];
    for (int i = 0; i < savedExpenses.length; i++) {
      // collect individual expense data

      String name = savedExpenses[i][0];
      String amount = savedExpenses[i][1];
      DateTime dateTime = savedExpenses[i][2];

      ExpenseItem expense = ExpenseItem(
        name: name,
        amount: amount,
        dateTime: dateTime,
      );
      expenseList.add(expense);
    }
    return expenseList;
  }
}

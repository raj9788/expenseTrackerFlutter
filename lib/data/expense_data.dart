import 'package:expenseapp/data/hive_database.dart';
import 'package:expenseapp/datetime/date_time_helper.dart';
import 'package:expenseapp/models/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseData extends ChangeNotifier {
  //list all the expenses
  List<ExpenseItem> overallExpenseList = [];

  //get the list of expenses
  List<ExpenseItem> getExpenseList() {
    return overallExpenseList;
  }

  final db = HiveDataBase();

  void prepareData() {
    //if data exist in the hive then get it
    if (db.readData().isNotEmpty) {
      overallExpenseList = db.readData();
    }
  }

  //add a new expense

  void addNewExpense(ExpenseItem item) {
    overallExpenseList.add(item);
    db.saveData(overallExpenseList);
    notifyListeners();
  }

  //delete expenses

  void deleteExpense(ExpenseItem item) {
    overallExpenseList.remove(item);
    db.saveData(overallExpenseList);
    notifyListeners();
  }

  void editExpense(ExpenseItem expense, ExpenseItem editExpense) {
    expense.name = editExpense.name;
    expense.amount = editExpense.amount;
    db.saveData(overallExpenseList);
    notifyListeners();
  }

  //get weekday from a date time object
  String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return "Mon";
      case 2:
        return "Tue";
      case 3:
        return "Wed";
      case 4:
        return "Thur";
      case 5:
        return "Fri";
      case 6:
        return "Sat";
      case 7:
        return "Sun";
      default:
        return "";
    }
  }

//get the date for the stat of the week
  DateTime? startOfWeekDate() {
    DateTime? startOfWeek;

    //get today date

    DateTime today = DateTime.now();

    //go backwards from today to find sunday
    for (int i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == "Sun") {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }
    return startOfWeek;
  }

  /*
    convert all the expenses into a bar grapf for summary
  */

  Map<String, double> calculateDailyExpenseSummary() {
    Map<String, double> dailyExpenseSummary = {};

    for (var expense in overallExpenseList) {
      String date = convertDateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount);

      if (dailyExpenseSummary.containsKey(date)) {
        double currentAmount = dailyExpenseSummary[date]!;
        currentAmount += amount;
        dailyExpenseSummary[date] = currentAmount;
      } else {
        dailyExpenseSummary.addAll({date: amount});
      }
    }

    return dailyExpenseSummary;
  }
}

import 'package:flutter/foundation.dart';
import 'package:vexpense/data/hive_database.dart';
import 'package:vexpense/datetime/date_time_helper.dart';
import 'package:vexpense/models/expense_item.dart';

class ExpenseData extends ChangeNotifier {
  // list of all expenses
  List<ExpenseItem> overallExpenseList = [];

  final db = HiveDatabase();
  void prepareData() {
    overallExpenseList = db.readData();
  }

  // get expense list
  List<ExpenseItem> getAllExpenseList() {
    return overallExpenseList;
  }

  // add new expense
  void addNewExpense(ExpenseItem newExpense) {
    overallExpenseList.add(newExpense);
    notifyListeners();
    db.saveData(overallExpenseList);
  }

  // delete expense
  void deleteExpense(ExpenseItem expense) {
    overallExpenseList.remove(expense);
    notifyListeners();
    db.saveData(overallExpenseList);
  }

  // get weekday (mon,tues,etc) from a datetime object
  String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  // GET THE DATE FOR THE start of the week(sunday)
  DateTime startOfWeekDate() {
    DateTime? startOfWeek;

    DateTime today = DateTime.now();

    for (int i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == 'Sun') {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }
    return startOfWeek!;
  }
  /*
  convert overall list of expenses into a daily expense list

  e.g. overallExpenseList = [
  [food, 2023/01/30, 10],
  [drinks, 2023/01/30, 15],
  [food, 2023/01/31, 12],
  [food, 2023/02/01, 8],
  [food, 2023/02/01, 10],
  [food, 2023/02/02, 4],
  [food, 2023/02/02, 7],
  [food, 2023/02/03, 9],
  ]

  -->

  DailyExpenseSummaryList =

  [
    [2023/01/30 : 25],
    [2023/01/31 : 12],
    [2023/02/01 : 18],
    [2023/02/02 : 11],
    [2023/02/03 : 9],
  ]

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

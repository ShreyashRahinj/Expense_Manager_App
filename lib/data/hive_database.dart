import 'package:hive_flutter/hive_flutter.dart';
import 'package:vexpense/models/expense_item.dart';

class HiveDatabase {
  final _myBox = Hive.box('Expense_Database');

  void saveData(List<ExpenseItem> allExpenses) {
    List<List<dynamic>> allExpensesFormatted = [];

    for (var expense in allExpenses) {
      List<dynamic> expenseFormatted = [
        expense.name,
        expense.amount,
        expense.dateTime,
      ];
      allExpensesFormatted.add(expenseFormatted);
    }
    _myBox.put('Expenses', allExpensesFormatted);
  }

  List<ExpenseItem> readData() {
    List savedExpenses = _myBox.get('Expenses') ?? [];
    List<ExpenseItem> allExpenses = [];

    for (int i = 0; i < savedExpenses.length; i++) {
      ExpenseItem expense = ExpenseItem(
          name: savedExpenses[i][0],
          amount: savedExpenses[i][1],
          dateTime: savedExpenses[i][2]);
      allExpenses.add(expense);
    }
    return allExpenses;
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vexpense/components/expense_summary.dart';
import 'package:vexpense/components/expense_tile.dart';
import 'package:vexpense/constants/routes.dart';
import 'package:vexpense/data/expense_data.dart';
import 'package:vexpense/datetime/date_time_helper.dart';
import 'package:vexpense/models/expense_item.dart';
import 'package:vexpense/services/auth/auth_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // text controllers
  final newExpenseNameController = TextEditingController();
  final newExpenseAmountController = TextEditingController();

  @override
  void initState() {
    Provider.of<ExpenseData>(context, listen: false).prepareData();
    super.initState();
  }

  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add new Expense'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: newExpenseNameController,
              decoration: const InputDecoration(hintText: 'Expense Name'),
            ),
            TextField(
              controller: newExpenseAmountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Amount'),
            ),
          ],
        ),
        actions: [
          MaterialButton(
            onPressed: save,
            child: const Text('Save'),
          ),
          MaterialButton(
            onPressed: cancel,
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void save() {
    try {
      if (newExpenseNameController.text.isNotEmpty &&
          newExpenseAmountController.text.isNotEmpty &&
          !int.parse(newExpenseAmountController.text).isNaN) {
        ExpenseItem newExpense = ExpenseItem(
          name: newExpenseNameController.text,
          amount: newExpenseAmountController.text,
          dateTime: DateTime.now(),
        );
        Provider.of<ExpenseData>(context, listen: false)
            .addNewExpense(newExpense);
        newExpenseAmountController.clear();
        newExpenseNameController.clear();
        Navigator.pop(context);
      }
    } on Exception {
      newExpenseAmountController.clear();
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text('Please enter a number'),
              content: Icon(Icons.emoji_emotions),
            );
          });
    }
  }

  void cancel() {
    Navigator.pop(context);
    newExpenseAmountController.clear();
    newExpenseNameController.clear();
  }

  void signOut() {
    AuthService().signOut();
    Navigator.of(context)
        .pushNamedAndRemoveUntil(toLoginPageRoute, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
        builder: (context, value, child) => Scaffold(
            appBar: AppBar(
              title: const Text('Expense'),
              backgroundColor: Theme.of(context).colorScheme.secondary,
              actions: [
                IconButton(onPressed: signOut, icon: const Icon(Icons.logout)),
              ],
            ),
            backgroundColor: Theme.of(context).colorScheme.background,
            floatingActionButton: FloatingActionButton(
              onPressed: addNewExpense,
              child: const Icon(Icons.add),
            ),
            body: ListView(
              children: [
                // weekly summary
                ExpenseSummary(
                  startOfWeek:
                      Provider.of<ExpenseData>(context).startOfWeekDate(),
                ),

                const SizedBox(
                  height: 20,
                ),
                // expense list
                SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: value.getAllExpenseList().length,
                    itemBuilder: (context, index) => ExpenseTile(
                      name: value.getAllExpenseList()[index].name,
                      date: convertDateTimeToString(
                          value.getAllExpenseList()[index].dateTime),
                      amount: value.getAllExpenseList()[index].amount,
                      time: getTimeFromDateTime(
                          value.getAllExpenseList()[index].dateTime),
                      deleteTapped: (p0) => value.deleteExpense(
                        value.getAllExpenseList()[index],
                      ),
                    ),
                  ),
                ),
              ],
            )));
  }
}

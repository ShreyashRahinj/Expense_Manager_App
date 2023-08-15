import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vexpense/bargraph/bar_graph.dart';
import 'package:vexpense/data/expense_data.dart';
import 'package:vexpense/datetime/date_time_helper.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;

  const ExpenseSummary({
    super.key,
    required this.startOfWeek,
  });

  double calculateMax(
    ExpenseData value,
    String sun,
    String mon,
    String tue,
    String wed,
    String thu,
    String fri,
    String sat,
  ) {
    double? max = 100;

    List<double> values = [
      value.calculateDailyExpenseSummary()[sun] ?? 0,
      value.calculateDailyExpenseSummary()[mon] ?? 0,
      value.calculateDailyExpenseSummary()[tue] ?? 0,
      value.calculateDailyExpenseSummary()[wed] ?? 0,
      value.calculateDailyExpenseSummary()[thu] ?? 0,
      value.calculateDailyExpenseSummary()[fri] ?? 0,
      value.calculateDailyExpenseSummary()[sat] ?? 0,
    ];

    values.sort();
    max = values.last * 1.2;
    return max == 0 ? 100 : max;
  }

  String getWeekTotal(
    ExpenseData value,
    String sun,
    String mon,
    String tue,
    String wed,
    String thu,
    String fri,
    String sat,
  ) {
    double total = 0;
    List<double> values = [
      value.calculateDailyExpenseSummary()[sun] ?? 0,
      value.calculateDailyExpenseSummary()[mon] ?? 0,
      value.calculateDailyExpenseSummary()[tue] ?? 0,
      value.calculateDailyExpenseSummary()[wed] ?? 0,
      value.calculateDailyExpenseSummary()[thu] ?? 0,
      value.calculateDailyExpenseSummary()[fri] ?? 0,
      value.calculateDailyExpenseSummary()[sat] ?? 0,
    ];

    for (int i = 0; i < values.length; i++) {
      total += values[i];
    }

    return total.toString();
  }

  @override
  Widget build(BuildContext context) {
    String sun =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 0)));
    String mon =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 1)));
    String tue =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 2)));
    String wed =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 3)));
    String thu =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 4)));
    String fri =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 5)));
    String sat =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 6)));

    return Consumer<ExpenseData>(
        builder: (context, value, child) => Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Text('Week Total'),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                        '₹ ${getWeekTotal(value, sun, mon, tue, wed, thu, fri, sat)}'),
                  ],
                ),
                SizedBox(
                  height: 200,
                  child: MyBarGraph(
                    maxY:
                        calculateMax(value, sun, mon, tue, wed, thu, fri, sat),
                    sunAmount: value.calculateDailyExpenseSummary()[sun] ?? 0,
                    monAmount: value.calculateDailyExpenseSummary()[mon] ?? 0,
                    tueAmount: value.calculateDailyExpenseSummary()[tue] ?? 0,
                    wedAmount: value.calculateDailyExpenseSummary()[wed] ?? 0,
                    thuAmount: value.calculateDailyExpenseSummary()[thu] ?? 0,
                    friAmount: value.calculateDailyExpenseSummary()[fri] ?? 0,
                    satAmount: value.calculateDailyExpenseSummary()[sat] ?? 0,
                  ),
                ),
              ],
            ));
  }
}

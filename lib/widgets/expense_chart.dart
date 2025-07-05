import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../providers/expense_provider.dart';

class ExpenseChart extends StatelessWidget {
  const ExpenseChart({super.key});

  @override
  Widget build(BuildContext context) {
    final expenses = Provider.of<ExpenseProvider>(context).expenses;

    final dataMap = <String, double>{};
    for (var e in expenses) {
      dataMap[e.category] = (dataMap[e.category] ?? 0) + e.amount;
    }

    final sections = dataMap.entries.map((e) {
      return PieChartSectionData(
        value: e.value,
        title: e.key,
        radius: 50,
      );
    }).toList();

    return PieChart(PieChartData(sections: sections));
  }
}

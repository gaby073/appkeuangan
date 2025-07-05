import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/expense_provider.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key});

  @override
  Widget build(BuildContext context) {
    final expenses = Provider.of<ExpenseProvider>(context).expenses;
    if (expenses.isEmpty) {
      return const Center(child: Text('Belum ada pengeluaran.'));
    }
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, i) {
        final e = expenses[i];
        return Card(
          child: ListTile(
            title: Text(e.title),
            subtitle:
            Text('${e.category} - ${DateFormat.yMd().format(e.date)}'),
            trailing: Text('Rp ${e.amount.toStringAsFixed(0)}'),
            onLongPress: () =>
                Provider.of<ExpenseProvider>(context, listen: false)
                    .deleteExpense(e.id),
          ),
        );
      },
    );
  }
}

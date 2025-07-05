import 'package:flutter/material.dart';
import '../widgets/expense_form.dart';
import '../widgets/expense_list.dart';
import '../widgets/expense_chart.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        centerTitle: true,
      ),
      body: Column(
        children: const [
          Expanded(flex: 1, child: ExpenseChart()),
          Expanded(flex: 2, child: ExpenseList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
            context: context,
            builder: (_) => const ExpenseForm(),
            isScrollControlled: true),
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart'; // ✅ Tambahkan ini
import '../models/expense.dart';
import '../providers/expense_provider.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({super.key});

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  String _category = 'Lainnya';

  final Uuid uuid = Uuid(); // ✅ Buat instance Uuid di sini

  void _submit() {
    final title = _titleController.text;
    final amount = double.tryParse(_amountController.text);
    if (title.isEmpty || amount == null || amount <= 0) return;

    final newExpense = Expense(
      id: uuid.v4(), // ✅ Pakai instance `uuid` yang dibuat tadi
      title: title,
      amount: amount,
      category: _category,
      date: DateTime.now(),
    );

    Provider.of<ExpenseProvider>(context, listen: false)
        .addExpense(newExpense);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Judul'),
          ),
          TextField(
            controller: _amountController,
            decoration: const InputDecoration(labelText: 'Jumlah'),
            keyboardType: TextInputType.number,
          ),
          DropdownButton<String>(
            value: _category,
            onChanged: (val) => setState(() => _category = val!),
            items: ['Makan', 'Transportasi', 'Belanja', 'Lainnya']
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
          ),
          ElevatedButton(onPressed: _submit, child: const Text('Tambah'))
        ]),
      ),
    );
  }
}

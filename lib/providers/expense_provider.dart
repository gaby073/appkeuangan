import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/expense.dart';

class ExpenseProvider with ChangeNotifier {
  List<Expense> _expenses = [];

  List<Expense> get expenses => _expenses;

  void addExpense(Expense expense) {
    _expenses.add(expense);
    saveToPrefs();
    notifyListeners();
  }

  void deleteExpense(String id) {
    _expenses.removeWhere((e) => e.id == id);
    saveToPrefs();
    notifyListeners();
  }

  double get totalExpense =>
      _expenses.fold(0, (sum, item) => sum + item.amount);

  Future<void> loadFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('expenses');
    if (data != null) {
      _expenses = (jsonDecode(data) as List)
          .map((e) => Expense.fromMap(e))
          .toList();
      notifyListeners();
    }
  }

  Future<void> saveToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
      'expenses',
      jsonEncode(_expenses.map((e) => e.toMap()).toList()),
    );
  }
}

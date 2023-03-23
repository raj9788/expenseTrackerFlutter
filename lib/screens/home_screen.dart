import 'package:expenseapp/data/expense_data.dart';
import 'package:expenseapp/models/expense_item.dart';
import 'package:expenseapp/widgets/expense_summary.dart';
import 'package:expenseapp/widgets/expense_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _expenseNameController = TextEditingController();
  final _expenseAmountController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add a new Expense'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _expenseNameController,
              decoration: InputDecoration(
                hintText: 'Add Item Name',
              ),
            ),
            TextField(
              controller: _expenseAmountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Add Item Cost (rupees)',
              ),
            ),
          ],
        ),
        actions: [
          MaterialButton(
            onPressed: save,
            child: Text('Save'),
          ),
          MaterialButton(
            onPressed: cancel,
            child: Text('Cancel'),
          )
        ],
      ),
    );
  }

  void deleteExpense(ExpenseItem expense) {
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense);
  }

  void editExpense(ExpenseItem expense) {}

  void edit() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Expense'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _expenseNameController,
              decoration: InputDecoration(
                hintText: 'Add Item Name',
              ),
            ),
            TextField(
              controller: _expenseAmountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Add Item Cost (rupees)',
              ),
            ),
          ],
        ),
        actions: [
          MaterialButton(
            onPressed: save,
            child: Text('Save'),
          ),
          MaterialButton(
            onPressed: cancel,
            child: Text('Cancel'),
          )
        ],
      ),
    );
  }

  bool canParseToDouble(String str) {
    if (str == null || str.isEmpty) {
      return false;
    }
    try {
      double.parse(str);
      return true;
    } catch (e) {
      return false;
    }
  }

  void save() {
    if (_expenseAmountController.text.isNotEmpty &&
        _expenseAmountController.text.isNotEmpty &&
        canParseToDouble(_expenseAmountController.text)) {
      ExpenseItem newExpense = ExpenseItem(
          name: _expenseNameController.text,
          amount: _expenseAmountController.text,
          dateTime: DateTime.now());
      Provider.of<ExpenseData>(context, listen: false)
          .addNewExpense(newExpense);
    }

    Navigator.pop(context);
    clearController();
  }

  void cancel() {
    Navigator.pop(context);
    clearController();
  }

  void clearController() {
    _expenseAmountController.clear();
    _expenseNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Color.fromARGB(255, 241, 239, 239),
        floatingActionButton: FloatingActionButton(
          onPressed: addNewExpense,
          backgroundColor: Colors.black,
          child: const Icon(
            Icons.add,
          ),
        ),
        body: ListView(
          //weekly summary
          children: [
            ExpenseSummary(
              startOfWeek: value.startOfWeekDate()!,
            ),
            SizedBox(
              height: 20,
            ),
            //expense list
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: value.getExpenseList().length,
              itemBuilder: (context, index) => ExpenseTile(
                name: value.getExpenseList()[index].name,
                amount: value.getExpenseList()[index].amount,
                dateTime: value.getExpenseList()[index].dateTime,
                deleteTapped: (p0) =>
                    deleteExpense(value.getExpenseList()[index]),
                editTapped: (p0) => editExpense(value.getExpenseList()[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../widget/cash_widget.dart';
import '../widget/expense_widget.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {


  @override
  Widget build(BuildContext context) {
     return const Row(
      children: [
        Expanded(
          flex: 5,
          child: ExpenseWidget(),
        ),
        SizedBox(width: 10),
        Expanded(
          flex: 5,
          child: CashWidget(),
        )
      ],
    );
  }
}

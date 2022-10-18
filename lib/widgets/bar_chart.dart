import 'package:flutter/material.dart';

class BarChart extends StatelessWidget {
  final List<double> expenses;

  BarChart(this.expenses);

  @override
  Widget build(BuildContext context) {
    double mostExpenses = 0;

    expenses.forEach((double price) {
      if (price > mostExpenses) {
        mostExpenses = price;
      }
    });

    return Column(
      children: [
        const Text(
          'Weekly Spending',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20.0,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_back),
              iconSize: 30.0,
            ),
            const Text(
              'Nov 10, 2022 - Nov 16, 2022',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_forward),
              iconSize: 30.0,
            ),
          ],
        ),
        const SizedBox(
          height: 30.0,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Bar(
                label: 'Su',
                amountSpent: expenses[0],
                mostExpensive: mostExpenses),
            Bar(
                label: 'Mo',
                amountSpent: expenses[1],
                mostExpensive: mostExpenses),
            Bar(
                label: 'Tu',
                amountSpent: expenses[2],
                mostExpensive: mostExpenses),
            Bar(
                label: 'We',
                amountSpent: expenses[3],
                mostExpensive: mostExpenses),
            Bar(
                label: 'Th',
                amountSpent: expenses[4],
                mostExpensive: mostExpenses),
            Bar(
                label: 'Fr',
                amountSpent: expenses[5],
                mostExpensive: mostExpenses),
            Bar(
                label: 'Sa',
                amountSpent: expenses[6],
                mostExpensive: mostExpenses),
          ],
        ),
      ],
    );
  }
}

class Bar extends StatelessWidget {
  final String label;
  final double amountSpent;
  final double mostExpensive;
  final double _maxBarHeight = 150.0;

  Bar(
      {required this.label,
      required this.amountSpent,
      required this.mostExpensive});

  @override
  Widget build(BuildContext context) {
    final barHeight = amountSpent / mostExpensive * _maxBarHeight;
    return Column(
      children: [
        Text(
          '\$${amountSpent.toStringAsFixed(2)}',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 6.0,
        ),
        Container(
          height: barHeight,
          width: 18.0,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(6.0),
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }
}

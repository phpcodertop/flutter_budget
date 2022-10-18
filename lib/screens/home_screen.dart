import 'package:flutter/material.dart';
import 'package:flutter_budget/helpers/color_helper.dart';
import 'package:flutter_budget/screens/category_screen.dart';

import '../data/data.dart';
import '../models/category_model.dart';
import '../models/expense_model.dart';
import '../widgets/bar_chart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  _buildCategory(Category category, totalAmountSpent) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CategoryScreen(category: category,))),
      child: Container(
        width: double.infinity,
        height: 100.0,
        padding: const EdgeInsets.all(20.0),
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12, offset: Offset(0, 2), blurRadius: 6.0)
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  category.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  '\$${totalAmountSpent.toStringAsFixed(2)} / \$${category.maxAmount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constrains) {
              final double maxBarWidth = constrains.maxWidth;
              final double percent =
                  (category.maxAmount - totalAmountSpent) / category.maxAmount;

              double barWidth = percent * maxBarWidth;

              if (barWidth < 0) {
                barWidth = 0;
              }


              return Stack(
                children: [
                  Container(
                    height: 20.0,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  Container(
                    height: 20.0,
                    width: barWidth,
                    decoration: BoxDecoration(
                      color: getColor(context, percent),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  Positioned(
                    left: maxBarWidth / 2,
                    top: 3,
                    child: Text(
                      '${(percent * 100).toStringAsFixed(2)}%',
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 100.0,
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.settings),
              iconSize: 30.0,
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add),
                iconSize: 30.0,
              ),
            ],
            floating: true,
            forceElevated: true,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text('Simple Budget'),
              centerTitle: true,
            ),
          ),
          SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              if (index == 0) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 2),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  margin: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  padding: const EdgeInsets.all(20.0),
                  child: BarChart(weeklySpending),
                );
              }
              final Category category = categories[index - 1];
              double totalAmountSpent = 0;
              category.expenses.forEach((Expense expense) {
                totalAmountSpent += expense.cost;
              });

              return _buildCategory(category, totalAmountSpent);
            }, childCount: 1 + categories.length),
          ),
        ],
      ),
    );
  }
}

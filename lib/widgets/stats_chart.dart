import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import '../models/expense.dart';
import '../models/expense_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatsChart extends StatefulWidget {
  final List<Expense> expenses;
  StatsChart({this.expenses});
  @override
  _StatsChartState createState() => _StatsChartState();

  static List<charts.Series<Category, int>> _createSampleData({
    var food,
    var tran,
    var edu,
    var shop,
    var ent,
    var oth,
  }) {
    final data = [
      new Category(0, food ?? 100, charts.MaterialPalette.blue.shadeDefault),
      new Category(1, tran ?? 100, charts.MaterialPalette.yellow.shadeDefault),
      new Category(2, edu ?? 100, charts.MaterialPalette.pink.shadeDefault),
      new Category(3, shop ?? 100, charts.MaterialPalette.red.shadeDefault),
      new Category(4, ent ?? 100, charts.MaterialPalette.teal.shadeDefault),
      new Category(5, oth ?? 100, charts.MaterialPalette.green.shadeDefault),
    ];

    return [
      new charts.Series<Category, int>(
        id: 'Sales',
        domainFn: (Category category, _) => category.id,
        measureFn: (Category category, _) => category.amount,
        colorFn: (Category category, _) => category.color,
        data: data,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (Category row, _) =>
            '₹ ${NumberFormat.compact().format(row.amount)}',
        outsideLabelStyleAccessorFn: (Category row, _) => charts.TextStyleSpec(
          color: charts.Color.white,
          fontSize: 14,
          fontFamily: "OpenSans",
        ),
        insideLabelStyleAccessorFn: (Category row, _) => charts.TextStyleSpec(
          color: charts.Color.black,
          fontSize: 14,
          fontFamily: "OpenSans",
        ),
      )
    ];
  }
}

class _StatsChartState extends State<StatsChart> {
  @override
  Widget build(BuildContext context) {
    ExpenseData _data = Provider.of<ExpenseData>(context);
    var food = _data
        .totalExpenseByCategory(
          ExpenseCategory.FOOD,
          widget.expenses,
        )
        .toInt();
    var tran = _data
        .totalExpenseByCategory(
          ExpenseCategory.TRANSPORT,
          widget.expenses,
        )
        .toInt();
    var educ = _data
        .totalExpenseByCategory(
          ExpenseCategory.EDUCATION,
          widget.expenses,
        )
        .toInt();
    var shop = _data
        .totalExpenseByCategory(
          ExpenseCategory.SHOPPING,
          widget.expenses,
        )
        .toInt();
    var ente = _data
        .totalExpenseByCategory(
          ExpenseCategory.ENTERTAINMENT,
          widget.expenses,
        )
        .toInt();
    var othe = _data
        .totalExpenseByCategory(
          ExpenseCategory.OTHERS,
          widget.expenses,
        )
        .toInt();
    return new charts.PieChart(
      StatsChart._createSampleData(
        food: food,
        tran: tran,
        edu: educ,
        shop: shop,
        ent: ente,
        oth: othe,
      ),
      animate: true,
      defaultRenderer: new charts.ArcRendererConfig(
        arcWidth: 100,
        arcRendererDecorators: [new charts.ArcLabelDecorator()],
      ),
    );
  }
}

class Category {
  final int id;
  final int amount;
  final charts.Color color;

  Category(this.id, this.amount, this.color);
}

import 'package:charts_flutter/flutter.dart' as charts;
import '../models/expense_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ExpenseData _provider = Provider.of<ExpenseData>(context);
    var monthsExpense = _provider.totalOfMonth.toInt() ?? 100;
    var weeksExpense = _provider.totalOfWeek.toInt() ?? 100;
    var yearsExpense = _provider.totalOfYear.toInt() ?? 100;
    var daysExpenses = _provider.totalOfDay.toInt() ?? 100;

    return new charts.PieChart(
      _createSampleData(
        year: yearsExpense,
        month: monthsExpense,
        week: weeksExpense,
        day: daysExpenses,
      ),
      animate: true,
      defaultRenderer: new charts.ArcRendererConfig(
        arcWidth: 80,
        arcRendererDecorators: [
          new charts.ArcLabelDecorator(),
        ],
      ),
    );
  }

  static List<charts.Series<GaugeSegment, String>> _createSampleData(
      {var month, var week, var year, var day}) {
    final data = [
      new GaugeSegment(
          'Year \n $year', year, charts.Color.fromHex(code: '#C2185B')),
      new GaugeSegment(
          'Month \n $month', month, charts.Color.fromHex(code: '#EC407A')),
      new GaugeSegment(
          'Week \n $week', week, charts.Color.fromHex(code: '#F48FB1')),
      new GaugeSegment(
          'Day \n $day', day, charts.Color.fromHex(code: '#FCE4EC')),
    ];

    return [
      new charts.Series<GaugeSegment, String>(
        id: 'Segments',
        domainFn: (GaugeSegment segment, _) => segment.segment,
        measureFn: (GaugeSegment segment, _) => segment.size,
        colorFn: (GaugeSegment segment, _) => segment.color,
        labelAccessorFn: (GaugeSegment segment, _) =>
            '${segment.segment.substring(0, 1)}: ₹${segment.size}',
        data: data,
        outsideLabelStyleAccessorFn: (GaugeSegment segment, _) =>
            charts.TextStyleSpec(
          color: charts.Color.white,
          fontSize: 14,
          fontFamily: "OpenSans",
        ),
        insideLabelStyleAccessorFn: (GaugeSegment segment, _) =>
            charts.TextStyleSpec(
          color: charts.Color.white,
          fontSize: 12,
          fontFamily: "OpenSans",
        ),
      )
    ];
  }
}

class GaugeSegment {
  final String segment;
  final int size;
  final charts.Color color;

  GaugeSegment(this.segment, this.size, this.color);
}

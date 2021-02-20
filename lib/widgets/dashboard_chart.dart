/// Donut chart with labels example. This is a simple pie chart with a hole in
/// the middle.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:expensive/models/expense_data.dart';
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
      // Configure the width of the pie slices to 60px. The remaining space in
      // the chart will be left as a hole in the center.
      //
      // [ArcLabelDecorator] will automatically position the label inside the
      // arc if the label will fit. If the label will not fit, it will draw
      // outside of the arc with a leader line. Labels can always display
      // inside or outside using [LabelPosition].
      //
      // Text style for inside / outside can be controlled independently by
      // setting [insideLabelStyleSpec] and [outsideLabelStyleSpec].
      //
      // Example configuring different styles for inside/outside:
      //       new charts.ArcLabelDecorator(
      //          insideLabelStyleSpec: new charts.TextStyleSpec(...),
      //          outsideLabelStyleSpec: new charts.TextStyleSpec(...)),
      defaultRenderer: new charts.ArcRendererConfig(
        arcWidth: 80,
        arcRendererDecorators: [
          new charts.ArcLabelDecorator(),
        ],
      ),
    );
  }

  /// Create one series with sample hard coded data.
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

/// Sample data type.
class GaugeSegment {
  final String segment;
  final int size;
  final charts.Color color;

  GaugeSegment(this.segment, this.size, this.color);
}

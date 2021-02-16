/// Donut chart with labels example. This is a simple pie chart with a hole in
/// the middle.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:expensive/models/expense.dart';
import 'package:expensive/models/expense_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardChart extends StatelessWidget {
  // final List<charts.Series> seriesList;
  // final bool animate;

  // DashboardChart(this.seriesList, {this.animate});

  // /// Creates a [PieChart] with sample data and no transition.
  // factory DashboardChart.withSampleData() {
  //   return new DashboardChart(
  //     _createSampleData(),
  //     // Disable animations for image tests.
  //     animate: true,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    ExpenseData _provider = Provider.of<ExpenseData>(context);
    List<Expense> _list = _provider.expensesOfMonth();
    var monthsExpense = _provider.totalOfMonth;
    var weeksExpense = _provider.totalOfWeek;
    // print(monthsExpense);
    return new charts.PieChart(
      _createSampleData(month: monthsExpense, week: weeksExpense),
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
      {var month, var week, var year}) {
    final data = [
      new GaugeSegment(
          'Year', year ?? 200, charts.Color.fromHex(code: '#ed2c66')),
      new GaugeSegment(
          'Month', month ?? 150, charts.Color.fromHex(code: '#ef4477')),
      new GaugeSegment(
          'Week', week ?? 100, charts.Color.fromHex(code: '#f37399')),
    ];

    return [
      new charts.Series<GaugeSegment, String>(
        id: 'Segments',
        domainFn: (GaugeSegment segment, _) => segment.segment,
        measureFn: (GaugeSegment segment, _) => segment.size,
        colorFn: (GaugeSegment segment, _) => segment.color,
        data: data,
      )
    ];
  }
}

/// Sample data type.
class GaugeSegment {
  final String segment;
  final double size;
  final charts.Color color;

  GaugeSegment(this.segment, this.size, this.color);
}

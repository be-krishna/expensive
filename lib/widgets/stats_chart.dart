/// Bar chart example
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class StatsChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  StatsChart(this.seriesList, {this.animate});

  /// Creates a stacked [BarChart] with sample data and no transition.
  factory StatsChart.withSampleData() {
    return new StatsChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: animate,
      barGroupingType: charts.BarGroupingType.stacked,
    );
  }

  /// Create series list with multiple series
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final foodsAndDrinks = [
      new OrdinalSales('Week', 5, charts.MaterialPalette.blue.shadeDefault),
      new OrdinalSales('Month', 25, charts.MaterialPalette.blue.shadeDefault),
      new OrdinalSales('Year', 100, charts.MaterialPalette.blue.shadeDefault),
    ];

    final transport = [
      new OrdinalSales('Week', 15, charts.MaterialPalette.yellow.shadeDefault),
      new OrdinalSales('Month', 20, charts.MaterialPalette.yellow.shadeDefault),
      new OrdinalSales('Year', 80, charts.MaterialPalette.yellow.shadeDefault),
    ];

    final education = [
      new OrdinalSales('Week', 50, charts.MaterialPalette.pink.shadeDefault),
      new OrdinalSales('Month', 30, charts.MaterialPalette.pink.shadeDefault),
      new OrdinalSales('Year', 40, charts.MaterialPalette.pink.shadeDefault),
    ];
    final shopping = [
      new OrdinalSales('Week', 50, charts.MaterialPalette.red.shadeDefault),
      new OrdinalSales('Month', 30, charts.MaterialPalette.red.shadeDefault),
      new OrdinalSales('Year', 40, charts.MaterialPalette.red.shadeDefault),
    ];
    final entertainment = [
      new OrdinalSales('Week', 50, charts.MaterialPalette.teal.shadeDefault),
      new OrdinalSales('Month', 30, charts.MaterialPalette.teal.shadeDefault),
      new OrdinalSales('Year', 40, charts.MaterialPalette.teal.shadeDefault),
    ];
    final others = [
      new OrdinalSales('Week', 50, charts.MaterialPalette.green.shadeDefault),
      new OrdinalSales('Month', 30, charts.MaterialPalette.green.shadeDefault),
      new OrdinalSales('Year', 40, charts.MaterialPalette.green.shadeDefault),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Food',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        colorFn: (OrdinalSales sales, _) => sales.color,
        data: foodsAndDrinks,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Transport',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        colorFn: (OrdinalSales sales, _) => sales.color,
        data: transport,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Education',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        colorFn: (OrdinalSales sales, _) => sales.color,
        data: education,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Shopping',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        colorFn: (OrdinalSales sales, _) => sales.color,
        data: shopping,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Entertainment',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        colorFn: (OrdinalSales sales, _) => sales.color,
        data: entertainment,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Others',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        colorFn: (OrdinalSales sales, _) => sales.color,
        data: others,
      ),
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;
  final charts.Color color;

  OrdinalSales(this.year, this.sales, this.color);
}

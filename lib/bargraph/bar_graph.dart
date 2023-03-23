import 'package:expenseapp/bargraph/bar_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyBarGraph extends StatelessWidget {
  final double? maxY;
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thurAmount;
  final double friAmount;
  final double satAmount;

  const MyBarGraph(
      {super.key,
      required this.maxY,
      required this.sunAmount,
      required this.monAmount,
      required this.tueAmount,
      required this.wedAmount,
      required this.thurAmount,
      required this.friAmount,
      required this.satAmount});

  @override
  Widget build(BuildContext context) {
    BarData MyBarData = BarData(
      sunAmount: sunAmount,
      monAmount: monAmount,
      tueAmount: tueAmount,
      wedAmount: wedAmount,
      thurAmount: thurAmount,
      friAmount: friAmount,
      satAmount: satAmount,
    );

    MyBarData.initializeBarData();

    return BarChart(
      BarChartData(
        maxY: 1000,
        minY: 0,
        titlesData: FlTitlesData(
            show: true,
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: getBottomTitles,
              ),
            )),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          drawHorizontalLine: false,
        ),
        borderData: FlBorderData(show: false),
        barGroups: MyBarData.barData
            .map(
              (data) => BarChartGroupData(
                x: data.x,
                barRods: [
                  BarChartRodData(
                    toY: data.y,
                    color: Colors.black,
                    width: 40,
                    borderRadius: BorderRadius.circular(4),
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      toY: maxY,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}

Widget getBottomTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 15,
  );
  Widget text;
  if (value.toInt() == 0) {
    text = const Text(
      'Sun',
      style: style,
    );
  } else if (value.toInt() == 1) {
    text = const Text(
      'Mon',
      style: style,
    );
  } else if (value.toInt() == 2) {
    text = const Text(
      'Tue',
      style: style,
    );
  } else if (value.toInt() == 3) {
    text = const Text(
      'Wed',
      style: style,
    );
  } else if (value.toInt() == 4) {
    text = const Text(
      'Thur',
      style: style,
    );
  } else if (value.toInt() == 5) {
    text = const Text(
      'Fri',
      style: style,
    );
  } else if (value.toInt() == 6) {
    text = const Text(
      'Sat',
      style: style,
    );
  } else {
    text = const Text(
      '',
      style: style,
    );
  }
  return SideTitleWidget(child: text, axisSide: meta.axisSide);
}

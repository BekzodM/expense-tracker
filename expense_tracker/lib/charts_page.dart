import 'package:expense_tracker/get_cloud_data.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:expense_tracker/indicator.dart';
import 'get_cloud_data.dart';

final colorSet = [
  const Color.fromRGBO(155, 95, 224, 1),
  const Color.fromRGBO(22, 164, 216, 1),
  const Color.fromRGBO(96, 219, 232, 1),
  const Color.fromRGBO(139, 211, 70, 1),
  const Color.fromRGBO(239, 223, 72, 1),
  const Color.fromRGBO(249, 165, 44, 1),
  const Color.fromRGBO(214, 78, 18, 1),
];

class ChartsPage extends StatefulWidget {
  final List<String> expense;

  final VoidCallback updateParentState;

  const ChartsPage(
      {Key? key, required this.expense, required this.updateParentState})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => Chart2State();
}

class Chart2State extends State<ChartsPage> {
  int touchedIndex = -1;

  void updateState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //final screenWidth = MediaQuery.of(context).size.width;
    //final screenHeight = MediaQuery.of(context).size.height;

    //final chartWidth = screenWidth * 0.3;
    //final chartHeight = screenHeight * 0.3;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: AspectRatio(
        aspectRatio: 1.0,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = 700.0;
            final chartWidth = constraints.maxWidth < maxWidth
                ? constraints.maxWidth
                : maxWidth;
            final chartHeight = chartWidth * 0.7;
            final centerSpaceRadius = chartWidth * 0.15;
            return Row(
              children: <Widget>[
                /* const SizedBox(
                  height: 18,
                ), */
                Expanded(
                  child: Container(
                    width: chartWidth,
                    height: chartHeight,
                    child: PieChart(
                      PieChartData(
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: centerSpaceRadius,
                        sections: showingSections(chartWidth),
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: showingIndicators(),
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections(double chartWidth) {
    return List.generate(7, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 22.0 : 14.0;
      final radius = isTouched
          ? chartWidth * 0.15
          : chartWidth * 0.1;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      return PieChartSectionData(
        color: colorSet[i],
        value: double.parse(double.parse(widget.expense[i * 2 + 1]).toStringAsFixed(2)),
        title: double.parse(widget.expense[i * 2 + 1]).toStringAsFixed(2),
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          decoration: TextDecoration.none,
          shadows: shadows,
        ),
      );
    });
  }
}

List<Widget> showingIndicators() {
  List<Widget> indicators = [];

  for (int i = 0; i < 7; i++) {
    indicators.add(
      Indicator(
          color: colorSet[i],
          text: userExpenseByCategory[i * 2],
          isSquare: true),
    );
    if (i != 6) {
      indicators.add(const SizedBox(
        height: 4,
      ));
    } else {
      indicators.add(const SizedBox(
        height: 20,
      ));
    }
  }

  return indicators;
}

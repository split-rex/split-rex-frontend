import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:split_rex/src/common/functions.dart';
import 'package:split_rex/src/providers/statisticsprovider.dart';
import 'package:split_rex/src/services/statistics.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:split_rex/src/common/globals.dart' as globals;

import '../services/statistics.dart';

class StatisticsHeader extends ConsumerWidget {
  const StatisticsHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          PercentageChart(),
          SizedBox(
            height: 10,
          ),
          ChartTotalExpenses(),
          SizedBox(
            height: 10,
          ),
          MutationSettled(),
          SizedBox(
            height: 10,
          ),
          TopSpendingBuddies(),
        ],
      ),
    );
  }
}

class PercentageChart extends ConsumerWidget {
  const PercentageChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        width: MediaQuery.of(context).size.width - 55.0,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          // border: Border.all(color: const Color(0XFF6DC7BD), width: 1.0),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 10),
              blurRadius: 50,
              color: Color(0xffEEEEEE),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Your Split-rex Personality",
              style: TextStyle(fontSize: 13),
            ),
            Text(
              ref.watch(statisticsProvider).lentPercentage < 50
                  ? "Si Tukang Ngutang"
                  : ref.watch(statisticsProvider).lentPercentage == 50
                      ? "Si Paling Balance"
                      : "Si Murah Hati",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 200,
              height: 200,
              child: PieChart(PieChartData(
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 1,
                  sections: [
                    PieChartSectionData(
                        value: ref
                            .watch(statisticsProvider)
                            .lentPercentage
                            .toDouble(),
                        title:
                            "Lent\n${ref.watch(statisticsProvider).lentPercentage}%",
                        titleStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                        color: const Color(0xFF44A4B2)),
                    PieChartSectionData(
                      value: ref
                          .watch(statisticsProvider)
                          .owedPercentage
                          .toDouble(),
                      title:
                          "Owed\n${ref.watch(statisticsProvider).owedPercentage}%",
                      color: const Color(0xFF6DC7BD),
                      titleStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ])),
            ),
            const SizedBox(
              height: 25,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  style: const TextStyle(
                      fontSize: 12,
                      color: Color(0XFF4f4f4f),
                      fontWeight: FontWeight.w400),
                  children: [
                    TextSpan(
                      text: ref.watch(statisticsProvider).lentPercentage < 50
                          ? "Si Tukang Ngutang "
                          : ref.watch(statisticsProvider).lentPercentage == 50
                              ? "Si Paling Balance "
                              : "Si Murah Hati ",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0XFF4f4f4f),
                      ),
                    ),
                    TextSpan(
                      text: ref.watch(statisticsProvider).lentPercentage < 50
                          ? "are the ones who owe more than they lend. It is strongly advised for these types of people to pay up and not ghost their debtors!"
                          : ref.watch(statisticsProvider).lentPercentage == 50
                              ? "are those who have discovered peace and balance. You have mastered the art of zen in the universe of debts. Way to go."
                              : "are those who resemble Nelson Mandela. They are willing to help others in need without asking for anything in return (just kidding, don’t forget to pay these people back please).",
                      style: const TextStyle(
                        color: Color(0XFF4f4f4f),
                      ),
                    ),
                  ]),
            )
          ],
        ));
  }
}

class ChartTotalExpenses extends ConsumerWidget {
  const ChartTotalExpenses({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    globals.maxExpense =
        findLargest(ref.watch(statisticsProvider).expenseChart.dailyExpense);
    globals.numberofDays =
        ref.watch(statisticsProvider).expenseChart.dailyExpense.length;
    return Container(
        width: MediaQuery.of(context).size.width - 55.0,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          // border: Border.all(color: const Color(0XFF6DC7BD), width: 1.0),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 10),
              blurRadius: 50,
              color: Color(0xffEEEEEE),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Total expenses across all group",
              style: TextStyle(fontSize: 13),
            ),
            Text(
              "Rp${formatDouble(nearestTenMultiple(globals.maxExpense))}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 300,
              height: 250,
              child: LineChart(
                LineChartData(
                  minX: 0,
                  maxX: globals.numberofDays.toDouble()-1,
                  minY: 0,
                  maxY: 5,
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        interval: 1,
                        getTitlesWidget: bottomTitleWidgets,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        getTitlesWidget: leftTitleWidgets,
                        reservedSize: 40,
                      ),
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: true,
                    horizontalInterval: 1,
                    verticalInterval: 1,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: const Color(0xff37434d),
                        strokeWidth: 0.35,
                      );
                    },
                    getDrawingVerticalLine: (value) {
                      return FlLine(
                        color: const Color(0xff37434d),
                        strokeWidth: 0.35,
                      );
                    },
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(
                      color: const Color(0xffC4C4C4),
                      width: 1,
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: getSpots(ref
                          .watch(statisticsProvider)
                          .expenseChart
                          .dailyExpense),

                      isCurved: false,
                      dotData: FlDotData(show: false),
                      gradient: const LinearGradient(colors: [
                        Color(0xff23b6e6),
                        Color(0xff02d39a),
                      ]),
                      barWidth: 3,
                      // dotData: FlDotData(show: false),
                    ),
                  ],
                ),
              ),
            )
            // TODO: update chart here
          ],
        ));
  }
}

List<FlSpot> getSpots(List<double> data) {
  List<FlSpot> spots = [];
  for (int i = 0; i < data.length; i++) {
    spots.add(FlSpot(i.toDouble(), data[i] / nearestTenMultiple(globals.maxExpense) * 5));
  }
  return spots;
}

class TopSpendingBuddies extends ConsumerWidget {
  const TopSpendingBuddies({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        width: MediaQuery.of(context).size.width - 55.0,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          // border: Border.all(color: const Color(0XFF6DC7BD), width: 1.0),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 10),
              blurRadius: 50,
              color: Color(0xffEEEEEE),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Top 3 Spending Buddies",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Based on mutual groups",
              style: TextStyle(fontSize: 13),
            ),

            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 300,
              height: 300,
              child: BarChart(BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  barTouchData: BarTouchData(
                      enabled: false,
                      touchTooltipData: BarTouchTooltipData(
                        tooltipBgColor: Colors.transparent,
                        tooltipPadding: EdgeInsets.zero,
                        tooltipMargin: 8,
                        getTooltipItem: (
                          BarChartGroupData group,
                          int groupIndex,
                          BarChartRodData rod,
                          int rodIndex,
                        ) {
                          return BarTooltipItem(
                              rod.toY.round().toString() == "10"
                                  ? ref
                                      .watch(statisticsProvider)
                                      .spendingBuddies[2]
                                      .name
                                  : rod.toY.round().toString() == "30"
                                      ? ref
                                          .watch(statisticsProvider)
                                          .spendingBuddies[0]
                                          .name
                                      : rod.toY.round().toString() == "20"
                                          ? ref
                                              .watch(statisticsProvider)
                                              .spendingBuddies[1]
                                              .name
                                          : "",
                              const TextStyle(
                                color: Color(0XFF4f4f4f),
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: rod.toY.round().toString() == "10"
                                      ? "\n${ref.watch(statisticsProvider).spendingBuddies[2].count} groups"
                                      : rod.toY.round().toString() == "30"
                                          ? "\n${ref.watch(statisticsProvider).spendingBuddies[0].count} groups"
                                          : rod.toY.round().toString() == "20"
                                              ? "\n${ref.watch(statisticsProvider).spendingBuddies[1].count} groups"
                                              : "",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 10,
                                  ),
                                )
                              ]);
                        },
                      )),
                  maxY: 37,
                  minY: 0,
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        getTitlesWidget: getTitles,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  barGroups: [
                    BarChartGroupData(
                      x: 0,
                      barRods: [
                        BarChartRodData(
                          toY: ref
                                      .watch(statisticsProvider)
                                      .spendingBuddies[2]
                                      .name !=
                                  ""
                              ? 10
                              : 0,
                          color: const Color(0xff60D5C0),
                        )
                      ],
                      showingTooltipIndicators: [0],
                    ),
                    BarChartGroupData(
                      x: 1,
                      barRods: [
                        BarChartRodData(
                          toY: ref
                                      .watch(statisticsProvider)
                                      .spendingBuddies[0]
                                      .name !=
                                  ""
                              ? 30
                              : 0,
                          color: const Color(0xff44A4B2),
                        )
                      ],
                      showingTooltipIndicators: [0],
                    ),
                    BarChartGroupData(
                      x: 2,
                      barRods: [
                        BarChartRodData(
                            toY: ref
                                        .watch(statisticsProvider)
                                        .spendingBuddies[1]
                                        .name !=
                                    ""
                                ? 20
                                : 0,
                            color: const Color(0xff45B5AF))
                      ],
                      showingTooltipIndicators: [0],
                    ),
                  ])),
            )
            // TODO: update chart here
          ],
        ));
  }
}

Widget getTitles(double value, TitleMeta meta) {
  final style = const TextStyle(
    color: Color(0XFF4f4f4f),
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
  String text;
  switch (value.toInt()) {
    case 0:
      text = '3';
      break;
    case 1:
      text = '1';
      break;
    case 2:
      text = '2';
      break;
    default:
      text = '';
      break;
  }
  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 0,
    child: Text(text, style: style),
  );
}

Widget bottomTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
  Widget text;

  if (value.toInt() == 0) {
    text = const Text('1', style: style);
  } else if (value.toInt() == globals.numberofDays-1) {
    text = Text(globals.numberofDays.toString(), style: style);
  } else if (value.toInt() == (globals.numberofDays-1)~/2) {
    text =  Text((globals.numberofDays~/2).toString(), style: style);
  } else {
    text = const Text('', style: style);
  }

  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: text,
  );
}

Widget leftTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 15,
  );
  String text;
  switch (value.toInt()) {
    case 1:
      text = abbreviateNumber((nearestTenMultiple(globals.maxExpense)/5));
      break;
    case 3:
      text = abbreviateNumber((nearestTenMultiple(globals.maxExpense)/5)*3);
      break;
    case 5:
      text = abbreviateNumber(nearestTenMultiple(globals.maxExpense));

      break;
    default:
      return Container();
  }

  return Text(text, style: style, textAlign: TextAlign.left);
}

class MutationUnsettled extends ConsumerWidget {
  const MutationUnsettled({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: MediaQuery.of(context).size.width - 55,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        // border: Border.all(color: const Color(0XFF6DC7BD), width: 1.0),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 50,
            color: Color(0xffEEEEEE),
          ),
        ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text("See mutations for unsettled payments"),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
                child: GestureDetector(
                    onTap: () async {
                      DateTime? pickeddate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101));

                      if (pickeddate != null) {
                        ref
                            .read(statisticsProvider)
                            .changeStartUnsettledDate(pickeddate.toString());
                      }

                      if (ref.watch(statisticsProvider).endUnsettledDate !=
                              "" &&
                          ref.watch(statisticsProvider).startUnsettledDate !=
                              "") {
                        ref.read(statisticsProvider).changeShowUnsettled(true);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, left: 15, right: 10),
                      decoration: BoxDecoration(
                        // border: Border.all(color: const Color(0XFF6DC7BD), width: 1.0),
                        color: const Color(0xFFEFEFEF),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 50,
                            color: Color(0xffEEEEEE),
                          ),
                        ],
                      ),
                      child: Text(
                        ref.watch(statisticsProvider).startUnsettledDate == ""
                            ? "Select Start Date"
                            : formatDate(ref
                                .watch(statisticsProvider)
                                .startUnsettledDate),
                        style: const TextStyle(
                          fontSize: 11.0, // Change the font size as desired
                        ),
                      ),
                    ))),
            const Text(
              "-",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 18, letterSpacing: 20),
            ),
            Expanded(
                child: GestureDetector(
              onTap: () async {
                DateTime? pickeddate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101));

                if (pickeddate != null) {
                  ref
                      .read(statisticsProvider)
                      .changeEndUnsettledDate(pickeddate.toString());
                }

                if (ref.watch(statisticsProvider).endUnsettledDate != "" &&
                    ref.watch(statisticsProvider).startUnsettledDate != "") {
                  await StatisticsServices().paymentMutation(ref);
                  ref.read(statisticsProvider).changeShowUnsettled(true);
                }
              },
              child: Container(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 15, right: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFEFEF),
                  // border: Border.all(color: const Color(0XFF6DC7BD), width: 1.0),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Color(0xffEEEEEE),
                    ),
                  ],
                ),
                child: Text(
                  ref.watch(statisticsProvider).endUnsettledDate == ""
                      ? "Select End Date"
                      : formatDate(
                          ref.watch(statisticsProvider).endUnsettledDate),
                  style: const TextStyle(
                    fontSize: 11.0, // Change the font size as desired
                  ),
                ),
              ),
            )),
          ],
        ),
        Visibility(
          visible: ref.watch(statisticsProvider).showUnsettled,
          child: const SizedBox(height: 20),
        ),
        Visibility(
          visible: ref.watch(statisticsProvider).showUnsettled,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Total Paid ",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Color(0XFF4F4F4F),
                        )),
                    SizedBox(width: 10),
                    Text("Rp. 300.000.000 ",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Color(0xffFF0000),
                        ))
                  ]),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Total Received ",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Color(0XFF4F4F4F),
                        )),
                    SizedBox(width: 10),
                    Text("Rp. 150.500.000 ",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Color(0xFF4F9A99),
                        ))
                  ])
            ],
          ),
        ),
        Visibility(
          visible: ref.watch(statisticsProvider).showUnsettled,
          child: const SizedBox(height: 30),
        ),
        Visibility(
          visible: ref.watch(statisticsProvider).showUnsettled,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Initicon(
                  text: "Ubaidillah Ariq",
                  size: 40,
                  backgroundColor: getProfileBgColor(1),
                  style: TextStyle(color: getProfileTextColor(1)),
                ),
                const SizedBox(width: 10),
                const Text("Ubaidillah ",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Color(0XFF4F4F4F),
                    ))
              ]),
              RichText(
                text: const TextSpan(
                  text: "Rp 60.000",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF4F9A99),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
        ),
        Visibility(
          visible: ref.watch(statisticsProvider).showUnsettled,
          child: const SizedBox(height: 10),
        ),
        Visibility(
          visible: ref.watch(statisticsProvider).showUnsettled,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Initicon(
                  text: "Ubaidillah Ariq",
                  size: 40,
                  backgroundColor: getProfileBgColor(1),
                  style: TextStyle(color: getProfileTextColor(1)),
                ),
                const SizedBox(width: 10),
                const Text("Ubaidillah ",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Color(0XFF4F4F4F),
                    ))
              ]),
              RichText(
                text: const TextSpan(
                  text: "Rp 60.000",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF4F9A99),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
        ),
        Visibility(
          visible: ref.watch(statisticsProvider).showUnsettled,
          child: const SizedBox(height: 10),
        ),
        Visibility(
          visible: ref.watch(statisticsProvider).showUnsettled,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Initicon(
                  text: "Ubaidillah Ariq",
                  size: 40,
                  backgroundColor: getProfileBgColor(1),
                  style: TextStyle(color: getProfileTextColor(1)),
                ),
                const SizedBox(width: 10),
                const Text("Ubaidillah ",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Color(0XFF4F4F4F),
                    ))
              ]),
              RichText(
                text: const TextSpan(
                  text: "Rp 60.000",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF4F9A99),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}

class MutationSettled extends ConsumerWidget {
  const MutationSettled({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: MediaQuery.of(context).size.width - 55,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        // border: Border.all(color: const Color(0XFF6DC7BD), width: 1.0),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 50,
            color: Color(0xffEEEEEE),
          ),
        ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text("See mutations for settled payments"),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
                child: GestureDetector(
                    onTap: () async {
                      DateTime? pickeddate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101));

                      if (pickeddate != null) {
                        ref
                            .read(statisticsProvider)
                            .changeStartSettleDate(pickeddate.toString());
                      }

                      if (ref.watch(statisticsProvider).endSettleDate != "" &&
                          ref.watch(statisticsProvider).startSettleDate != "") {
                        ref.read(statisticsProvider).changeShowSettled(true);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, left: 15, right: 10),
                      decoration: BoxDecoration(
                        // border: Border.all(color: const Color(0XFF6DC7BD), width: 1.0),
                        color: const Color(0xFFEFEFEF),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 50,
                            color: Color(0xffEEEEEE),
                          ),
                        ],
                      ),
                      child: Text(
                        ref.watch(statisticsProvider).startSettleDate == ""
                            ? "Select Start Date"
                            : formatDate(
                                ref.watch(statisticsProvider).startSettleDate),
                        style: const TextStyle(
                          fontSize: 11.0, // Change the font size as desired
                        ),
                      ),
                    ))),
            const Text(
              "-",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 18, letterSpacing: 20),
            ),
            Expanded(
                child: GestureDetector(
              onTap: () async {
                DateTime? pickeddate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101));

                if (pickeddate != null) {
                  ref
                      .read(statisticsProvider)
                      .changeEndSettleDate(pickeddate.toString());
                }

                if (ref.watch(statisticsProvider).endSettleDate != "" &&
                    ref.watch(statisticsProvider).startSettleDate != "") {
                  await StatisticsServices().paymentMutation(ref);
                  ref.read(statisticsProvider).changeShowSettled(true);
                }
              },
              child: Container(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 15, right: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFEFEF),
                  // border: Border.all(color: const Color(0XFF6DC7BD), width: 1.0),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Color(0xffEEEEEE),
                    ),
                  ],
                ),
                child: Text(
                  ref.watch(statisticsProvider).endSettleDate == ""
                      ? "Select End Date"
                      : formatDate(ref.watch(statisticsProvider).endSettleDate),
                  style: const TextStyle(
                    fontSize: 11.0, // Change the font size as desired
                  ),
                ),
              ),
            )),
          ],
        ),
        Visibility(
          visible: ref.watch(statisticsProvider).showSettled,
          child: const SizedBox(height: 20),
        ),
        Visibility(
          visible: ref.watch(statisticsProvider).showSettled,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text("Total Paid ",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Color(0XFF4F4F4F),
                    )),
                const SizedBox(width: 10),
                Text(
                    "Rp.${formatDouble(ref.watch(statisticsProvider).paymentMutation.totalPaid)}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Color(0xffFF0000),
                    ))
              ]),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text("Total Received ",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Color(0XFF4F4F4F),
                    )),
                const SizedBox(width: 10),
                Text(
                    "Rp.${formatDouble(ref.watch(statisticsProvider).paymentMutation.totalReceived)}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Color(0xFF4F9A99),
                    ))
              ])
            ],
          ),
        ),
        Visibility(
          visible: ref.watch(statisticsProvider).showSettled,
          child: ListView.builder(
            key: UniqueKey(),
            shrinkWrap: true,
            itemCount: ref
                .watch(statisticsProvider)
                .paymentMutation
                .listMutation
                .length, // specify the number of items in the list
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        Initicon(
                          text: ref
                              .watch(statisticsProvider)
                              .paymentMutation
                              .listMutation[index]
                              .name,
                          size: 40,
                          backgroundColor: getProfileBgColor(ref
                              .watch(statisticsProvider)
                              .paymentMutation
                              .listMutation[index]
                              .color),
                          style: TextStyle(
                              color: getProfileTextColor(ref
                                  .watch(statisticsProvider)
                                  .paymentMutation
                                  .listMutation[index]
                                  .color)),
                        ),
                        const SizedBox(width: 10),
                        Text(
                            ref
                                .watch(statisticsProvider)
                                .paymentMutation
                                .listMutation[index]
                                .name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Color(0XFF4F4F4F),
                            ))
                      ]),
                      RichText(
                        text: TextSpan(
                          text:
                              "Rp.${formatDouble(ref.watch(statisticsProvider).paymentMutation.listMutation[index].amount)}",
                          style: TextStyle(
                            fontSize: 14,
                            color: ref
                                        .watch(statisticsProvider)
                                        .paymentMutation
                                        .listMutation[index]
                                        .mutationType ==
                                    "RECEIVED"
                                ? const Color(0xFF4F9A99)
                                : const Color(0xffFF0000),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                ],
              );
            },
          ),
        ),
      ]),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatisticsHeader extends ConsumerWidget {
  const StatisticsHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          ChartTotalExpenses(),
          SizedBox(
            height: 10,
          ),
          Mutation()
        ],
      ),
    );
  }
}

class ChartTotalExpenses extends ConsumerWidget {
  const ChartTotalExpenses({super.key});

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
              "Total expenses acroll all group",
              style: TextStyle(fontSize: 13),
            ),
            const Text(
              "Rp 6.750.000",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            // TODO: update chart here
            SfCartesianChart()
          ],
        ));
  }
}

class Mutation extends ConsumerWidget {
  const Mutation({super.key});

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
                    child: Container(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 35, right: 35),
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
              child: const Text("28 Feb 2023"),
            ))),
            const Text(
              "-",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 18, letterSpacing: 20),
            ),
            Expanded(
                child: GestureDetector(
              child: Container(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 35, right: 35),
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
                child: const Text("20 Mar 2023"),
              ),
            )),
          ],
        ),

        
      ]),
    );
  }
}

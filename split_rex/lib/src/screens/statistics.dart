import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/widgets/statistics.dart';
import '../common/header.dart';

import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class Statistics extends ConsumerWidget {
  const Statistics({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return header(
      context,
      ref,
      "Detailed Report",
      "home",
      const StatisticsHeader()
    );
  }
}

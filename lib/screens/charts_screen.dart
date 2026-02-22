import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../theme/glass_theme.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartsScreen extends StatefulWidget {
  const ChartsScreen({super.key});

  @override
  State<ChartsScreen> createState() => _ChartsScreenState();
}

class _ChartsScreenState extends State<ChartsScreen> {
  late List<ChartData> _chartData;
  late TrackballBehavior _trackballBehavior;

  @override
  void initState() {
    _chartData = getChartData();
    _trackballBehavior = TrackballBehavior(
      enable: true,
      activationMode: ActivationMode.singleTap,
      tooltipSettings: const InteractiveTooltip(enable: true, format: 'point.x : point.y'),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EURUSD, H1'),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.plus_square, color: GlassTheme.iosBlue),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(CupertinoIcons.layers, color: GlassTheme.iosBlue),
            onPressed: () {},
          ),
        ],
      ),
      body: SfCartesianChart(
        trackballBehavior: _trackballBehavior,
        series: <CandleSeries<ChartData, DateTime>>[
          CandleSeries<ChartData, DateTime>(
            dataSource: _chartData,
            name: 'EURUSD',
            xValueMapper: (ChartData data, _) => data.x,
            lowValueMapper: (ChartData data, _) => data.low,
            highValueMapper: (ChartData data, _) => data.high,
            openValueMapper: (ChartData data, _) => data.open,
            closeValueMapper: (ChartData data, _) => data.close,
            enableSolidCandles: true,
            bearColor: GlassTheme.iosRed,
            bullColor: GlassTheme.iosBlue,
          ),
        ],
        primaryXAxis: DateTimeAxis(
          intervalType: DateTimeIntervalType.hours,
          majorGridLines: const MajorGridLines(width: 0),
        ),
        primaryYAxis: NumericAxis(
          opposedPosition: true,
          majorGridLines: MajorGridLines(
            width: 0.5,
            color: Colors.grey.withValues(alpha: 0.2),
          ),
        ),
      ),
    );
  }

  List<ChartData> getChartData() {
    return [
      ChartData(DateTime(2024, 2, 23, 10), 1.0840, 1.0855, 1.0835, 1.0850),
      ChartData(DateTime(2024, 2, 23, 11), 1.0850, 1.0860, 1.0845, 1.0852),
      ChartData(DateTime(2024, 2, 23, 12), 1.0852, 1.0855, 1.0830, 1.0835),
      ChartData(DateTime(2024, 2, 23, 13), 1.0835, 1.0845, 1.0830, 1.0842),
      ChartData(DateTime(2024, 2, 23, 14), 1.0842, 1.0850, 1.0840, 1.0847),
      ChartData(DateTime(2024, 2, 23, 15), 1.0847, 1.0855, 1.0845, 1.0853),
      ChartData(DateTime(2024, 2, 23, 16), 1.0853, 1.0865, 1.0850, 1.0860),
    ];
  }
}

class ChartData {
  ChartData(this.x, this.open, this.high, this.low, this.close);
  final DateTime x;
  final double open;
  final double high;
  final double low;
  final double close;
}

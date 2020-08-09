import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';

class SubscriberSeries {
  final String month;
  final int subscribers;
  final charts.Color barColor;

  SubscriberSeries(
      {@required this.month,
      @required this.subscribers,
      @required this.barColor});
}

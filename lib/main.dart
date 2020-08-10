import 'package:flutter/material.dart';
import 'package:hematin/add_expense_view.dart';
import 'package:hematin/database/database.dart';
import 'package:hematin/set_limit.dart';
import 'package:provider/provider.dart';
import 'package:hematin/subscriber_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:hematin/subscriber_series.dart';
import 'package:hematin/expense.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (BuildContext context) => AppDatabase(),
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: MyHomePage(
            title: 'Hemat.IN',
            context: context,
          )),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, @required this.context}) : super(key: key);

  final String title;
  final BuildContext context;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  dynamic database;
  int state;

  final List<SubscriberSeries> data = [
    SubscriberSeries(
      month: "Jan",
      subscribers: 5000000,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    SubscriberSeries(
      month: "Feb",
      subscribers: 11000000,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    SubscriberSeries(
      month: "Mar",
      subscribers: 12000000,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    SubscriberSeries(
      month: "Apr",
      subscribers: 10000000,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    SubscriberSeries(
      month: "May",
      subscribers: 8500000,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    SubscriberSeries(
      month: "Jun",
      subscribers: 7700000,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    SubscriberSeries(
      month: "Jul",
      subscribers: 7600000,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    SubscriberSeries(
      month: "Aug",
      subscribers: 5500000,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    SubscriberSeries(
      month: "Sep",
      subscribers: 2500000,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    SubscriberSeries(
      month: "Oct",
      subscribers: 700000,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    SubscriberSeries(
      month: "Nov",
      subscribers: 4300000,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    SubscriberSeries(
      month: "Dec",
      subscribers: 1300000,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
  ];

  @override
  void initState() {
    super.initState();
    database = Provider.of<AppDatabase>(context, listen: false);
    state = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            FutureBuilder(
              future: database.getAllExpenses(),
              builder:
                  (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    final allExpense = snapshot.data;
                    // TODO
                    
                  },
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    FutureBuilder(
                      future: database.getLimit(),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (!snapshot.hasData || snapshot.data.length == 0) {
                          return Text("No Limit Has Set");
                        } else {
                          return Text(
                              "Limit : " + snapshot.data[0].limit.toString());
                        }
                      },
                    ),
                    RaisedButton(
                      child: Text("Set Limit"),
                      onPressed: () async {
                        final limits = await database.getLimit();
                        Limit limit;
                        if (limits.length == 0) {
                          limit = null;
                        } else {
                          limit = limits[0];
                        }
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SetLimit(
                                    limit: limit,
                                  )),
                        );
                        setState(() {
                          state = result;
                        });
                      },
                    ),
                    RaisedButton(
                        child: Text('Pengeluaran'),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Pengeluaran()));
                        })
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddExpense()),
          );
        },
        tooltip: 'Tambah pengeluaran',
        child: Icon(Icons.add),
      ),
    );
  }
}

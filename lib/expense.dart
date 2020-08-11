import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

import 'database/database.dart';

class Pengeluaran extends StatefulWidget {
  @override
  _PengeluaranState createState() => _PengeluaranState();
}

class _PengeluaranState extends State<Pengeluaran> {
  dynamic database;
  @override
  void initState() {
    database = Provider.of<AppDatabase>(context, listen: false);
  }

  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengeluaran'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Bulan Ini', style: Theme.of(context).textTheme.headline3),
            Card(
                child: Container(
              padding: EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Jumlah : ",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30),
                  ),
                  StreamBuilder(
                    stream: database.watchAllExpenses(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      final allExpense = snapshot.data;

                      if (allExpense.length == 0) {
                        return Text("No Expense");
                      } else {
                        double butuhCount = 0;
                        double inginCount = 0;
                        for (int i = 0; i < allExpense.length; i++) {
                          if (allExpense[i].category == "Butuh") {
                            butuhCount += 1;
                          } else {
                            inginCount += 1;
                          }
                        }
                        Map<String, double> dataMap = new Map();
                        dataMap.putIfAbsent("Butuh", () => butuhCount);
                        dataMap.putIfAbsent("Ingin", () => inginCount);
                        return Container(
                          margin: EdgeInsets.only(bottom: 32),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 300,
                                width: 300,
                                child: PieChart(
                                    dataMap: dataMap,
                                    chartType: ChartType.disc),
                              ),
                              Container(
                                  margin: EdgeInsets.only(bottom: 16),
                                  child: Text("Butuh : " +
                                      butuhCount.round().toString())),
                              Text("Ingin : " + inginCount.round().toString()),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                  Text(
                    "Total Pengeluaran : ",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30),
                  ),
                  StreamBuilder(
                    stream: database.watchAllExpenses(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      final allExpense = snapshot.data;

                      if (allExpense.length == 0) {
                        return Text("No Expense");
                      } else {
                        double butuhCount = 0;
                        double inginCount = 0;
                        for (int i = 0; i < allExpense.length; i++) {
                          if (allExpense[i].category == "Butuh") {
                            butuhCount += allExpense[i].amount;
                          } else {
                            inginCount += allExpense[i].amount;
                          }
                        }
                        Map<String, double> dataMap = new Map();
                        dataMap.putIfAbsent("Butuh", () => butuhCount);
                        dataMap.putIfAbsent("Ingin", () => inginCount);
                        return Container(
                          margin: EdgeInsets.only(bottom: 32),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 300,
                                width: 300,
                                child: PieChart(
                                    dataMap: dataMap,
                                    chartType: ChartType.disc),
                              ),
                              Container(
                                  margin: EdgeInsets.only(bottom: 16),
                                  child: Text("Total Butuh : " +
                                      butuhCount.round().toString())),
                              Text("Total Ingin : " +
                                  inginCount.round().toString()),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                  StreamBuilder(
                    stream: database.watchAllExpenses(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot1) {
                      final allExpense = snapshot1.data;
                      int total = 0;
                      for (int i = 0; i < allExpense.length; i++) {
                        total += allExpense[i].amount;
                      }
                      return FutureBuilder(
                        future: database.getLimit(),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot2) {
                          final limits = snapshot2.data;
                          if (limits.length == 0) {
                            return Text("No Limit is Set");
                          } else {
                            final limit = limits[0].limit;
                            return Text(
                              "Total : " + total.toString(),
                              style: TextStyle(
                                  color: total > limit
                                      ? Colors.red
                                      : Colors.green),
                            );
                          }
                        },
                      );
                    },
                  )

                  //DISINI BUAT YANG PIE CHART
                ],
              ),
            )),
            Card(
                //FOR FUNCTION, ITERATE ON THIS getThisMonthExpenses
                child: StreamBuilder(
              stream: database.watchAllExpenses(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                final allExpense = snapshot.data;
                if (allExpense.length == 0) {
                  return Text("No Expense");
                } else {
                  List<DataRow> dataRowList = List<DataRow>();
                  for (int i = 0; i < allExpense.length; i++) {
                    final expense = allExpense[i];
                    DataRow dataRow = DataRow(cells: <DataCell>[
                      DataCell(Text(expense.title)),
                      DataCell(Text(expense.amount.toString())),
                      DataCell(Text(expense.date.toString())),
                      DataCell(Text(
                        expense.category,
                        style: TextStyle(
                            fontWeight: expense.category == "Ingin"
                                ? FontWeight.bold
                                : FontWeight.normal),
                      )),
                      DataCell(RaisedButton(
                        onPressed: () async {
                          await database.deleteExpense(expense);
                        },
                        child:Text("Delete")
                      ),
                      
                      )
                    ]);
                    dataRowList.add(dataRow);
                  }
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: <DataColumn>[
                        DataColumn(label: Text("Title")),
                        DataColumn(label: Text("Amount")),
                        DataColumn(label: Text("Date")),
                        DataColumn(label: Text("Jenis")),
                        DataColumn(label: Text("Delete")),
                      ],
                      rows: dataRowList,
                    ),
                  );
                }
              },
            )),
          ],
        ),
      ),
    );
  }
}

class SingleChildLayoutView {}

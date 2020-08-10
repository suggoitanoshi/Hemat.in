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
                  FutureBuilder(
                    future: database.getAllExpenses(),
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
                        return SizedBox(
                          height: 300,
                          width: 300,
                          child: PieChart(
                              dataMap: dataMap, chartType: ChartType.disc),
                        );
                      }
                    },
                  ),
                  Text(
                    "Total Pengeluaran : ",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30),
                  ),
                  FutureBuilder(
                    future: database.getAllExpenses(),
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
                        return SizedBox(
                          height: 300,
                          width: 300,
                          child: PieChart(
                              dataMap: dataMap, chartType: ChartType.disc),
                        );
                      }
                    },
                  ),

                  //DISINI BUAT YANG PIE CHART
                ],
              ),
            )),
            Card(
                //FOR FUNCTION, ITERATE ON THIS getThisMonthExpenses
                child: FutureBuilder(
              future: database.getAllExpenses(),
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
                    ]);
                    dataRowList.add(dataRow);
                  }
                  return DataTable(
                    columns: <DataColumn>[
                      DataColumn(label: Text("Title")),
                      DataColumn(label: Text("Amount")),
                      DataColumn(label: Text("Date")),
                      DataColumn(label: Text("Jenis")),
                    ],
                    rows: dataRowList,
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

import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class Pengeluaran extends StatelessWidget {
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
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //DISINI BUAT YANG PIE CHART
              ],
            )),
            Card(
                //FOR FUNCTION, ITERATE ON THIS getThisMonthExpenses
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                  Text('Nama', style: Theme.of(context).textTheme.headline6),
                  Text('Sifat', style: Theme.of(context).textTheme.headline6),
                  Text('Harga', style: Theme.of(context).textTheme.headline6)
                ])),
          ],
        ),
      ),
    );
  }
}

class SingleChildLayoutView {}

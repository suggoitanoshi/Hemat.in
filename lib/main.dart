import 'package:flutter/material.dart';
import 'package:hematin/add_expense_view.dart';
import 'package:hematin/database/database.dart';
import 'package:hematin/set_limit.dart';
import 'package:provider/provider.dart';

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
            Card(
                child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Text(
                    'Insight',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
            )),
            Card(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Evaluasi',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ],
                ),
              ),
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
                            if(!snapshot.hasData || snapshot.data.length == 0){
                              return Text("No Limit Has Set");
                            }else{
                              return Text("Limit : " + snapshot.data[0].limit.toString());
                            }
                          },
                    ),
                    RaisedButton(
                      child: Text("Set Limit"),
                      onPressed: () async{
                        final limits = await database.getLimit();
                        Limit limit;
                        if(limits.length == 0) {
                          limit = null;
                        }else{
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
                    )
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

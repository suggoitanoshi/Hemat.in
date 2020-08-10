import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'database/database.dart';

class SetLimit extends StatefulWidget {
  SetLimit({Key key, @required this.limit}) : super(key: key);
  Limit limit;
  @override
  _SetLimitState createState() => _SetLimitState();
}

class _SetLimitState extends State<SetLimit> {
  TextEditingController _controller;
  @override
  void initState(){
    _controller = TextEditingController();
  }
  void setLimit(Limit newLimit){
    setState(() {
      widget.limit = newLimit;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Set Limit"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            widget.limit == null ? Text("No Limit Has Set") : Text("Current Limit : " + widget.limit.limit.toString()),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                icon: Icon(Icons.attach_money),
                hintText: "Limit",
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly,
              ],
            ),
            RaisedButton(
              onPressed: () async {
                final database = Provider.of<AppDatabase>(context,listen: false);
                
                if(widget.limit == null){
                  final newLimit = Limit(limit: int.parse(_controller.text)); 
                  setLimit(newLimit);
                  await database.addLimit(newLimit);
                }else{
                  setLimit(widget.limit.copyWith(limit:int.parse(_controller.text)));
                  await database.setLimit(widget.limit.copyWith(limit:int.parse(_controller.text)));
                }
                Navigator.pop(context,1);
                
              },
              child: Text("Set New Limit"),
            )
          ],
        ),
      ),
    );
  }
}

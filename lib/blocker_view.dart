import 'package:flutter/material.dart';

class BlockerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              child: Text(
                'Are you sure you want to open that app?',
                style: TextStyle(
                  fontSize: 32,
                ),
              ),
              padding: EdgeInsets.all(20),
            ),
            Text(''),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  onPressed: (){},
                  child: Text('Yes')
                ),
                RaisedButton(
                  onPressed: (){},
                  child: Text('No')
                )
              ],
            )
          ],
        )
      ),
    );
  }

}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddExpense extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return AddExpenseState();
  }
}

enum Jenis { butuh, ingin }

class AddExpenseState extends State<AddExpense>{
  final _formKey = GlobalKey<FormState>();
  Jenis _jenis = Jenis.butuh;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Pengeluaran'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.attach_money),
                  hintText: "Jumlah pengeluaran",
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly,
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Radio(
                        value: Jenis.butuh,
                        groupValue: _jenis,
                        onChanged: (Jenis j){
                          setState((){ _jenis = j; });
                        },
                      ),
                      Text('Butuh'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Radio(
                        value: Jenis.ingin,
                        groupValue: _jenis,
                        onChanged: (Jenis j){
                          setState((){ _jenis = j; });
                        },
                      ),
                      Text('Ingin'),
                    ],
                  ),
                ],
              ),
              RaisedButton(
                child: Text('Add!'),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
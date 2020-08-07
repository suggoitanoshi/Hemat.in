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
  TextEditingController _titleController;
  TextEditingController _amountController;
  Jenis _jenis = Jenis.butuh;
  @override
  void initState(){
    _titleController = TextEditingController();
    _amountController = TextEditingController();
  }
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
                controller: _titleController,
                decoration: InputDecoration(
                  icon: Icon(Icons.title),
                  hintText: "Judul Pengeluaran",
                ),
              ),
              TextField(
                controller: _amountController,
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
                onPressed: () async {
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
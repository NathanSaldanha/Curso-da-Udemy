import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados:";

  void _reset() {
    pesoController.text = "";
    alturaController.text = "";

    setState(() {
      _infoText = "Informe seus dados:";
      _formKey = GlobalKey<FormState>();
    });
  }
  void _calcular(){
    setState(() {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text)/100;
      double imc = peso / (altura*altura);
      if(imc < 18.6){
        _infoText="Abaixo do peso seu imc é:(${imc.toStringAsPrecision(3)})";
      }
      else if(imc>24.9){
        _infoText="Acima do peso seu imc é:(${imc.toStringAsPrecision(3)})";
      }
      else{
        _infoText=("Peso ideal, seu imc é (${imc.toStringAsPrecision(3)})");
      }
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora IMC",
              style: TextStyle(color: Colors.redAccent)),
          centerTitle: true,
          backgroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              color: Colors.black,
              onPressed: _reset,
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(
                  Icons.person,
                  size: 120.0,
                  color: Colors.black,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Peso (kg)",
                      labelStyle: TextStyle(color: Colors.red)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 25.0),
                  controller: pesoController,
                  validator: (value){
                    if(value.isEmpty){
                      return "Insira seu peso!";
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Altura (cm)",
                      labelStyle: TextStyle(color: Colors.red, fontSize: 25.0)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 25.0),
                  controller: alturaController,
                  validator: (value){
                    if(value.isEmpty){
                      return "Insira sua altura!";
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Container(
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: (){
                        if(_formKey.currentState.validate()){
                          _calcular();
                        }
                      },
                      child: Text(
                        "Calcular",
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                      color: Colors.red,
                    ),
                  ),
                ),
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                )
              ],
            ),
          ),
        ));
  }
}

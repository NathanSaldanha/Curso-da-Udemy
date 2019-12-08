import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance?format=json-cors&key=0476c8b6";

void main() async {
  runApp(MaterialApp(
    home: Home(),
  ));
}

Future<Map> getMoedas() async {
  http.Response resposta = await http.get(request);
  return json.decode(resposta.body);

  /*  print(resposta.body);
  print(resposta.statusCode);
  dynamic r = json.decode(resposta.body);
  print(r["results"]["currencies"]["USD"]["buy"]); */
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController realController = TextEditingController();
  TextEditingController dolarController = TextEditingController();

  double dolarRequisicao;
  double realRequisicao;

  void atualizaDolar(String valorReal){
    double real = double.parse(valorReal);

    dolarController.text = (real/ this.dolarRequisicao).toStringAsFixed(2);
  }
  void atualizaReal(String valorDolar){
    double dolar = double.parse(valorDolar);

    realController.text = (dolar * this.dolarRequisicao).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        title: Text("\$ Conversor \$"),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: getMoedas(),
          builder: (contexto, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: Text(
                    "Carregando dados...",
                    style: TextStyle(color: Colors.white),
                  ),
                );

              default:
                if (snapshot.hasError) {
                  return Center(
                      child: Text("Erro ao carregar dados...",
                          style: TextStyle(color: Colors.white)));
                } else {
                  dolarRequisicao = snapshot.data["results"]["currencies"]["USD"]["buy"];

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Icon(Icons.monetization_on,
                            size: 150.0, color: Colors.white),
                        getTextField("Real", "R\$", realController, atualizaDolar),
                        getTextField("Dolar", "USD", dolarController, atualizaReal),
                      ],
                    ),
                  );
                }
            }
          }),
    );
  }
}

Widget getTextField(String label, String prefix, TextEditingController controlador, Function f){

  return TextField(
    controller: controlador,
    onChanged: f,
    decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white),
        prefixText: "R\$",
        border: OutlineInputBorder()
    ),
  );
}
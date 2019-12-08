import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = "https://api.hgbrasil.com/weather?woeid=457396&key=1d09881c";

void main() async {
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(hintColor: Colors.black, primaryColor: Colors.black),
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final cityController= TextEditingController();
  final diaController= TextEditingController();
  final temController= TextEditingController();

  String city;
  dynamic dia;
  dynamic temp;

  void _cityChanged(String text){

    cityController.text= city;
    diaController.text = dia;
    temController.text = temp.toString();

  }
  void _diaChanged(String text){

    cityController.text= city;
    diaController.text = dia;
    temController.text = temp.toString();
  }
  void _temChanged(String text){
    cityController.text= city;
    diaController.text = dia;
    temController.text = temp.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        title: Text("Clima"),
        backgroundColor: Colors.amberAccent,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
          future: getData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                    child: Text(
                  "Carregando dados...",
                  style: TextStyle(color: Colors.amberAccent, fontSize: 25.0),
                  textAlign: TextAlign.center,
                ));
              default:
                if (snapshot.hasError) {
                  return Center(
                      child: Text(
                    "Erro ao carregar dados.",
                    style: TextStyle(color: Colors.amberAccent, fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ));
                } else {
                  dia = snapshot.data["results"]["date"];
                  temp = snapshot.data["results"]["temp"];
                  city = snapshot.data["results"]["city_name"];

                  return SingleChildScrollView(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Icon(
                           Icons.settings_system_daydream,
                          size: 150.0,
                          color: Colors.white,
                        ),
                        buildTextField("Cidade", cityController,_cityChanged),
                        Divider(),
                        buildTextField("dia", diaController, _diaChanged),
                        Divider(),
                        buildTextField("Temperatura", temController,_temChanged),
                      ],
                    ),
                  );
                }
            }
          }),
    );
  }
}
Widget buildTextField(String label, TextEditingController c, Function f){
  return  TextField(
    controller: c,
    decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.amberAccent),
    ),
    style: TextStyle(
        color: Colors.amberAccent, fontSize: 25.0
    ),
    onChanged: f,
    keyboardType: TextInputType.text,
  );

}
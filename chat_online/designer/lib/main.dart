import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    title: "Teste de tela",
    home: Home(),

  ));
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        color: Color(0xFFd44a59),
        child: Positioned(
            top: 200,
            child: Text(
             'asdas'
        )),
      ),
      
    );
  }
}



import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    title: "Contador de pessoas",
    home :Home()
  )
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _people = 0;
  String _infText = "Pode entrar";

  void changedPeople(int num){
    setState(() {
      _people +=num;
      if(_people>0 && _people<=10){
        _infText = "Pode entrar";
      }
      if(_people<0){
        _infText="Numero invalido";
        _people = 0;
      }
      if(_people>10){
        _infText="Esgotado";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset("images/restaurant.jpg",
          fit: BoxFit.cover,
          height: 1000.0,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Pessoas: $_people",
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child:FlatButton(
                    child: Text("+1",
                      style: TextStyle(fontSize: 40.0, color: Colors.white),
                    ),
                    onPressed: (){
                      changedPeople(1);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child:FlatButton(
                    child: Text("-1",
                      style: TextStyle(fontSize: 40.0, color: Colors.white),
                    ),
                    onPressed: (){
                      changedPeople(-1);
                    },
                  ),
                ),
              ],
            ),
            Text(
              "$_infText",
              style: TextStyle(color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontSize: 30.0),
            )

          ],
        )
      ],
    );
  }
}

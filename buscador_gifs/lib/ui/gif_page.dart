import 'package:flutter/material.dart';
import 'package:share/share.dart';



//como não iremos interagir com a página, com relação a armazenar conteúdo, atualizar estado, nada muda aqui
//stateless
class GifPage extends StatelessWidget {

  //a ideia é que a gente receba qual o gif , estamos na outra tela e quando formos para essa seja passado o gif
  final Map _gifData; //esse atributo representa um GIF lá do JSON que veio da requisição, por isso que é um MAP

  //através do construtor
  GifPage(this._gifData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_gifData["title"]),//TODO colocar titulo
        backgroundColor: Colors.black,
        actions: <Widget>[//adicionar botoes na appBar
          IconButton(//um botão que é um icone de compartilhamento
            icon: Icon(Icons.share),
            onPressed: (){// para compartilhar já existe um plugin de compartilhamento: Share (adicionado no pubspec.yaml)
              Share.share(_gifData["images"]["fixed_height_still"]["url"]);//passar URL do GIF //TODO colocar url
            },
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Image.network(_gifData["images"]["fixed_height_still"]["url"]),//TODO colocar url
      ),
    );
  }
}


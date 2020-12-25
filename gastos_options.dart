import 'package:despesas_galinhas/ui/Gastos/GastosAnimais/despesas_ui.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/Erick/AndroidStudioProjects/despesas_galinhas/lib/ui/Class/size_config.dart';
import 'package:despesas_galinhas/ui/Gastos/GastosFGM/gastosFGM.dart';
import 'package:despesas_galinhas/ui/Gastos/outros/outrosGastos.dart';
import 'package:despesas_galinhas/ui/home_page.dart';
import 'package:despesas_galinhas/ui/Class/reset_Data.dart';
import 'package:flutter/cupertino.dart';
enum ResetGastos{resetGAnimais, resetFGM,resetOutros}

class GastoOptions extends StatefulWidget {
  @override
  _GastoOptionsState createState() => _GastoOptionsState();
}

class _GastoOptionsState extends State<GastoOptions> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.brown,
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        actions: [
          PopupMenuButton<ResetGastos>(
            itemBuilder: (context) => <PopupMenuEntry<ResetGastos>>[
              const PopupMenuItem(child:
               Text("Resetar dados da Alimentação Geral"),
                value: ResetGastos.resetGAnimais,
              ),
              const PopupMenuItem(
                  child: Text("Resetar dados dos Gastos Gerais"),
                value: ResetGastos.resetFGM,
              ),
              const PopupMenuItem(
                  child: Text("Resetar dados dos Outros"),
                value: ResetGastos.resetOutros,
              )
            ],
            onSelected: _resetList,
          )
        ],
        title: Text("Gastos",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 2.5 * SizeConfig.blockSizeVertical),textScaleFactor: 1,),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 12 * SizeConfig.blockSizeVertical,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 9 * SizeConfig.blockSizeVertical,
                  decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(width: 2.0, style: BorderStyle.solid),
                          borderRadius: BorderRadius.all(Radius.circular(30.0))
                      )
                  ),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DespesasUI()));
                    },
                    child: Text("Alimentação Animal",
                      textScaleFactor: 1,
                      style: TextStyle(color: Colors.white70, fontSize: 2.5 * SizeConfig.blockSizeVertical),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 10 * SizeConfig.blockSizeVertical,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 9 * SizeConfig.blockSizeVertical,
                  decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(width: 2.0, style: BorderStyle.solid),
                          borderRadius: BorderRadius.all(Radius.circular(30.0))
                      )
                  ),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => GastosFGM()));
                    },
                    child: Text("Gastos Gerais",
                      textScaleFactor: 1,
                      style: TextStyle(color: Colors.white70, fontSize: 2.5 * SizeConfig.blockSizeVertical),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 10 * SizeConfig.blockSizeVertical,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 9 * SizeConfig.blockSizeVertical,
                  decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(width: 2.0, style: BorderStyle.solid),
                          borderRadius: BorderRadius.all(Radius.circular(30.0))
                      )
                  ),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => OutrosGastos()));
                    },
                    child: Text("Outros",
                      textScaleFactor: 1,
                      style: TextStyle(color: Colors.white70, fontSize: 2.5 * SizeConfig.blockSizeVertical),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 15 * SizeConfig.blockSizeVertical,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 9 * SizeConfig.blockSizeVertical,
                  decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(width: 2.0, style: BorderStyle.solid),
                          borderRadius: BorderRadius.all(Radius.circular(30.0))
                      )
                  ),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => StartPage()));
                    },
                    child: Text("Voltar",
                      textScaleFactor: 1,
                      style: TextStyle(color: Colors.white70, fontSize: 2.5 * SizeConfig.blockSizeVertical),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _resetDataGAnimais(){
    ResetDataJson().resetDataGAnimais();
  }

  void _resetDataFGM(){
    ResetDataJson().resetDataFGM();
  }
  void _resetDataOutrosGastos(){
    ResetDataJson().resetDataOutrosGastos();
  }

  void _resetList(ResetGastos result){
    switch(result){
      case ResetGastos.resetGAnimais:
        resetButton("da Alimentação Geral", 0);
        break;
      case ResetGastos.resetFGM:
        resetButton("dos Gastos Gerais", 1);
        break;
      case ResetGastos.resetOutros:
        resetButton("dos Outros", 2);
    }
  }

  void resetButton(String dialog, int index) {
    showDialog(context: context,builder: (context){
      return AlertDialog(
        title: Text("Resetar Dados"),
        content: Text("Isso irá deletar todos os dados $dialog."
            "Você tem certeza disso?"),
        actions: <Widget>[
          FlatButton(
            child: Text("Sim, resetar"),
            onPressed: (){
              if(index == 0) {
                _resetDataGAnimais();
              }if(index == 1){
                _resetDataFGM();
              }if(index == 2){
                _resetDataOutrosGastos();
              }

            },
          ),
          FlatButton(
            child: Text("Não, cancelar"),
            onPressed: (){
              Navigator.pop(context);
            },
          )
        ],
      );
    }
    );
  }

}

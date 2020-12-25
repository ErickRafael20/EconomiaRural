import 'package:flutter/material.dart';
import 'package:despesas_galinhas/ui/Class/size_config.dart';
import 'package:despesas_galinhas/ui/Vendas/OvosFrangos/lucro_ui.dart';
import 'package:despesas_galinhas/ui/Vendas/Gado/gado_ui.dart';
import 'package:despesas_galinhas/ui/Vendas/Outros/outrasVendas.dart';
import 'package:despesas_galinhas/ui/home_page.dart';
import 'package:despesas_galinhas/ui/Class/reset_Data.dart';
import 'package:flutter/cupertino.dart';
enum ResetGastos{resetOvosFrangos, resetGado,resetOutros}

class VendasOptions extends StatefulWidget {
  @override
  _VendasOptionsState createState() => _VendasOptionsState();
}

class _VendasOptionsState extends State<VendasOptions> {
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
              Text("Resetar dados dos Ovos e Frangos"),
                value: ResetGastos.resetOvosFrangos,
              ),
              const PopupMenuItem(
                child: Text("Resetar dados do Gado e seus Derivados"),
                value: ResetGastos.resetGado,
              ),
              const PopupMenuItem(
                child: Text("Resetar dados dos Outros"),
                value: ResetGastos.resetOutros,
              )
            ],
            onSelected: _resetList,
          )
        ],
        title: Text("Vendas",
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LucroUI()));
                    },
                    child: Text("Ovos e Frangos",
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => GadoUI()));
                    },
                    child: Text("Gado e seus Derivados",
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => OutrasVendas()));
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

  void _resetDataOvosFrangos(){
    ResetDataJson().resetDataOvosFrangos();
  }

  void _resetDataGado(){
    ResetDataJson().resetDataGado();
  }
  void _resetDataOutrasVendas(){
    ResetDataJson().resetDataOutrasVendas();
  }

  void _resetList(ResetGastos result){
    switch(result){
      case ResetGastos.resetOvosFrangos:
        resetButton("dos Ovos e Frangos", 0);
        break;
      case ResetGastos.resetGado:
        resetButton("do Gado e seus derivados", 1);
        break;
      case ResetGastos.resetOutros:
        resetButton("dos Outros", 2);
    }
  }

  void resetButton(String dialog, int index) {
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text("Resetar Dados"),
        content: Text("Isso irá deletar todos os dados $dialog."
            "Você tem certeza disso?"),
        actions: <Widget>[
          FlatButton(
            child: Text("Sim, resetar"),
            onPressed: (){
              if(index == 0) {
                _resetDataOvosFrangos();
              }if(index == 1){
                _resetDataGado();
              }if(index == 2){
                _resetDataOutrasVendas();
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

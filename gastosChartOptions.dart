import 'package:flutter/material.dart';
import 'package:despesas_galinhas/ui/Class/size_config.dart';
import 'package:despesas_galinhas/ui/Gastos/GastosAnimais/despesaschart.dart';
import 'package:despesas_galinhas/ui/Gastos/GastosAnimais/canjicaChart.dart';
import 'package:despesas_galinhas/ui/Gastos/GastosAnimais/salChart.dart';
import 'package:despesas_galinhas/ui/Gastos/GastosAnimais/racaoChart.dart';
import 'package:despesas_galinhas/ui/Gastos/farmacia/farmaciaChart.dart';
import 'package:despesas_galinhas/ui/Gastos/gasolina/gasolinaChart.dart';
import 'package:despesas_galinhas/ui/Gastos/mercado/mercadoChart.dart';
import 'package:despesas_galinhas/ui/Gastos/outros/outrosGastosChart.dart';
import 'package:despesas_galinhas/ui/Gastos/outros/outrosGastos2Chart.dart';
import 'package:despesas_galinhas/ui/home_page.dart';
import 'package:flutter/cupertino.dart';

class GastoChartOptions extends StatefulWidget {
  @override
  _GastoChartOptionsState createState() => _GastoChartOptionsState();
}

class _GastoChartOptionsState extends State<GastoChartOptions> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.brown,
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text("Relatório de Gastos",
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MilhoChart()));
                    },
                    child: Text("Milho",
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CanjicaChart()));
                    },
                    child: Text("Canjica",
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SalChart()));
                    },
                    child: Text("Sal",
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RacaoChart()));
                    },
                    child: Text("Ração",
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FarmaciaChart()));
                    },
                    child: Text("Farmácia",
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => GasolinaChart()));
                    },
                    child: Text("Gasolina",
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MercadoChart()));
                    },
                    child: Text("Mercado",
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => OutrosGastos1Chart()));
                    },
                    child: Text("Outros 1",
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => OutrosGastos2Chart()));
                    },
                    child: Text("Outros 2",
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


}

import 'package:flutter/material.dart';
import 'package:despesas_galinhas/ui/Class/size_config.dart';
import 'package:despesas_galinhas/ui/Vendas/OvosFrangos/lucrochart.dart';
import 'package:despesas_galinhas/ui/Vendas/OvosFrangos/frangoChart.dart';
import 'package:despesas_galinhas/ui/Vendas/Gado/gadoChart.dart';
import 'package:despesas_galinhas/ui/Vendas/Gado/leiteChart.dart';
import 'package:despesas_galinhas/ui/Vendas/Gado/queijoChart.dart';
import 'package:despesas_galinhas/ui/Vendas/Gado/requeijaoChart.dart';
import 'package:despesas_galinhas/ui/Vendas/Outros/outrasVendas1Chart.dart';
import 'package:despesas_galinhas/ui/Vendas/Outros/outrasVendas2Chart.dart';
import 'package:despesas_galinhas/ui/home_page.dart';
import 'package:flutter/cupertino.dart';

class VendasChartOptions extends StatefulWidget {
  @override
  _VendasChartOptionsState createState() => _VendasChartOptionsState();
}

class _VendasChartOptionsState extends State<VendasChartOptions> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.brown,
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text("Relatório de Vendas",
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => OvoChart()));
                    },
                    child: Text("Ovo",
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FrangoChart()));
                    },
                    child: Text("Frango",
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => GadoChart()));
                    },
                    child: Text("Gado",
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LeiteChart()));
                    },
                    child: Text("Leite",
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => QueijoChart()));
                    },
                    child: Text("Queijo",
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RequeijaoChart()));
                    },
                    child: Text("Requeijão",
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => OutrasVendas1Chart()));
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => OutrasVendas2Chart()));
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

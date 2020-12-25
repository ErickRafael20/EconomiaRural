import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:despesas_galinhas/ui/BalancoFinanceiro/balancoFinanceiro_Month.dart';
import 'package:despesas_galinhas/ui/Class/loadJsons.dart';
import 'package:despesas_galinhas/ui/Class/size_config.dart';
import 'package:flutter/material.dart';
class BFMChooseYear extends StatefulWidget {
  @override
  _BFMChooseYearState createState() => _BFMChooseYearState();
}

class _BFMChooseYearState extends State<BFMChooseYear> {
  int length = 0;
  int year = 0;

  List<String> _yearList = ["2020"];
  String jsonStart = "despesas";

  Map<String,dynamic> fileContent;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.brown,
      appBar: AppBar(
        title: Text("Escolha o Ano",
          textScaleFactor: 1,
          style: TextStyle(fontSize: 5 * SizeConfig.blockSizeHorizontal),
        ),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: length,
                itemExtent: 20 * SizeConfig.blockSizeVertical,
                itemBuilder: (context,index){

                return yearListToShow(context, index);
                }
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    loadJson();
  }

  Future loadJson() async{
    fileContent = await LoadJsons().loadJsonGAnimais;
    loadDropDownYear();


  }

  void loadDropDownYear(){
    int x = 0;

    setState(() {
      for(int i = 1; i <= fileContent[jsonStart].length ;i++ ){
        _yearList.add(fileContent[jsonStart][x]["Ano"]);

        if(i == fileContent[jsonStart].length){
          _yearList.removeAt(0);
          length = _yearList.length;
        }

        x++;
      }
    });
  }

  Widget yearListToShow(BuildContext context, int index){
    if(index == 0){
      year = 0;
    } else{
      year++;
    }
    return Row(
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => BFMonth(index)));
                },
                child: Text(_yearList[year],
                  textScaleFactor: 1,
                  style: TextStyle(color: Colors.white70, fontSize: 2.5 * SizeConfig.blockSizeVertical),
                ),
              ),
            ),
          ],
        );
  }
}


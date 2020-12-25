import 'dart:convert';
import 'file:///C:/Users/Erick/AndroidStudioProjects/despesas_galinhas/lib/ui/Class/size_config.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
class LucroDespesas extends StatefulWidget {
  @override
  _LucroDespesasState createState() => _LucroDespesasState();
}

class _LucroDespesasState extends State<LucroDespesas> {
  List<String> nomeMeses = ["----------","Janeiro","Fevereiro","Março",
    "Abril","Maio","Junho","Julho","Agosto","Setembro","Outubro","Novembro","Dezembro"];
  String milhoResult = "0.0";
  String canjicaResult = "0.0";
  String ovoResult = "0.0";
  String frangoResult = "0.0";
  String lucroDesp = "";
  double totalDesp = 0;
  double totalLucro = 0;
  double _totalMath = 0.0;
  Map<String, dynamic> jsonContentLucro;
  Map<String, dynamic> jsonContentDesp;
  var _currentItemSelected = "----------";
  var _currentYearSelected = "2020";
  List<String> _yearList = ["2020"];
  int indexDropDown = 0;
  int indexYearDropDown = 0;

  bool fileExistLucro = false;
  bool fileExistDesp = false;

  String jsonStart = "despesas";
  String jsonStart2 = "lucro";
  String chooseMonth = "Month";
  String chooseYear = "Year";

  Future<String> get _localPathJson async{
    final directoryJson = await getExternalStorageDirectory();
    return directoryJson.path;
  }
  Future<File> get _localFileLucroJson async{
    final pathJson = await _localPathJson;
    return File("$pathJson/Json/Vendas/OvoFrango/lucro_data.json");
  }
  Future<File> get _localFileDespJson async{
    final pathJson = await _localPathJson;
    return File("$pathJson/Json/Gastos/GastosAnimais/despesas_data.json");
  }

  loadJsonFile() async{
      final lucroPath = await _localFileLucroJson;
      final despPath = await _localFileDespJson;
      fileExistLucro = await lucroPath.exists();
      fileExistDesp = await despPath.exists();
      if (fileExistLucro && fileExistDesp) {
        jsonContentLucro = json.decode(lucroPath.readAsStringSync());
        jsonContentDesp = json.decode(despPath.readAsStringSync());
        loadDropDownYear();
      }else{
        AlertDialog(
          title: Text("Arquivos não foram encontrados",textScaleFactor: 1),
          content: Text("Use a opção de salvar em algum mês em lucro ou despesa",textScaleFactor: 1),
            actions: [
              FlatButton(
                child: Text("Ok",textScaleFactor: 1),
                onPressed: (){
                  Navigator.pop(context);
                },
              )
          ],
        );
      }
  }

  void loadDropDownYear(){
    int x = 0;

    setState(() {
      for(int i = 1; i <= jsonContentDesp[jsonStart].length ;i++ ){
        _yearList.add(jsonContentDesp[jsonStart][x]["Ano"]);
        print("Ano: ${jsonContentDesp[jsonStart][x]["Ano"]}");
        if(i == 1){
          _yearList.removeAt(0);
        }
        x++;
        print("i = $i");
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadJsonFile();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.brown,
      appBar: AppBar(
        centerTitle:  true,
        backgroundColor: Colors.green,
        title: Text("Balanço Financeiro",
          textScaleFactor: 1,
          style: TextStyle(fontSize: 4.5 * SizeConfig.blockSizeHorizontal),),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 2 * SizeConfig.blockSizeHorizontal),
                  child: Text(
                    "Escolha o Ano",
                    textScaleFactor: 1,
                    style: TextStyle(
                        fontSize: 5 * SizeConfig.blockSizeHorizontal, color: Colors.white
                    ),
                  ),
                ),

                Padding(
                    padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical, left: SizeConfig.blockSizeVertical),
                    child: Container(
                      decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                              side: BorderSide(width: 2.0, style: BorderStyle.solid),
                              borderRadius: BorderRadius.all(Radius.circular(15.0))
                          )
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          items: _yearList.map((String dropDownStringItem) {
                            return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: SizedBox(
                                  height: 3 * SizeConfig.blockSizeVertical,
                                  width: 25 * SizeConfig.blockSizeHorizontal,
                                  child: Text(dropDownStringItem,
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                    color: Colors.white,
                                  ),textAlign: TextAlign.center, ),
                                ));
                          }).toList(),
                          onChanged: (value) {
                            //Your code to execute, when a menu item is selected

                            setState(() {
                              this._currentYearSelected = value;
                              indexYearDropDown = _yearList.indexOf(value);
                              print(indexYearDropDown);
                            });
                            print(_currentYearSelected);
                          },
                          value: _currentYearSelected,
                          iconSize: 24.0,
                          iconDisabledColor: Colors.white,
                          iconEnabledColor: Colors.white,
                          dropdownColor: Colors.green,
                        ),
                      ),
                    )
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 5.0),
                  child: Text(
                    "Escolha o Mês",
                    textScaleFactor: 1,
                    style: TextStyle(
                    fontSize: 5 * SizeConfig.blockSizeHorizontal,
                      color: Colors.white
                  ),
                  ),
                ),
                Padding(
                padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical, left: SizeConfig.blockSizeVertical),
                  child: Container(
                    decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                           side: BorderSide(width: 2.0, style: BorderStyle.solid),
                             borderRadius: BorderRadius.all(Radius.circular(15.0))
                          )
                        ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          items: nomeMeses.map((String dropDownStringItem) {
                           return DropdownMenuItem<String>(
                             value: dropDownStringItem,
                              child: SizedBox(
                              width: 25 * SizeConfig.blockSizeHorizontal,
                              child: Text(dropDownStringItem,
                                textScaleFactor: 1,
                                style: TextStyle(
                                color: Colors.white,
                              ),textAlign: TextAlign.center, ),
                            ));
                            }).toList(),
                          onChanged: (value){
                            setState(() {
                              this._currentItemSelected = value;
                              indexDropDown = nomeMeses.indexOf(value);
                              indexDropDown = indexDropDown - 1;
                              print(indexDropDown);
                              milhoResult = jsonContentDesp[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth]["Result"].toString();
                              canjicaResult = jsonContentDesp[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth]["Result2"].toString();
                              ovoResult = jsonContentLucro[jsonStart2][indexYearDropDown][chooseYear][indexDropDown][chooseMonth]["Result"].toString();
                              frangoResult = jsonContentLucro[jsonStart2][indexYearDropDown][chooseYear][indexDropDown][chooseMonth]["Result2"].toString();

                              double _totalDespDoubleM;
                              double _totalDespDoubleC;
                              double _totalLucroDoubleO;
                              double _totalLucroDoubleF;

                              _totalDespDoubleM = double.parse(milhoResult);
                              _totalDespDoubleC = double.parse(canjicaResult);
                              _totalLucroDoubleO = double.parse(ovoResult);
                              _totalLucroDoubleF = double.parse(frangoResult);

                              totalDesp = _totalDespDoubleM + _totalDespDoubleC;
                              totalLucro = _totalLucroDoubleO + _totalLucroDoubleF;
                              _totalMath = totalLucro - totalDesp;
                              print(_totalMath);
                              if(_totalMath < 0){
                                lucroDesp = "Negativo !";
                              }else{
                                lucroDesp = "Positivo !";
                              }
                            });
                          },
                          value: _currentItemSelected,
                          iconSize: 24.0,
                          iconDisabledColor: Colors.white,
                          iconEnabledColor: Colors.white,
                          dropdownColor: Colors.green,
                   )
                  )
                 )
                ),
              ],
            ),
            Container(
              height: 15 * SizeConfig.blockSizeVertical,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 8 * SizeConfig.blockSizeHorizontal),
                  child: Text("Milho",
                    textScaleFactor: 1,
                    style: TextStyle(fontSize: 6 * SizeConfig.blockSizeHorizontal),),
                ),
                Container(
                  width: 10.0,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20 * SizeConfig.blockSizeHorizontal),
                  child: Text("Canjica",
                    textScaleFactor: 1,
                    style: TextStyle(fontSize: 6 * SizeConfig.blockSizeHorizontal),),
                ),
                Container(
                  width: 10.0,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15 * SizeConfig.blockSizeHorizontal),
                  child: Text("Total",
                    textScaleFactor: 1,
                    style: TextStyle(fontSize: 6 * SizeConfig.blockSizeHorizontal),),
                ),
              ],
            ),
            functionUI("R\$$milhoResult\0","R\$$canjicaResult\0","R\$${totalDesp.toString()}0"),
            Container(
              height: 80.0,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 8 * SizeConfig.blockSizeHorizontal),
                  child: Text("Ovo",
                    textScaleFactor: 1,
                    style: TextStyle(fontSize:6 * SizeConfig.blockSizeHorizontal),),
                ),
                Container(
                  width: 10.0,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20 * SizeConfig.blockSizeHorizontal),
                  child: Text("Frango",
                    textScaleFactor: 1,
                    style: TextStyle(fontSize: 6 * SizeConfig.blockSizeHorizontal),),
                ),
                Container(
                  width: 10.0,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15 * SizeConfig.blockSizeHorizontal),
                  child: Text("Total",
                    textScaleFactor: 1,
                    style: TextStyle(fontSize: 6 * SizeConfig.blockSizeHorizontal),),
                ),
              ],
            ),
            functionUI("R\$$ovoResult\0", "R\$$frangoResult\0", "R\$${totalLucro.toString()}0"),
            Container(
             height: 30.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 7 * SizeConfig.blockSizeHorizontal, bottom: SizeConfig.blockSizeHorizontal),
              child: Text("Saldo Financeiro",
                textScaleFactor: 1,
                style: TextStyle(fontSize: 25.0),),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 17 * SizeConfig.blockSizeHorizontal),
                  child: Container(
                    width: 70 * SizeConfig.blockSizeHorizontal,
                    decoration: ShapeDecoration(

                        shape: RoundedRectangleBorder(
                            side: BorderSide(width: 2.0,style: BorderStyle.solid),
                            borderRadius: BorderRadius.all(Radius.circular(7.0))
                        )
                    ),
                    child: Text("R\$${_totalMath.toString()}0" , style: TextStyle(fontSize: 50.0), textAlign: TextAlign.center, textScaleFactor: 1,),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 5 * SizeConfig.blockSizeHorizontal,top: 4 * SizeConfig.blockSizeHorizontal ),
              child: Text(lucroDesp, style: TextStyle(fontSize: 30.0), textScaleFactor: 1,),
            ),
          ],
        ),
      ),
    );
  }

  Widget functionUI(String milhoTotal, String canjicaTotal, String total){
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 3 * SizeConfig.blockSizeHorizontal, top: 3 * SizeConfig.blockSizeHorizontal),
          child: Container(
            width: 28 * SizeConfig.blockSizeHorizontal,
            decoration: ShapeDecoration(

                shape: RoundedRectangleBorder(
                    side: BorderSide(width: 2.0,style: BorderStyle.solid),
                    borderRadius: BorderRadius.all(Radius.circular(7.0))
                )
            ),
            child: Text(milhoTotal, style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center,textScaleFactor: 1,),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 2.5 * SizeConfig.blockSizeHorizontal),
          child: Icon(Icons.add),
        ),
        Padding(
          padding: EdgeInsets.only(top: 2.5 * SizeConfig.blockSizeHorizontal),
          child: Container(
            width: 28 * SizeConfig.blockSizeHorizontal,
            decoration: ShapeDecoration(

                shape: RoundedRectangleBorder(
                    side: BorderSide(width: 2.0,style: BorderStyle.solid),
                    borderRadius: BorderRadius.all(Radius.circular(7.0))
                )
            ),
            child: Text(canjicaTotal, style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center,textScaleFactor: 1,),
          ),
        ),
        Container(
          child: Icon(Icons.drag_handle),
          padding: EdgeInsets.only(top: 2.5 * SizeConfig.blockSizeHorizontal),
        ),
        Padding(
          padding: EdgeInsets.only(top: 2.5 * SizeConfig.blockSizeHorizontal),
          child: Container(
            width: 26 * SizeConfig.blockSizeHorizontal,
            decoration: ShapeDecoration(

                shape: RoundedRectangleBorder(
                    side: BorderSide(width: 2.0,style: BorderStyle.solid),
                    borderRadius: BorderRadius.all(Radius.circular(7.0))
                )
            ),
            child: Text(total, style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center,textScaleFactor: 1,),
          ),
        ),
      ],
    );

  }


}

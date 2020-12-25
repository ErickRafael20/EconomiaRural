import 'dart:convert';
import 'package:despesas_galinhas/ui/Class/size_config.dart';
import 'package:despesas_galinhas/ui/Class/jsonPath.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MercadoChart extends StatefulWidget {
  @override
  _MercadoChartState createState() => _MercadoChartState();
}

class _MercadoChartState extends State<MercadoChart> {
  var _currentItemSelected = "----------";
  List<String> mesDespesasName = [
    "----------",
    "Janeiro",
    "Fevereiro",
    "Março",
    "Abril",
    "Maio",
    "Junho",
    "Julho",
    "Agosto",
    "Setembro",
    "Outubro",
    "Novembro",
    "Dezembro"
  ];
  var _currentYearSelected = "----------";
  List<String> _yearList = ["----------"];

  int indexDropDown = 0;
  int indexYearDropDown = 0;
  int index = 0;
  Map<String, dynamic> fileContent;
  String jsonStart = "mercado";
  String chooseMonth = "Month";
  String chooseYear = "Year";
  int fileLength = 0;
  int length = 0;
  bool fileExist = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.brown,
      appBar: AppBar(
        title: Text(
          "Relatório de Gastos Mercado",
          textScaleFactor: 1,
          style: TextStyle(fontSize: 5 * SizeConfig.blockSizeHorizontal),
        ),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Column(
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
                            indexYearDropDown = indexYearDropDown - 1;
                            if(indexYearDropDown == -1){
                              indexYearDropDown = 0;
                              this._currentYearSelected = "2020";
                            }

                            fileLength = fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth]["LengthIncrement"];
                            length = fileLength + 1;
                            if(length == 1){
                              length = 0;
                            }
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
                padding:
                EdgeInsets.only(left: 2 * SizeConfig.blockSizeHorizontal),
                child: Text(
                  "Escolha o Mês",
                  textScaleFactor: 1,
                  style: TextStyle(
                      fontSize: 5 * SizeConfig.blockSizeHorizontal,
                      color: Colors.white),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical,
                      left: SizeConfig.blockSizeVertical),
                  child: Container(
                    decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 2.0, style: BorderStyle.solid),
                            borderRadius:
                            BorderRadius.all(Radius.circular(15.0)))),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        items: mesDespesasName.map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                              value: dropDownStringItem,
                              child: SizedBox(
                                width: 25 * SizeConfig.blockSizeHorizontal,
                                child: Text(
                                  dropDownStringItem,
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ));
                        }).toList(),
                        onChanged: (value) {
                          //Your code to execute, when a menu item is selected

                          setState(() {
                            this._currentItemSelected = value;
                            indexDropDown = mesDespesasName.indexOf(value);
                            indexDropDown = indexDropDown - 1;

                            if(indexDropDown == -1){
                              indexDropDown = 0;
                              this._currentItemSelected = "Janeiro";
                            }
                            print(indexDropDown);
                            fileLength = fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth]["LengthIncrement"];
                            length = fileLength + 1;
                            if(length == 1){
                              length = 0;
                            }
                          });

                          print(_currentItemSelected);
                        },
                        value: _currentItemSelected,
                        iconSize: 24.0,
                        iconDisabledColor: Colors.white,
                        iconEnabledColor: Colors.white,
                        dropdownColor: Colors.green,
                      ),
                    ),
                  )),
            ],
          ),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.all(1.5 * SizeConfig.blockSizeHorizontal),
                itemCount: length,
                itemExtent:  65 * SizeConfig.blockSizeHorizontal,
                itemBuilder: (context, index) {
                  int indexOrder = 0;
                  indexOrder = index + 1;
                  return _despChartList(context, index, indexOrder.toString());
                }),
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

  Future loadJson() async {
    final jsonFile = await JsonPath().localFileMercadoJson;
    fileExist = await jsonFile.exists();
    if (fileExist) {
      fileContent = json.decode(jsonFile.readAsStringSync());
      loadDropDownYear();
    } else {
      print("File wasn't found");
    }
  }

  void loadDropDownYear(){
    int x = 0;

    setState(() {
      for(int i = 1; i <= fileContent[jsonStart].length ;i++ ){
        _yearList.add(fileContent[jsonStart][x]["Ano"]);
        print("Ano: ${fileContent[jsonStart][x]["Ano"]}");
        x++;
        print("i = $i");
      }
    });
  }

  Widget _despChartList(BuildContext context, int index, String nameOrder) {
    String datasTxt;
    String data;
    String result;
    String nomeMercado;
    int lengthList;

    double resultCheck = 0.00;
    double result2Check = 0.00;
    List<int> strPrc = [6,6];

    List<int> dateNamePadding = [0,0];
    int listOrder = 0;
    lengthList = length - 1;


    if(lengthList != index || index == 0) {
      datasTxt =
      fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth]
          .keys.toList()[2 + index];

      resultCheck = fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][datasTxt]["Valores"][1];
    }

    result2Check = fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth]["Valor"];

    if( resultCheck >= 0 && resultCheck <= 9){
      strPrc[0] = 3;
    } else if(resultCheck >= 10 && resultCheck <= 99){
      strPrc[0] = 4;
    } else if(resultCheck >= 100 && resultCheck <= 999){
      strPrc[0] = 5;
    }

    if( result2Check >= 0 && result2Check <= 9){
      strPrc[1] = 3;
    } else if(result2Check >= 10 && result2Check <= 99){
      strPrc[1] = 4;
    } else if(result2Check >= 100 && result2Check <= 999){
      strPrc[1] = 5;
    }


    if(lengthList != index || index == 0){
      dateNamePadding[0] = 8;
      dateNamePadding[1] = 10;
      listOrder = 0;
    }else {
      dateNamePadding[0] = 8;
      dateNamePadding[1] = 17;
      listOrder = 2;
    }

    if(lengthList != index || index == 0){
      data = "Data: ${fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][datasTxt]["Data"]}";
    }else {
      data = "Total Gasto";
    }

    if (lengthList != index || index == 0){
      nomeMercado = "Mercado: ${fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][datasTxt]["Valores"][0]} ";
    }

    if(lengthList != index || index == 0){
      result = "Total: R\$${fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][datasTxt]["Valores"][1].toStringAsPrecision(strPrc[0])} ";
    }else {
      result = "Total: R\$${fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth]["Valor"].toStringAsPrecision(strPrc[1])}";
    }



    return Padding(
      padding: EdgeInsets.only(bottom: 2.5 * SizeConfig.blockSizeVertical),
      child: Container(
        height: 30 * SizeConfig.blockSizeVertical,
        width: 98 * SizeConfig.blockSizeHorizontal,
        decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
                side: BorderSide(width: 2.0, style: BorderStyle.solid),
                borderRadius: BorderRadius.all(Radius.circular(15.0))
            )
        ),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 2 * SizeConfig.blockSizeHorizontal,
                      bottom: 7 * SizeConfig.blockSizeHorizontal,
                      top: listOrder * SizeConfig.blockSizeHorizontal),
                  child: Container(
                    alignment: Alignment.center,
                    height: 8 * SizeConfig.blockSizeVertical,
                    width: 15 * SizeConfig.blockSizeHorizontal,
                    decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(width: 2.0, style: BorderStyle.solid),
                            borderRadius: BorderRadius.all(Radius.circular(10.0))
                        )
                    ),
                    child: Text(
                      nameOrder,
                      textAlign: TextAlign.justify,
                      textScaleFactor: 1,
                      style: TextStyle(
                        fontSize: 4 * SizeConfig.blockSizeVertical,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: dateNamePadding[0] * SizeConfig.blockSizeHorizontal,
                      left: dateNamePadding[1] * SizeConfig.blockSizeHorizontal),
                  child: Text(
                    data,
                    textScaleFactor: 1,
                    style: TextStyle(fontSize: 3 * SizeConfig.blockSizeVertical),
                  ),
                ),
                if(lengthList != index || index == 0)(
                    deleteButtonWidget(index)
                )
              ],
            ),
            if(lengthList != index || index == 0)(
                tabelaGastos(nomeMercado, result)
            )else(
                tabelaResult(result)
            )
          ],
        ),
      ),

    );
  }


  Widget deleteButtonWidget(int index){
    return Padding(
        padding: EdgeInsets.only(
            bottom: 15 * SizeConfig.blockSizeHorizontal,
            left: 3 * SizeConfig.blockSizeHorizontal),
        child: ButtonTheme(
          minWidth: SizeConfig.blockSizeHorizontal,
          height: SizeConfig.blockSizeHorizontal,
          child: FlatButton(
            onPressed: (){
              deleteConfirmation(index);
            },
            child: Icon(Icons.close),
          ),
        ));
  }

  Widget tabelaGastos(String nomeMercado, result){
    return Container(
      padding: EdgeInsets.only(top: 1.5 * SizeConfig.blockSizeVertical),
      height: 10 * SizeConfig.blockSizeVertical,
      width: 70 * SizeConfig.blockSizeHorizontal,
      decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
              side: BorderSide(width: 2.0, style: BorderStyle.solid),
              borderRadius: BorderRadius.all(Radius.circular(10.0))
          )
      ),
      child: Column(
        children:
        [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                nomeMercado,
                textScaleFactor: 1,
                style: TextStyle(fontSize: 2.5 * SizeConfig.blockSizeVertical),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                result,
                textScaleFactor: 1,
                style: TextStyle(fontSize: 2.5 * SizeConfig.blockSizeVertical),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget tabelaResult(String  result){
    return  Container(
      padding: EdgeInsets.only(top: 1.5 * SizeConfig.blockSizeVertical),
      height: 8 * SizeConfig.blockSizeVertical,
      width: 50 * SizeConfig.blockSizeHorizontal,
      decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
              side: BorderSide(width: 2.0, style: BorderStyle.solid),
              borderRadius: BorderRadius.all(Radius.circular(10.0))
          )
      ),
      child: Column(
        children:
        [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                result,
                textScaleFactor: 1,
                style: TextStyle(fontSize: 2.5 * SizeConfig.blockSizeVertical),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void deleteConfirmation(int index){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text("Alerta!!!",textScaleFactor: 1),
        content: Text("Essa ação irá deletar um item da lista e dos dados para sempre. Você tem certeza disso?",textScaleFactor: 1),
        actions: <Widget>[
          FlatButton(
            child: Text("Sim, deletar",textScaleFactor: 1),
            onPressed: (){
              deleteButton(index);
            },
          ),
          FlatButton(
            child: Text("Não, cancelar",textScaleFactor: 1),
            onPressed: (){
              Navigator.pop(context);
            },
          )
        ],
      );
    }
    );

  }

  void deleteSuccess(){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text("Deletado com sucesso",textScaleFactor: 1),
        content: Text("O item foi deletado com succeso",textScaleFactor: 1),
        actions: <Widget>[
          FlatButton(
            child: Text("OK",textScaleFactor: 1),
            onPressed: (){
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
        ],
      );
    }
    );
  }

  Future deleteButton(int indexCard, ) async {
    String datasTxt;
    String listNameJson = "Valor";
    datasTxt = fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth].keys.toList()[2+indexCard];
    final jsonFile = await JsonPath().localFileMercadoJson;

    fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][listNameJson] =
        fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][listNameJson] -
            fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][datasTxt]["Valores"][1];

    fileContent[jsonStart][indexYearDropDown]["Result"] = fileContent[jsonStart][indexYearDropDown]["Result"] -
        fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][datasTxt]["Valores"][1];

    fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth].removeWhere((key, value) => key == datasTxt);


    setState(() {
      if(length == 2) {
        length = 0;
      }else{
        length--;
      }
    });

    fileLength--;

    fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth]["LengthIncrement"] = fileLength;
    print(fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth]);
    print("file length $fileLength");
    Map<String,dynamic> newMapJson = json.decode(jsonFile.readAsStringSync());
    newMapJson.addAll(fileContent);
    jsonFile.writeAsStringSync(json.encode(newMapJson));
    deleteSuccess();
  }

}
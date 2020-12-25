import 'dart:convert';
import 'package:despesas_galinhas/ui/Class/size_config.dart';
import 'package:despesas_galinhas/ui/Class/jsonPath.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RequeijaoChart extends StatefulWidget {
  @override
  _RequeijaoChartState createState() => _RequeijaoChartState();
}

class _RequeijaoChartState extends State<RequeijaoChart> {
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
  String jsonStart = "gado";
  String chooseMonth = "Month";
  String chooseYear = "Year";
  String jsonName = "Requeijao";
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
          "Relatório de Vendas Requeijão",
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

                            fileLength = fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][3][jsonName]["LengthIncrement"];

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
                            fileLength = fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][3][jsonName]["LengthIncrement"];
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
    final jsonFile = await JsonPath().localFileGadoJson;
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
    String requeijao;
    String qnt;
    String result;
    int lengthList;
    int listOrder;

    double valor1Check = 0.00;
    double valor2Check = 0.00;
    double resultCheck = 0.00;
    double result2Check = 0.00;
    List<int> strPrc = [6,6,6,6];

    List<int> dateNamePadding = [0,0];
    lengthList = length - 1;


    if(lengthList != index || index == 0) {
      datasTxt =
      fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][3][jsonName]
          .keys.toList()[4 + index];

      valor1Check = fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][3][jsonName][datasTxt]["Valores"][0];
      resultCheck = fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][3][jsonName][datasTxt]["Valores"][2];
    }

    valor2Check = fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][3][jsonName]["Valor"];
    result2Check = fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][3][jsonName]["Result"];

    if( valor1Check >= 0 && valor1Check <= 9){
      strPrc[0] = 3;
    } else if(valor1Check >= 10 && valor1Check <= 99){
      strPrc[0] = 4;
    } else if(valor1Check >= 100 && valor1Check <= 999){
      strPrc[0] = 5;
    }

    if( valor2Check >= 0 && valor2Check <= 9){
      strPrc[1] = 3;
    } else if(valor2Check >= 10 && valor2Check <= 99){
      strPrc[1] = 4;
    } else if(valor2Check >= 100 && valor2Check <= 999){
      strPrc[1] = 5;
    }

    if( resultCheck >= 0 && resultCheck <= 9){
      strPrc[2] = 3;
    } else if(resultCheck >= 10 && resultCheck <= 99){
      strPrc[2] = 4;
    } else if(resultCheck >= 100 && resultCheck <= 999){
      strPrc[2] = 5;
    }

    if( result2Check >= 0 && result2Check <= 9){
      strPrc[3] = 3;
    } else if(result2Check >= 10 && result2Check <= 99){
      strPrc[3] = 4;
    } else if(result2Check >= 100 && result2Check <= 999){
      strPrc[3] = 5;
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
      data = "Data: ${fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][3][jsonName][datasTxt]["Data"]}";
    }else {
      data = "Total de Vendas";
    }

    if (lengthList != index || index == 0){
      requeijao = "Requeijão: R\$${fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][3][jsonName][datasTxt]["Valores"][0].toStringAsPrecision(strPrc[0])} ";
    } else{
      requeijao = "Requeijão: R\$ ${fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][3][jsonName]["Valor"].toStringAsPrecision(strPrc[1])}";
    }

    if(lengthList != index || index == 0){
      qnt = "Quantidades: ${fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][3][jsonName][datasTxt]["Valores"][1]}";
    }else {
      qnt = "Quantidades: ${fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][3][jsonName]["Qnt"]}";
    }

    if(lengthList != index || index == 0){
      result = "Total: R\$${fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][3][jsonName][datasTxt]["Valores"][2].toStringAsPrecision(strPrc[2])} ";
    }else {
      result = "Total: R\$${fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][3][jsonName]["Result"].toStringAsPrecision(strPrc[3])}";
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
                tabelaGastos(requeijao,qnt,result)
            )else(
                tabelaResult(requeijao, qnt, result)
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

  Widget tabelaGastos(String milho,qntSacos,result){
    return Container(
      padding: EdgeInsets.only(top: 1.5 * SizeConfig.blockSizeVertical),
      height: 12 * SizeConfig.blockSizeVertical,
      width: 50 * SizeConfig.blockSizeHorizontal,
      decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
              side: BorderSide(width: 2.0, style: BorderStyle.solid),
              borderRadius: BorderRadius.all(Radius.circular(10.0))
          )
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                milho,
                textScaleFactor: 1,
                style: TextStyle(fontSize: 2.5 * SizeConfig.blockSizeVertical),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                qntSacos,
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

  Widget tabelaResult(String milho,qntSacos,result){
    return  Container(
      padding: EdgeInsets.only(top: 1.5 * SizeConfig.blockSizeVertical),
      height: 12 * SizeConfig.blockSizeVertical,
      width: 50 * SizeConfig.blockSizeHorizontal,
      decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
              side: BorderSide(width: 2.0, style: BorderStyle.solid),
              borderRadius: BorderRadius.all(Radius.circular(10.0))
          )
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                milho,
                textScaleFactor: 1,
                style: TextStyle(fontSize: 2.5 * SizeConfig.blockSizeVertical),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                qntSacos,
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

  Future deleteButton(int indexCard) async {
    String datasTxt;
    List<String> listNameJson = ["Valor", "Qnt", "Result"];
    datasTxt = fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][3][jsonName].keys.toList()[4+indexCard];
    final jsonFile = await JsonPath().localFileGadoJson;

    for (int i = 0; i <= 2; i++){
      fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][3][jsonName][listNameJson[i]] =
          fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][3][jsonName][listNameJson[i]] -
              fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][3][jsonName][datasTxt]["Valores"][i];
    }

    fileContent[jsonStart][indexYearDropDown][jsonName]["Result"] = fileContent[jsonStart][indexYearDropDown][jsonName]["Result"] -
        fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][3][jsonName][datasTxt]["Valores"][2];

    fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][3][jsonName].removeWhere((key, value) => key == datasTxt);


    setState(() {
      if(length == 2) {
        length = 0;
      }else{
        length--;
      }
    });

    fileLength--;

    fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][3][jsonName]["LengthIncrement"] = fileLength;
    print(fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth]);
    print("file length $fileLength");
    Map<String,dynamic> newMapJson = json.decode(jsonFile.readAsStringSync());
    newMapJson.addAll(fileContent);
    jsonFile.writeAsStringSync(json.encode(newMapJson));
    deleteSuccess();
  }

}

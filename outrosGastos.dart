import 'dart:async';
import 'package:despesas_galinhas/ui/Class/loadJsons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:despesas_galinhas/ui/Class/YearClass/year_mapGAnimais.dart';
import 'package:despesas_galinhas/ui/Class/size_config.dart';
import 'package:despesas_galinhas/ui/Class/jsonPath.dart';
import 'dart:convert';
import 'dart:io';

enum SaveInfo {savesOutrosGastos1,saveOutrosGastos2,saveAll}

class OutrosGastos extends StatefulWidget {
  @override
  _OutrosGastosState createState() => _OutrosGastosState();
}

class _OutrosGastosState extends State<OutrosGastos> {
  final valorOutrosGastos1Controller = TextEditingController(text: "0.00");
  final nomeOutrosGastos1Controller = TextEditingController();
  final valorOutrosGastos2Controller = TextEditingController(text: "0.00");
  final qntOutrosGastos2Controller = TextEditingController(text: "0");
  final nomeOutrosGastos2Controller = TextEditingController();
  TextEditingController dateControllerTxt = TextEditingController();

  DateTime _dateTime = DateTime.now();

  bool outrosGastos1Edited = false;
  bool outrosGastos2Edited = false;
  bool saveAllSuccessful = false;
  bool saveOnlyOneSuccessful = false;
  int indexDropDown = 0;
  int indexYearDropDown = 0;
  double valor2;
  double qnt2;
  double result = 0.0;
  Map<String, dynamic> fileContentOutrosGastos;
  Map<String, dynamic> fieldContent;
  String jsonStartOutrosGastos = "outros";
  String chooseMonth = "Month";
  String chooseYear = "Year";
  String dateText;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        backgroundColor: Colors.brown,
        appBar: AppBar(
          backgroundColor: Colors.green,
          centerTitle: true,
          title: Text("Outros Gastos",
            textScaleFactor: 1,
            style: TextStyle(fontSize: 5 * SizeConfig.blockSizeHorizontal),
          ),
          actions: [
            PopupMenuButton<SaveInfo>(
              itemBuilder: (context) => <PopupMenuEntry<SaveInfo>>[
                const PopupMenuItem(
                  child: Text("Salvar Dados do Primeiro Item"),
                  value: SaveInfo.savesOutrosGastos1,
                ),
                const PopupMenuItem(
                  child: Text("Salvar dados do Segundo Item"),
                  value: SaveInfo.saveOutrosGastos2,
                ),
                const PopupMenuItem(child: Text("Salvar Tudo"),
                  value: SaveInfo.saveAll,
                )
              ],
              onSelected: saveAllPopUp,
            )
          ],
        ),body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 12 * SizeConfig.blockSizeVertical,
            ),

            gastoFGMUIName(nomeOutrosGastos1Controller, valorOutrosGastos1Controller, "de um Item"),
            Container(
              height: 15 * SizeConfig.blockSizeVertical,
            ),

            outrosGastos2Widget(nomeOutrosGastos2Controller, valorOutrosGastos2Controller, qntOutrosGastos2Controller,"de um Item",functionOutrosGastos2,result),

          ],
        ),
      ),
      ),
    );


  }

  Widget gastoFGMUIName(TextEditingController nameController, TextEditingController functionController,
      String nameFGM){

    return Container(
        height: 40 * SizeConfig.blockSizeHorizontal,
        width: 95 * SizeConfig.blockSizeHorizontal,
        decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
                side: BorderSide(width: 2.0, style: BorderStyle.solid),
                borderRadius: BorderRadius.all(Radius.circular(15.0))
            )
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 20 * SizeConfig.blockSizeHorizontal
                ),
                Container(
                    width: 80 * SizeConfig.blockSizeHorizontal,
                    padding: EdgeInsets.only(left: 3 * SizeConfig.blockSizeHorizontal, right: SizeConfig.blockSizeHorizontal),
                    child: TextField(
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 5 * SizeConfig.blockSizeHorizontal),
                        decoration: InputDecoration(
                            hintText: "Nome $nameFGM",
                            enabledBorder: InputBorder.none
                        ),
                        controller: nameController,
                        onEditingComplete: (){
                          FocusScope.of(context).unfocus();
                        }
                    )
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 40 * SizeConfig.blockSizeHorizontal,
                    padding: EdgeInsets.only(left: 3 * SizeConfig.blockSizeHorizontal, right: SizeConfig.blockSizeHorizontal),
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        prefixText: "R\$",
                        labelText: "Valor",
                        border: OutlineInputBorder(),
                      ),
                      controller: functionController,
                      onTap: (){
                          if (valorOutrosGastos1Controller.text == "0.00") {
                            valorOutrosGastos1Controller.text = "";
                          }
                      },
                      onEditingComplete: (){
                          outrosGastos1Edited = true;
                          if (valorOutrosGastos1Controller.text == "") {
                            valorOutrosGastos1Controller.text = "0.00";
                            outrosGastos1Edited = false;
                            FocusScope.of(context).unfocus();
                          }
                          FocusScope.of(context).unfocus();
                        }
                    )
                )],
            )
          ],
        )
    );
  }

  Widget outrosGastos2Widget(TextEditingController controllerNome, controllerValor, controllerQnt,
      String nameOTR, Function resultFunction, double resultDouble){
    return Container(
        height: 40 * SizeConfig.blockSizeHorizontal,
        width: 95 * SizeConfig.blockSizeHorizontal,
        decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
                side: BorderSide(width: 2.0, style: BorderStyle.solid),
                borderRadius: BorderRadius.all(Radius.circular(15.0))
            )
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 20 * SizeConfig.blockSizeHorizontal
                ),
                Container(
                    width: 80 * SizeConfig.blockSizeHorizontal,
                    padding: EdgeInsets.only(left: 3 * SizeConfig.blockSizeHorizontal, right: SizeConfig.blockSizeHorizontal),
                    child: TextField(
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 5 * SizeConfig.blockSizeHorizontal),
                        decoration: InputDecoration(
                            hintText: "Nome $nameOTR",
                            enabledBorder: InputBorder.none
                        ),
                        controller: controllerNome,
                        onEditingComplete: (){
                          FocusScope.of(context).unfocus();
                        }
                    )
                ),
              ],
            ),
            Row(
              children: [
                Container(
                    width: 30 * SizeConfig.blockSizeHorizontal,
                    padding: EdgeInsets.only(left: 3 * SizeConfig.blockSizeHorizontal, right: SizeConfig.blockSizeHorizontal),
                    child: TextField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          prefixText: "R\$",
                          labelText: "Valor",
                          border: OutlineInputBorder(),
                        ),
                        onChanged: resultFunction,
                        controller: controllerValor,
                        onTap: (){
                          if (valorOutrosGastos2Controller.text == "0.00") {
                            valorOutrosGastos2Controller.text = "";
                          }
                        },
                        onEditingComplete: (){
                          outrosGastos2Edited = true;
                          if (valorOutrosGastos2Controller.text == "") {
                            valorOutrosGastos2Controller.text = "0.00";
                            outrosGastos2Edited = false;
                            FocusScope.of(context).unfocus();
                          }
                          FocusScope.of(context).unfocus();
                        }
                    )
                ),
                Container(
                  child: Icon(Icons.close),
                ),
                Container(
                    width: 22 * SizeConfig.blockSizeHorizontal,
                    child: TextField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: "Quantidade",
                          border: OutlineInputBorder(),
                        ),
                        controller: controllerQnt,
                        onChanged: resultFunction,
                        onTap: (){
                          if (qntOutrosGastos2Controller.text == "0") {
                            qntOutrosGastos2Controller.text = "";
                          }
                        },
                        onEditingComplete: (){
                          outrosGastos2Edited = true;
                          if (qntOutrosGastos2Controller.text == "") {
                            qntOutrosGastos2Controller.text = "0";
                            outrosGastos2Edited = false;
                            FocusScope.of(context).unfocus();
                          }
                          FocusScope.of(context).unfocus();
                        }
                    )
                ),
                Container(
                  child: Icon(Icons.drag_handle),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 15 * SizeConfig.blockSizeHorizontal,
                  width: 20 * SizeConfig.blockSizeHorizontal,
                  decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1.0, style: BorderStyle.solid),
                          borderRadius: BorderRadius.all(Radius.circular(7.0))
                      )
                  ),
                  child: Text("R\$${(resultDouble).toStringAsFixed(1)}0",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 4 * SizeConfig.blockSizeHorizontal),
                  ),
                ),
              ],
            )
          ],
        )
    );
  }
  Future loadJson()async{
   fileContentOutrosGastos = await LoadJsons().loadJsonOutrosGastos;
  }

  void functionOutrosGastos2(String text){

    setState(() {
      valor2 = double.parse(valorOutrosGastos2Controller.text);
      qnt2 = double.parse(qntOutrosGastos2Controller.text);

      result = valor2 * qnt2;
    });

  }

  @override
  void initState() {
    super.initState();
    loadJson();
  }

  void saveAllPopUp(SaveInfo save){
    switch(save){
      case SaveInfo.savesOutrosGastos1:
        checkFieldOutrosGastos1(0);
        break;
      case SaveInfo.saveOutrosGastos2:
        checkFieldOutrosGastos2(1);
        break;
      case SaveInfo.saveAll:
        checkFieldOutrosGastos1(2);
        break;
    }

  }

  void checkFieldOutrosGastos1(int x){
    if(valorOutrosGastos1Controller.text == "0.00" && nomeOutrosGastos1Controller.text == "" ){
      inputValueInFields("Não foram inseridos um nome e nem um valor no primeiro campo. Insira um nome e um valor antes de salvar");
    } else if(valorOutrosGastos1Controller.text == "0.00" && nomeOutrosGastos1Controller.text != ""){
      inputValueInFields("Não foi inserido o valor gasto no primeiro campo. Insira um valor primeiro antes de salvar");
    } else if(valorOutrosGastos1Controller.text != "0.00" && nomeOutrosGastos1Controller.text == ""){
      inputValueInFields("Não foi inserido um nome no primeiro campo. Insira um nome antes de salvar");
    } else if (x == 0){
      print("Check Field");
      alertSaveButton(x);
    } else if (x == 2){
      checkFieldOutrosGastos2(2);
    }
  }

  void checkFieldOutrosGastos2(int x){
    if(valorOutrosGastos2Controller.text == "0.00" && nomeOutrosGastos2Controller.text == "" ){
      inputValueInFields("Não foram inseridos um nome e nem um valor no segundo campo. Insira um nome e um valor antes de salvar");
    } else if(valorOutrosGastos2Controller.text == "0.00" && nomeOutrosGastos2Controller.text != ""){
      inputValueInFields("Não foi inserido o valor no segundo campo. Insira um valor primeiro antes de salvar");
    } else if(valorOutrosGastos2Controller.text != "0.00" && nomeOutrosGastos2Controller.text == ""){
      inputValueInFields("Não foi inserido um nome no segundo campo. Insira um nome antes de salvar");
    } else if (x == 1){
      alertSaveButton(x);
    } else if (x == 2){
      alertSaveButton(2);
    }
  }



  void inputValueInFields(String checkField){
    showDialog(context: context,barrierDismissible: false ,builder: (context){
      return AlertDialog(
        title: Text("Erro!",textScaleFactor: 1),
        content: Text("$checkField",textScaleFactor: 1),
        actions: <Widget>[
          FlatButton(
            child: Text("Ok",textScaleFactor: 1),
            onPressed: (){
              Navigator.pop(context);
            },
          )
        ],
      );
    }
    );
  }

  void saveSuccessful(){
    showDialog(context: context, barrierDismissible: false ,builder: (context){
      return AlertDialog(
        title: Text("Salvo com sucesso",textScaleFactor: 1),
        content: Text("O item foi salvo com sucesso. Deseja salvar outro item?",
            textScaleFactor: 1),
        actions: <Widget>[
          FlatButton(
            child: Text("Sim",
                textScaleFactor: 1),
            onPressed: (){
              setState(() {
                valorOutrosGastos1Controller.text = "0.00";
                nomeOutrosGastos1Controller.text = "";
                valorOutrosGastos2Controller.text = "0.00";
                nomeOutrosGastos2Controller.text = "";
                qntOutrosGastos2Controller.text = "0";
                dateControllerTxt.text = "";
                result = 0;
              });

              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
          FlatButton(
            child: Text("Não",
              textScaleFactor: 1,),
            onPressed: (){
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
            },
          )
        ],
      );
    }
    );

  }

  Future createNewYear()async{
    Timer(Duration(milliseconds: 10),()
    {
      YearMapGAnimais().newYearGAnimaisFunction();
    });
  }


  Future<File> saveDataOutrosGastos1() async{
    final file = await JsonPath().localFileOutrosGastosJson;
    int increment = 0;
    increment = fileContentOutrosGastos[jsonStartOutrosGastos][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][0]["Outros1"]["LengthIncrement"];
    if(fileContentOutrosGastos[jsonStartOutrosGastos][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][0]["Outros1"].containsKey("Datas$increment")){
      increment++;
      fieldContent = {"Datas$increment": {"Data": "", "Valores": []}};
      fileContentOutrosGastos[jsonStartOutrosGastos][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][0]["Outros1"]
          .addAll(fieldContent);

      fileContentOutrosGastos[jsonStartOutrosGastos][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][0]["Outros1"]["Datas$increment"]["Data"] =
          dateText;

      (fileContentOutrosGastos[jsonStartOutrosGastos][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][0]["Outros1"]["Datas$increment"]["Valores"])
          .addAll([nomeOutrosGastos1Controller.text ,double.parse(valorOutrosGastos1Controller.text)]);

      fileContentOutrosGastos[jsonStartOutrosGastos][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][0]["Outros1"]["LengthIncrement"] = increment;
    }else{

      fieldContent = {"Datas$increment": {"Data": "", "Valores": []}};
      fileContentOutrosGastos[jsonStartOutrosGastos][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][0]["Outros1"]
          .addAll(fieldContent);

      fileContentOutrosGastos[jsonStartOutrosGastos][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][0]["Outros1"]["Datas$increment"]["Data"] =
          dateText;

      (fileContentOutrosGastos[jsonStartOutrosGastos][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][0]["Outros1"]["Datas$increment"]["Valores"])
          .addAll([nomeOutrosGastos1Controller.text ,double.parse(valorOutrosGastos1Controller.text)]);

      increment++;

      fileContentOutrosGastos[jsonStartOutrosGastos][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][0]["Outros1"]["LengthIncrement"] = increment;
    }
    fileContentOutrosGastos[jsonStartOutrosGastos][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][0]["Outros1"]["Valor"] = double.parse(valorOutrosGastos1Controller.text) +
        fileContentOutrosGastos[jsonStartOutrosGastos][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][0]["Outros1"]["Valor"];

    fileContentOutrosGastos[jsonStartOutrosGastos][indexYearDropDown]["Result"] = double.parse(valorOutrosGastos1Controller.text) + fileContentOutrosGastos[jsonStartOutrosGastos][indexYearDropDown]["Result"];

    Map<String, dynamic> newMapRootJson = json.decode(
        file.readAsStringSync());
    newMapRootJson.addAll(fileContentOutrosGastos);
    outrosGastos1Edited = false;
    if(saveOnlyOneSuccessful){
      saveSuccessful();
      saveOnlyOneSuccessful = false;
    }
    print(fileContentOutrosGastos[jsonStartOutrosGastos][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][0]["Outros1"]);
    return file.writeAsString(json.encode(newMapRootJson));
  }

  Future<File> saveDataOutrosGastos2() async{
    final file = await JsonPath().localFileOutrosGastosJson;
    int increment = 0;
    List<String> jsonNameToSave = ["Valor","Qnt","Result"];
    List<double> doubleToSave = [valor2,qnt2,result];

    increment = fileContentOutrosGastos[jsonStartOutrosGastos][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][1]["Outros2"]["LengthIncrement"];
    if(fileContentOutrosGastos[jsonStartOutrosGastos][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][1]["Outros2"].containsKey("Datas$increment")){
      increment++;
      fieldContent = {"Datas$increment": {"Data": "", "Valores": []}};
      fileContentOutrosGastos[jsonStartOutrosGastos][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][1]["Outros2"]
          .addAll(fieldContent);

      fileContentOutrosGastos[jsonStartOutrosGastos][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][1]["Outros2"]["Datas$increment"]["Data"] =
          dateText;

      (fileContentOutrosGastos[jsonStartOutrosGastos][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][1]["Outros2"]["Datas$increment"]["Valores"])
          .addAll([nomeOutrosGastos2Controller.text ,double.parse(valorOutrosGastos2Controller.text), int.parse(qntOutrosGastos2Controller.text)]);

      fileContentOutrosGastos[jsonStartOutrosGastos][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][1]["Outros2"]["LengthIncrement"] = increment;
    }else{

      fieldContent = {"Datas$increment": {"Data": "", "Valores": []}};
      fileContentOutrosGastos[jsonStartOutrosGastos][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][1]["Outros2"]
          .addAll(fieldContent);

      fileContentOutrosGastos[jsonStartOutrosGastos][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][1]["Outros2"]["Datas$increment"]["Data"] =
          dateText;

      (fileContentOutrosGastos[jsonStartOutrosGastos][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][1]["Outros2"]["Datas$increment"]["Valores"])
          .addAll([nomeOutrosGastos2Controller.text ,doubleToSave[0],doubleToSave[1],doubleToSave[2]]);

      increment++;
      print(fileContentOutrosGastos[jsonStartOutrosGastos][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][1]["Outros2"]);
      fileContentOutrosGastos[jsonStartOutrosGastos][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][1]["Outros2"]["LengthIncrement"] = increment;
    }

    for(int i = 0; i <= 2; i++){
      fileContentOutrosGastos[jsonStartOutrosGastos][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][1]["Outros2"][jsonNameToSave[i]] = doubleToSave[i] +
          fileContentOutrosGastos[jsonStartOutrosGastos][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][1]["Outros2"][jsonNameToSave[i]];
      print(fileContentOutrosGastos[jsonStartOutrosGastos][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][1]["Outros2"][jsonNameToSave[i]]);
    }

    fileContentOutrosGastos[jsonStartOutrosGastos][indexYearDropDown]["Result"] = result + fileContentOutrosGastos[jsonStartOutrosGastos][indexYearDropDown]["Result"];

    Map<String, dynamic> newMapRootJson = json.decode(file.readAsStringSync());
    newMapRootJson.addAll(fileContentOutrosGastos);
    outrosGastos2Edited = false;
    if(saveAllSuccessful){
      saveSuccessful();
      saveAllSuccessful = false;
    }else if(saveOnlyOneSuccessful){
      saveSuccessful();
      saveOnlyOneSuccessful = false;
    }

    return file.writeAsString(json.encode(newMapRootJson));
  }


  void yearIndex(int x){
    int z = 2020;
    int y = 0;
    for(int i = 0; i <= fileContentOutrosGastos[jsonStartOutrosGastos].length; i++){
      if(_dateTime.year == z){
        indexYearDropDown = y;
        i = fileContentOutrosGastos[jsonStartOutrosGastos].length + 1;
        if(x == 0) {
          saveDataOutrosGastos1();
          saveOnlyOneSuccessful = true;
          if(y == fileContentOutrosGastos[jsonStartOutrosGastos].length - 1){
            createNewYear();
          }
        }else if(x == 1){
          saveDataOutrosGastos2();
          saveOnlyOneSuccessful = true;
          if(y == fileContentOutrosGastos[jsonStartOutrosGastos].length - 1){
            createNewYear();
          }
        }else if(x == 2){
          saveDataOutrosGastos1();
          Timer(Duration(milliseconds: 50), () {
            saveDataOutrosGastos2();
            saveAllSuccessful = true;
          });
          print("Salvar Tudo");
          if(y == fileContentOutrosGastos[jsonStartOutrosGastos].length - 1) {
            createNewYear();
          }
        }

      }else {
        z++;
        y++;
      }
    }
  }

  void monthIndex(int x){
    int z = 1;
    int u = 0;
    print(_dateTime.month);
    for (int i = 0; i <= 11; i++){
      if (_dateTime.month == z){
        indexDropDown = u;
        i = 12;
        yearIndex(x);
      }else{
        z++;
        u++;
      }
    }

  }


  void alertSaveButton(int x) {

    int date;
    int dateLength;
    dateLength = fileContentOutrosGastos[jsonStartOutrosGastos].length;
    dateLength--;
    date = int.parse(fileContentOutrosGastos[jsonStartOutrosGastos][dateLength]["Ano"]);
    date++;
    bool dateNull = false;
    showDialog(context: context, barrierDismissible: false,
        builder: (context){
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              title: Text("Insira uma data",textScaleFactor: 1),
              content: Text("Insira uma data para salvar o arquivo",textScaleFactor: 1),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 11 * SizeConfig.blockSizeVertical),
                  child: Container(
                    width:  35 * SizeConfig.blockSizeHorizontal,
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      onTap: (){
                        showDatePicker(
                          context: context,
                          initialDate: _dateTime,
                          firstDate: DateTime(2020),
                          lastDate: DateTime(date),
                        ).then((date){
                          setState(() {
                            _dateTime = date;
                            dateControllerTxt.text = "${_dateTime.day}/${_dateTime.month}/${_dateTime.year}";
                            dateText = dateControllerTxt.text;
                            dateNull = true;
                          });
                        });
                      },
                      controller: dateControllerTxt,
                    ),
                  ),
                ),
                Row(
                  children: [
                    FlatButton(
                      child: Text("Voltar",textScaleFactor: 1),
                      onPressed: (){
                        dateControllerTxt.text = "";
                        Navigator.pop(context);
                      },
                    ),
                    Container(
                      width: 35 * SizeConfig.blockSizeHorizontal,
                    ),
                    FlatButton(
                      child: Text("Salvar",textScaleFactor: 1),
                      onPressed: (){
                        if(dateNull) {
                          monthIndex(x);
                          print("Pronto para salvar!!");
                        }else{
                          print("Data nula");
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
          );
        });


  }

  Future<bool> _requestPop(){
    if(outrosGastos1Edited == true || outrosGastos2Edited == true ){
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title: Text("Descartar Alterações?",textScaleFactor: 1),
          content: Text("Se sair suas alterações serão perdidas.",textScaleFactor: 1),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancelar",textScaleFactor: 1),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text("Sim, Sair",textScaleFactor: 1),
              onPressed: (){
                Navigator.pop(context);
                Navigator.pop(context);
              },
            )
          ],
        );
      }
      );
      return Future.value(false);
    } else{
      return Future.value(true);
    }

  }

}

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:despesas_galinhas/ui/Class/YearClass/year_mapGAnimais.dart';
import 'package:despesas_galinhas/ui/Class/size_config.dart';
import 'package:despesas_galinhas/ui/Class/jsonPath.dart';
import 'dart:convert';
import 'dart:io';
import 'package:despesas_galinhas/ui/Class/loadJsons.dart';
import 'package:despesas_galinhas/ui/Gastos/GastosFGM/saveAllDataFGM.dart';

enum SaveInfo {saveFarmacia,saveGasolina,saveMercado,saveAll}

class GastosFGM extends StatefulWidget {
  @override
  _GastosFGMState createState() => _GastosFGMState();
}

class _GastosFGMState extends State<GastosFGM> {
  final valorFarmaciaController = TextEditingController(text: "0.00");
  final nomeFarmaciaController = TextEditingController();
  final valorGasolinaController = TextEditingController(text: "0.00");
  final nomeGasolinaController = TextEditingController();
  final valorMercadoController = TextEditingController(text: "0.00");
  final nomeMercadoController = TextEditingController();
  TextEditingController dateControllerTxt = TextEditingController();

  DateTime _dateTime = DateTime.now();

  bool farmaciaEdited = false;
  bool gasolinaEdited = false;
  bool mercadoEdited = false;
  int indexDropDown = 0;
  int indexYearDropDown = 0;
  Map<String, dynamic> fileContentFarmacia;
  Map<String, dynamic> fileContentGasolina;
  Map<String, dynamic> fileContentMercado;
  Map<String, dynamic> fieldContent;
  String jsonStartFarmacia = "farmacia";
  String jsonStartGasolina = "gasolina";
  String jsonStartMercado = "mercado";
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
          title: Text("Gastos Gerais",
            textScaleFactor: 1,
            style: TextStyle(fontSize: 5 * SizeConfig.blockSizeHorizontal),
          ),
          actions: [
            PopupMenuButton<SaveInfo>(
              itemBuilder: (context) => <PopupMenuEntry<SaveInfo>>[
                const PopupMenuItem(
                  child: Text("Salvar Dados da Farmácia"),
                  value: SaveInfo.saveFarmacia,
                ),
                const PopupMenuItem(
                    child: Text("Salvar dados da Gasolina"),
                  value: SaveInfo.saveGasolina,
                ),
                const PopupMenuItem(
                    child: Text("Salvar dados do Mercado"),
                  value: SaveInfo.saveMercado,
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
              height: 6 * SizeConfig.blockSizeVertical,
            ),

            gastoFGMUIName(nomeFarmaciaController, valorFarmaciaController, "da Farmácia", 0),
            Container(
              height: 1 * SizeConfig.blockSizeVertical,
            ),
            //gastosFGMTextField(valorController),

            Container(
              height: 1 * SizeConfig.blockSizeVertical,
            ),

            gastoFGMUIName(nomeGasolinaController, valorGasolinaController, "do Posto de Gasolina", 1),
            Container(
              height: 1 * SizeConfig.blockSizeVertical,
            ),
            //gastosFGMTextField(valorController),

            Container(
              height: 1 * SizeConfig.blockSizeVertical,
            ),

            gastoFGMUIName(nomeMercadoController, valorMercadoController, "do Mercado", 2),
            Container(
              height: 1 * SizeConfig.blockSizeVertical,
            ),
           // gastosFGMTextField(valorController),
          ],
        ),
      ),
      ),
    );


  }

  Widget gastoFGMUIName(TextEditingController nameController, TextEditingController functionController,
      String nameFGM, int y
      ){

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
                      if(y == 0) {
                        if (valorFarmaciaController.text == "0.00") {
                          valorFarmaciaController.text = "";
                        }
                      }else if (y == 1){
                        if (valorGasolinaController.text == "0.00"){
                          valorGasolinaController.text = "";
                        }
                      }else if (y == 2){
                        if(valorMercadoController.text == "0.00"){
                          valorMercadoController.text = "";
                        }
                      }
                    },
                    onEditingComplete: (){
                      if(y == 0) {
                        farmaciaEdited = true;
                        if (valorFarmaciaController.text == "") {
                          valorFarmaciaController.text = "0.00";
                          farmaciaEdited = false;
                          FocusScope.of(context).unfocus();
                        }
                      } else if (y == 1){
                        gasolinaEdited = true;
                        if (valorGasolinaController.text == ""){
                          valorGasolinaController.text = "0.00";
                          gasolinaEdited = false;
                          FocusScope.of(context).unfocus();
                        }
                      }else if (y == 2){
                        mercadoEdited = true;
                        if(valorMercadoController.text == ""){
                          valorMercadoController.text = "0.00";
                          mercadoEdited = false;
                          FocusScope.of(context).unfocus();
                        }
                      }
                      FocusScope.of(context).unfocus();
                    },
                  )
              )],
          )
        ],
      )
    );
  }

  Future loadJson()async{
    fileContentFarmacia = await LoadJsons().loadJsonFarmacia;
    fileContentGasolina = await LoadJsons().loadJsonGasolina;
    fileContentMercado = await LoadJsons().loadJsonMercado;
  }

  @override
  void initState() {
    super.initState();
    loadJson();
  }

  void saveAllPopUp(SaveInfo save){
    switch(save){
      case SaveInfo.saveFarmacia:
        checkFieldFarmacia(0);
        break;
      case SaveInfo.saveGasolina:
        checkFieldGasolina(1);
        break;
      case SaveInfo.saveMercado:
        checkFieldMercado(2);
        break;
      case SaveInfo.saveAll:
        checkFieldFarmacia(3);
        break;
    }

  }

  void checkFieldFarmacia(int x){
    if(valorFarmaciaController.text == "0.00" && nomeFarmaciaController.text == "" ){
      inputValueInFields("Não foram inseridos um nome e nem um valor nos campos da Farmácia. Insira um nome e um valor antes de salvar");
    } else if(valorFarmaciaController.text == "0.00" && nomeFarmaciaController.text != ""){
      inputValueInFields("Não foi inserido o valor gasto na Farmácia. Insira um valor primeiro antes de salvar");
    } else if(valorFarmaciaController.text != "0.00" && nomeFarmaciaController.text == ""){
      inputValueInFields("Não foi inserido um nome da Farmácia. Insira um nome antes de salvar");
    } else if (x == 0){
      print("Check Field");
      alertSaveButton(x);
    } else if (x == 3){
      checkFieldGasolina(3);
    }
  }

  void checkFieldGasolina(int x){
    if(valorGasolinaController.text == "0.00" && nomeGasolinaController.text == "" ){
      inputValueInFields("Não foram inseridos um nome e nem um valor nos campos do Posto de Gasolina. Insira um nome e um valor antes de salvar");
    } else if(valorGasolinaController.text == "0.00" && nomeGasolinaController.text != ""){
      inputValueInFields("Não foi inserido o valor gasto na Gasolina. Insira um valor primeiro antes de salvar");
    } else if(valorGasolinaController.text != "0.00" && nomeGasolinaController.text == ""){
      inputValueInFields("Não foi inserido um nome do Posto. Insira um nome antes de salvar");
    } else if (x == 1){
      alertSaveButton(x);
    } else if (x == 3){
      checkFieldMercado(3);
    }
  }

  void checkFieldMercado(int x){
    if(valorMercadoController.text == "0.00" && nomeMercadoController.text == "" ){
      inputValueInFields("Não foram inseridos um nome e nem um valor nos campos do Mercado. Insira um nome e um valor antes de salvar");
    } else if(valorMercadoController.text == "0.00" && nomeMercadoController.text != ""){
      inputValueInFields("Não foi inserido o valor gasto no Mercado. Insira um valor primeiro antes de salvar");
    } else if(valorMercadoController.text != "0.00" && nomeMercadoController.text == ""){
      inputValueInFields("Não foi inserido um nome do Mercado. Insira um nome antes de salvar");
    } else if (x == 2){
      alertSaveButton(x);
    }else if (x == 3){
      alertSaveButton(3);
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
        content: Text("O item foi salvo com sucesso. Deseja salvar outro item?",textScaleFactor: 1),
        actions: <Widget>[
          FlatButton(
            child: Text("Sim",textScaleFactor: 1),
            onPressed: (){
             valorFarmaciaController.text = "0.00";
             nomeFarmaciaController.text = "";
             valorGasolinaController.text = "0.00";
             nomeGasolinaController.text = "";
             valorMercadoController.text = "0.00";
             nomeMercadoController.text = "";
             dateControllerTxt.text = "";
             Navigator.pop(context);
             Navigator.pop(context);
            },
          ),
          FlatButton(
            child: Text("Não", textScaleFactor: 1,),
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

  Future saveDataAll() async{
    SaveAllData().saveData(jsonStartFarmacia, jsonStartGasolina, jsonStartMercado, dateText,
        indexYearDropDown, chooseYear, indexDropDown, chooseMonth,
        fileContentFarmacia, fileContentGasolina, fileContentMercado, fieldContent,
        nomeFarmaciaController, valorFarmaciaController, nomeGasolinaController,
        valorGasolinaController, nomeMercadoController, valorMercadoController,
        saveSuccessful);
  }
  Future<File> saveDataFarmacia() async{
    final file = await JsonPath().localFileFarmaciaJson;
    int increment = 0;
    increment = fileContentFarmacia[jsonStartFarmacia][indexYearDropDown][chooseYear][indexDropDown][chooseMonth]["LengthIncrement"];
    if(fileContentFarmacia[jsonStartFarmacia][indexYearDropDown][chooseYear][indexDropDown][chooseMonth].containsKey("Datas$increment")){
      increment++;
      fieldContent = {"Datas$increment": {"Data": "", "Valores": []}};
      fileContentFarmacia[jsonStartFarmacia][indexYearDropDown][chooseYear][indexDropDown][chooseMonth]
          .addAll(fieldContent);

      fileContentFarmacia[jsonStartFarmacia][indexYearDropDown][chooseYear][indexDropDown][chooseMonth]["Datas$increment"]["Data"] =
          dateText;

      (fileContentFarmacia[jsonStartFarmacia][indexYearDropDown][chooseYear][indexDropDown][chooseMonth]["Datas$increment"]["Valores"])
          .addAll([nomeFarmaciaController.text ,double.parse(valorFarmaciaController.text)]);

      fileContentFarmacia[jsonStartFarmacia][indexYearDropDown][chooseYear][indexDropDown][chooseMonth]["LengthIncrement"] = increment;
    }else{

      fieldContent = {"Datas$increment": {"Data": "", "Valores": []}};
      fileContentFarmacia[jsonStartFarmacia][indexYearDropDown][chooseYear][indexDropDown][chooseMonth]
          .addAll(fieldContent);

      fileContentFarmacia[jsonStartFarmacia][indexYearDropDown][chooseYear][indexDropDown][chooseMonth]["Datas$increment"]["Data"] =
          dateText;

      (fileContentFarmacia[jsonStartFarmacia][indexYearDropDown][chooseYear][indexDropDown][chooseMonth]["Datas$increment"]["Valores"])
          .addAll([nomeFarmaciaController.text ,double.parse(valorFarmaciaController.text)]);

      increment++;

      fileContentFarmacia[jsonStartFarmacia][indexYearDropDown][chooseYear][indexDropDown][chooseMonth]["LengthIncrement"] = increment;
    }

    fileContentFarmacia[jsonStartFarmacia][indexYearDropDown][chooseYear][indexDropDown][chooseMonth]["Valor"] = double.parse(valorFarmaciaController.text) +
        fileContentFarmacia[jsonStartFarmacia][indexYearDropDown][chooseYear][indexDropDown][chooseMonth]["Valor"];

    fileContentFarmacia[jsonStartFarmacia][indexYearDropDown]["Result"] = double.parse(valorFarmaciaController.text) + fileContentFarmacia[jsonStartFarmacia][indexYearDropDown]["Result"];

    Map<String, dynamic> newMapRootJson = json.decode(
        file.readAsStringSync());
    newMapRootJson.addAll(fileContentFarmacia);
    farmaciaEdited = false;
    saveSuccessful();
    print(fileContentFarmacia[jsonStartFarmacia][indexYearDropDown][chooseYear][indexDropDown][chooseMonth]);
    return file.writeAsString(json.encode(newMapRootJson));
  }

  Future<File> saveDataGasolina() async{
    final file = await JsonPath().localFileGasolinaJson;
    int increment = 0;
    increment = fileContentGasolina[jsonStartGasolina][indexYearDropDown][chooseYear][indexDropDown][chooseMonth]["LengthIncrement"];
    if(fileContentGasolina[jsonStartGasolina][indexYearDropDown][chooseYear][indexDropDown][chooseMonth].containsKey("Datas$increment")){
      increment++;
      fieldContent = {"Datas$increment": {"Data": "", "Valores": []}};
      fileContentGasolina[jsonStartGasolina][indexYearDropDown][chooseYear][indexDropDown][chooseMonth]
          .addAll(fieldContent);

      fileContentGasolina[jsonStartGasolina][indexYearDropDown][chooseYear][indexDropDown][chooseMonth]["Datas$increment"]["Data"] =
          dateText;

      (fileContentGasolina[jsonStartGasolina][indexYearDropDown][chooseYear][indexDropDown][chooseMonth]["Datas$increment"]["Valores"])
          .addAll([nomeGasolinaController.text ,double.parse(valorGasolinaController.text)]);

      fileContentGasolina[jsonStartGasolina][indexYearDropDown][chooseYear][indexDropDown][chooseMonth]["LengthIncrement"] = increment;
    }else{

      fieldContent = {"Datas$increment": {"Data": "", "Valores": []}};
      fileContentGasolina[jsonStartGasolina][indexYearDropDown][chooseYear][indexDropDown][chooseMonth]
          .addAll(fieldContent);

      fileContentGasolina[jsonStartGasolina][indexYearDropDown][chooseYear][indexDropDown][chooseMonth]["Datas$increment"]["Data"] =
          dateText;

      (fileContentGasolina[jsonStartGasolina][indexYearDropDown][chooseYear][indexDropDown][chooseMonth]["Datas$increment"]["Valores"])
          .addAll([nomeGasolinaController.text ,double.parse(valorGasolinaController.text)]);

      increment++;

      fileContentGasolina[jsonStartGasolina][indexYearDropDown][chooseYear][indexDropDown][chooseMonth]["LengthIncrement"] = increment;
    }

    fileContentGasolina[jsonStartGasolina][indexYearDropDown][chooseYear][indexDropDown][chooseMonth]["Valor"] = double.parse(valorGasolinaController.text) +
        fileContentGasolina[jsonStartGasolina][indexYearDropDown][chooseYear][indexDropDown][chooseMonth]["Valor"];

    fileContentGasolina[jsonStartGasolina][indexYearDropDown]["Result"] = double.parse(valorGasolinaController.text) + fileContentGasolina[jsonStartGasolina][indexYearDropDown]["Result"];

    Map<String, dynamic> newMapRootJson = json.decode(
        file.readAsStringSync());
    newMapRootJson.addAll(fileContentGasolina);
    gasolinaEdited = false;
    saveSuccessful();
    return file.writeAsString(json.encode(newMapRootJson));
  }

  Future<File> saveDataMercado() async{
    final file = await JsonPath().localFileMercadoJson;
    int increment = 0;
    increment = fileContentMercado[jsonStartMercado][indexYearDropDown][chooseYear][indexDropDown][chooseMonth]["LengthIncrement"];
    if(fileContentMercado[jsonStartMercado][indexYearDropDown][chooseYear][indexDropDown][chooseMonth].containsKey("Datas$increment")){
      increment++;
      fieldContent = {"Datas$increment": {"Data": "", "Valores": []}};
      fileContentMercado[jsonStartMercado][indexYearDropDown][chooseYear][indexDropDown][chooseMonth]
          .addAll(fieldContent);

      fileContentMercado[jsonStartMercado][indexYearDropDown][chooseYear][indexDropDown][chooseMonth]["Datas$increment"]["Data"] =
          dateText;

      (fileContentMercado[jsonStartMercado][indexYearDropDown][chooseYear][indexDropDown][chooseMonth]["Datas$increment"]["Valores"])
          .addAll([nomeMercadoController.text ,double.parse(valorMercadoController.text)]);

      fileContentMercado[jsonStartMercado][indexYearDropDown][chooseYear][indexDropDown][chooseMonth]["LengthIncrement"] = increment;
    }else{

      fieldContent = {"Datas$increment": {"Data": "", "Valores": []}};
      fileContentMercado[jsonStartMercado][indexYearDropDown][chooseYear][indexDropDown][chooseMonth]
          .addAll(fieldContent);

      fileContentMercado[jsonStartMercado][indexYearDropDown][chooseYear][indexDropDown][chooseMonth]["Datas$increment"]["Data"] =
          dateText;

      (fileContentMercado[jsonStartMercado][indexYearDropDown][chooseYear][indexDropDown][chooseMonth]["Datas$increment"]["Valores"])
          .addAll([nomeMercadoController.text ,double.parse(valorMercadoController.text)]);

      increment++;

      fileContentMercado[jsonStartMercado][indexYearDropDown][chooseYear][indexDropDown][chooseMonth]["LengthIncrement"] = increment;
    }

    fileContentMercado[jsonStartMercado][indexYearDropDown][chooseYear][indexDropDown][chooseMonth]["Valor"] = double.parse(valorMercadoController.text) +
        fileContentMercado[jsonStartMercado][indexYearDropDown][chooseYear][indexDropDown][chooseMonth]["Valor"];

    fileContentMercado[jsonStartMercado][indexYearDropDown]["Result"] = double.parse(valorMercadoController.text) + fileContentMercado[jsonStartMercado][indexYearDropDown]["Result"];

    Map<String, dynamic> newMapRootJson = json.decode(
        file.readAsStringSync());
    newMapRootJson.addAll(fileContentMercado);
    mercadoEdited = false;
    saveSuccessful();
    return file.writeAsString(json.encode(newMapRootJson));
  }


  void yearIndex(int x){
    int z = 2020;
    int y = 0;
    for(int i = 0; i <= fileContentFarmacia[jsonStartFarmacia].length; i++){
      if(_dateTime.year == z){
        indexYearDropDown = y;
        i = fileContentFarmacia[jsonStartFarmacia].length + 1;
        if(x == 0) {
          saveDataFarmacia();
          if(y == fileContentFarmacia[jsonStartFarmacia].length - 1){
            createNewYear();
          }
        }else if(x == 1){
          saveDataGasolina();
          if(y == fileContentFarmacia[jsonStartFarmacia].length - 1){
            createNewYear();
          }
        }else if(x == 2){
          saveDataMercado();
          if(y == fileContentFarmacia[jsonStartFarmacia].length - 1){
            createNewYear();
          }
        }else if(x == 3){
          saveDataAll();
          if(y == fileContentFarmacia[jsonStartFarmacia].length - 1){
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
    dateLength = fileContentFarmacia[jsonStartFarmacia].length;
    dateLength--;
    date = int.parse(fileContentFarmacia[jsonStartFarmacia][dateLength]["Ano"]);
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
    if(farmaciaEdited == true || gasolinaEdited == true || mercadoEdited == true){
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

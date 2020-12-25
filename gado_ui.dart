import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:despesas_galinhas/ui/Class/YearClass/year_mapGAnimais.dart';
import 'package:despesas_galinhas/ui/Class/jsonPath.dart';
import 'package:despesas_galinhas/ui/Class/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum SaveInfo {saveGado,saveLeite,saveQueijo,saveRequeijao,saveAll}

class GadoUI extends StatefulWidget {

  @override
  _GadoUIState createState() => _GadoUIState();
}


class _GadoUIState extends State<GadoUI> {
  final gadoController = TextEditingController(text: "0.00");
  final gadoQuantityController = TextEditingController(text: "0");
  final leiteController = TextEditingController(text: "0.00");
  final leiteQuantityController = TextEditingController(text: "0");
  final queijoController = TextEditingController(text: "0.00");
  final queijoQuantityController = TextEditingController(text: "0");
  final requeijaoController = TextEditingController(text: "0.00");
  final requeijaoQuantityController = TextEditingController(text: "0");
  TextEditingController dateControllerTxt = TextEditingController();

  DateTime _dateTime = DateTime.now();

  double finalResultGado = 0;
  double finalResultLeite = 0;
  double finalResultQueijo = 0;
  double finalResultRequeijao = 0;
  double gado;
  double leite;
  double queijo;
  double requeijao;
  double quantitiesG;
  double quantitiesL;
  double quantitiesQ;
  double quantitiesR;

  int indexDropDown = 0;
  int indexYearDropDown = 0;

  bool leiteEdited = false;
  bool gadoEdited = false;
  bool queijoEdited = false;
  bool requeijaoEdited = false;
  bool fileExists = false ;
  bool saveOnlyOneSuccessful = false;
  bool saveAllSuccessful = false;
  Map<String, dynamic> fileContent;
  Map<String, dynamic> fieldContent;
  String jsonStart = "gado";
  String chooseMonth = "Month";
  String chooseYear = "Year";
  String dateText;
  List<String> valoresSalvos = ["Valor","Qnt","Result"];

  Future loadJson() async{
    final fileGado =  await JsonPath().localFileGadoJson;
    fileContent = json.decode(fileGado.readAsStringSync());
    print(fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][0]["Gado"]);
  }



  Future createNewYear()async{
    Timer(Duration(milliseconds: 10),()
    {
      YearMapGAnimais().newYearGAnimaisFunction();
    });
  }


  void checkGadoNullField(int x) {
    if (double.parse(gadoController.text) >= 0.1 &&
        gadoQuantityController.text == "0") {
      inputValueInFields("a quantidade", "de Gado");
    }else if (int.parse(gadoQuantityController.text) >= 1 &&
        gadoController.text == "0.00") {
      inputValueInFields("o preço", "do Gado");
    } else if(gadoQuantityController.text == "0" && gadoController.text == "0.00" ){
      inputValueInFields("os dados", "dos dois campos");
    } else if(x == 0) {
      alertSaveButton(0);
    }else if(x == 4){
      checkLeiteNullField(4);
    }
  }

  void checkLeiteNullField(int x){
    if(double.parse(leiteController.text) >= 0.1 && leiteQuantityController.text == "0"){
      inputValueInFields("os litros ", "de Leite");
    }else if(int.parse(leiteQuantityController.text) >= 1 && leiteController.text == "0.00"){
      inputValueInFields("o preço", "do Leite");
    }else if(leiteController.text == "0.00" && leiteQuantityController.text == "0"){
      inputValueInFields("os dados", "dos dois campos");
    }else if(x == 1){
      alertSaveButton(1);

    }else if(x == 4){
      checkQueijoNullField(4);
    }
  }

  void checkQueijoNullField(int x){
    if(double.parse(queijoController.text) >= 0.1 && queijoQuantityController.text == "0"){
      inputValueInFields("a quantidade", "de Queijos");
    }else if(int.parse(queijoQuantityController.text) >= 1 && queijoController.text == "0.00"){
      inputValueInFields("o preço", "do Queijo");
    }else if(queijoController.text == "0.00" && queijoQuantityController.text == "0"){
      inputValueInFields("os dados", "dos dois campos");
    }else if (x == 2){
      alertSaveButton(2);
    }else if (x == 4){
      checkRequeijaoNullField(4);
    }
  }

  void checkRequeijaoNullField(int x){
    if(double.parse(requeijaoController.text) >= 0.1 && requeijaoQuantityController.text == "0"){
      inputValueInFields("a quantidade", "do Requeijão");
    }else if(int.parse(requeijaoQuantityController.text) >= 1 && requeijaoController.text == "0.00"){
      inputValueInFields("o preço", "do Requeijao");
    }else if(requeijaoQuantityController.text == "0" && requeijaoController.text == "0.00"){
      inputValueInFields("os dados", "dos dois campos");
    }else if (x == 3){
      alertSaveButton(3);
    }else if( x == 4){
      alertSaveButton(4);
    }
  }




  Future<File> saveDataGado() async{
    final file = await JsonPath().localFileGadoJson;
    int increment = 0;
    List<dynamic> fieldValuesGado = [gado,quantitiesG,finalResultGado];

    increment = fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][0]["Gado"]["LengthIncrement"];


    if(fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][0]["Gado"].containsKey("Datas$increment")){

      increment++;
      fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][0]["Gado"]["LengthIncrement"] =
          increment;

      fieldContent = {"Datas$increment": {"Data": "", "Valores": []}};

      fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][0]["Gado"]
          .addAll(fieldContent);

      fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][0]["Gado"]["Datas$increment"]["Data"] =
          dateText;


      (fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][0]["Gado"]["Datas$increment"]["Valores"])
          .addAll([gado, quantitiesG, finalResultGado]);


    }else {
      fieldContent = {"Datas$increment": {"Data": "", "Valores": []}};

      fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][0]["Gado"]
          .addAll(fieldContent);

      fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][0]["Gado"]["Datas$increment"]["Data"] =
          dateText;


      (fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][0]["Gado"]["Datas$increment"]["Valores"])
          .addAll([gado, quantitiesG, finalResultGado]);


      increment++;
      fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][0]["Gado"]["LengthIncrement"] =
          increment;
    }


    //Guardar valores no JSON do Gado
    for(int i = 0; i <= 2; i++){
      fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][0]["Gado"][valoresSalvos[i]] =
          fieldValuesGado[i] +
              fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][0]["Gado"][valoresSalvos[i]];
    }

    fileContent[jsonStart][indexYearDropDown]["Gado"]["Result"] = finalResultGado + fileContent[jsonStart][indexYearDropDown]["Gado"]["Result"];

    Map<String, dynamic> newMapRootJson = json.decode(
        file.readAsStringSync());
    newMapRootJson.addAll(fileContent);

    gadoEdited = false;
    if(saveOnlyOneSuccessful){
      saveSuccessful();
      saveOnlyOneSuccessful = false;
    }
    return file.writeAsString(json.encode(newMapRootJson));
  }
  Future saveDataLeite() async{
    final file = await JsonPath().localFileGadoJson;
    List<dynamic> fieldValuesLeite = [leite, quantitiesL, finalResultLeite];
    int increment = 0;


    increment = fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][1]["Leite"]["LengthIncrement"];

    if(fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][1]["Leite"].containsKey("Datas$increment")){

      increment++;
      fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][1]["Leite"]["LengthIncrement"] =
          increment;

      fieldContent = {"Datas$increment": {"Data": "", "Valores": []}};

      fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][1]["Leite"]
          .addAll(fieldContent);

      fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][1]["Leite"]["Datas$increment"]["Data"] =
          dateText;

      (fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][1]["Leite"]["Datas$increment"]["Valores"])
          .addAll([leite, quantitiesL, finalResultLeite]);


    }else {
      fieldContent = {"Datas$increment": {"Data": "", "Valores": []}};

      fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][1]["Leite"]
          .addAll(fieldContent);

      fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][1]["Leite"]["Datas$increment"]["Data"] =
          dateText;

      (fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][1]["Leite"]["Datas$increment"]["Valores"])
          .addAll([leite, quantitiesL, finalResultLeite]);

      increment++;
      fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][1]["Leite"]["LengthIncrement"] =
          increment;

    }


    //Guardar valores no JSON do Leite
    for(int i = 0; i <= 2; i++) {
      fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][1]["Leite"][valoresSalvos[i]] =
          fieldValuesLeite[i] +
              fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][1]["Leite"][valoresSalvos[i]];
    }
      fileContent[jsonStart][indexYearDropDown]["Leite"]["Result"] = finalResultLeite + fileContent[jsonStart][indexYearDropDown]["Leite"]["Result"];

      Map<String, dynamic> newMapRootJson = json.decode(
          file.readAsStringSync());
      newMapRootJson.addAll(fileContent);

      leiteEdited = false;
      if(saveOnlyOneSuccessful){
        saveSuccessful();
        saveOnlyOneSuccessful = false;
      }
      return file.writeAsString(json.encode(newMapRootJson));
    }

  Future saveDataQueijo() async{
    final file = await JsonPath().localFileGadoJson;
    List<dynamic> fieldValuesQueijo = [queijo, quantitiesQ, finalResultQueijo];
    int increment = 0;

    increment = fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][2]["Queijo"]["LengthIncrement"];
    if(fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][2]["Queijo"].containsKey("Datas$increment")){

      increment++;
      fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][2]["Queijo"]["LengthIncrement"] =
          increment;

      fieldContent = {"Datas$increment": {"Data": "", "Valores": []}};

      fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][2]["Queijo"]
          .addAll(fieldContent);

      fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][2]["Queijo"]["Datas$increment"]["Data"] =
          dateText;


      (fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][2]["Queijo"]["Datas$increment"]["Valores"])
          .addAll([queijo, quantitiesQ, finalResultQueijo]);


    }else {
      fieldContent = {"Datas$increment": {"Data": "", "Valores": []}};


      fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][2]["Queijo"]
          .addAll(fieldContent);

      fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][2]["Queijo"]["Datas$increment"]["Data"] =
          dateText;


      (fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][2]["Queijo"]["Datas$increment"]["Valores"])
          .addAll([queijo, quantitiesQ, finalResultQueijo]);


      increment++;
      fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][2]["Queijo"]["LengthIncrement"] =
          increment;

    }

    //Guardar valores no JSON do Queijo
    for(int i = 0; i <= 2; i++){
      fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][2]["Queijo"][valoresSalvos[i]] =
          fieldValuesQueijo[i] +
              fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][2]["Queijo"][valoresSalvos[i]];
    }

    fileContent[jsonStart][indexYearDropDown]["Queijo"]["Result"] = finalResultQueijo + fileContent[jsonStart][indexYearDropDown]["Queijo"]["Result"];

    Map<String, dynamic> newMapRootJson = json.decode(
        file.readAsStringSync());
    newMapRootJson.addAll(fileContent);

    queijoEdited = false;
    if(saveOnlyOneSuccessful){
      saveSuccessful();
      saveOnlyOneSuccessful = false;
    }
    return file.writeAsString(json.encode(newMapRootJson));

  }

  Future saveDataRequeijao() async{
    final file = await JsonPath().localFileGadoJson;
    List<dynamic> fieldValuesRequeijao = [requeijao, quantitiesR, finalResultRequeijao];
    int increment = 0;

    increment = fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][3]["Requeijao"]["LengthIncrement"];

    if(fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][3]["Requeijao"].containsKey("Datas$increment")){

      increment++;
      fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][3]["Requeijao"]["LengthIncrement"] =
          increment;

      fieldContent = {"Datas$increment": {"Data": "", "Valores": []}};

      fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][3]["Requeijao"]
          .addAll(fieldContent);

      fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][3]["Requeijao"]["Datas$increment"]["Data"] =
          dateText;


      (fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][3]["Requeijao"]["Datas$increment"]["Valores"])
          .addAll([requeijao, quantitiesR, finalResultRequeijao]);


    }else {
      fieldContent = {"Datas$increment": {"Data": "", "Valores": []}};


      fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][3]["Requeijao"]
          .addAll(fieldContent);

      fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][3]["Requeijao"]["Datas$increment"]["Data"] =
          dateText;


      (fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][3]["Requeijao"]["Datas$increment"]["Valores"])
          .addAll([requeijao, quantitiesR, finalResultRequeijao]);


      increment++;
      fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][3]["Requeijao"]["LengthIncrement"] =
          increment;

    }

    //Guardar valores no JSON do Requeijão
    for(int i = 0; i <= 2; i++){
      fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][3]["Requeijao"][valoresSalvos[i]] =
          fieldValuesRequeijao[i] +
              fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][3]["Requeijao"][valoresSalvos[i]];
    }

    fileContent[jsonStart][indexYearDropDown]["Requeijao"]["Result"] = finalResultRequeijao + fileContent[jsonStart][indexYearDropDown]["Requeijao"]["Result"];

    Map<String, dynamic> newMapRootJson = json.decode(
        file.readAsStringSync());
    newMapRootJson.addAll(fileContent);

    requeijaoEdited = false;
    if(saveAllSuccessful){
      saveSuccessful();
      saveAllSuccessful = false;
    }else if(saveOnlyOneSuccessful){
      saveSuccessful();
      saveOnlyOneSuccessful = false;
    }

    return file.writeAsString(json.encode(newMapRootJson));
  }

  void inputValueInFields(String nameField, String priceQnt){
    showDialog(context: context,barrierDismissible: false ,builder: (context){
      return AlertDialog(
        title: Text("Erro!",textScaleFactor: 1),
        content: Text("Está faltando inserir $nameField $priceQnt",textScaleFactor: 1),
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
            child: Text("Sim",textScaleFactor: 1),
            onPressed: (){
              setState(() {
                gadoController.text = "0.00";
                gadoQuantityController.text = "0";
                leiteController.text = "0.00";
                leiteQuantityController.text = "0";
                queijoController.text = "0.00";
                queijoQuantityController.text = "0";
                requeijaoController.text = "0.00";
                requeijaoQuantityController.text = "0";
                dateControllerTxt.text = "";
                finalResultGado = 0;
                finalResultLeite = 0;
                finalResultQueijo = 0;
                finalResultRequeijao = 0;
              });

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

  void yearIndex(int z){
    int x = 2020;
    int y = 0;
    for(int i = 0; i <= fileContent[jsonStart].length; i++){
      if(_dateTime.year == x){
        indexYearDropDown = y;
        i = fileContent[jsonStart].length + 1;
        if(z == 0){
          saveDataGado();
          saveOnlyOneSuccessful = true;
          if(y == fileContent[jsonStart].length - 1){
            createNewYear();
          }
        }else if(z == 1){
          print("Teste: ${fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth]}");
          saveDataLeite();
          print("SaveDataLeite");

          saveOnlyOneSuccessful = true;
          if(y == fileContent[jsonStart].length - 1){
            createNewYear();
          }
        }else if(z == 2){
          saveDataQueijo();
          saveOnlyOneSuccessful = true;
          if(y == fileContent[jsonStart].length - 1){
            createNewYear();
          }
        }else if(z == 3){
          saveDataRequeijao();
          saveOnlyOneSuccessful = true;
          if(y == fileContent[jsonStart].length - 1){
            createNewYear();
          }
        }else if(z == 4){
          saveDataGado();
          Timer(Duration(milliseconds: 50), () {
            saveDataLeite();
          });
          Timer(Duration(milliseconds: 100), () {
            saveDataQueijo();
          });
          Timer(Duration(milliseconds: 150), () {
            saveDataRequeijao();
            saveAllSuccessful = true;
          });

          if(y == fileContent[jsonStart].length - 1){
            createNewYear();
          }
        }
      }else {
        x++;
        y++;
      }
    }
  }

  void monthIndex(int x){
    int z = 1;
    int u = 0;
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
    dateLength = fileContent[jsonStart].length;
    dateLength--;
    date = int.parse(fileContent[jsonStart][dateLength]["Ano"]);
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


  @override
  void initState() {
    super.initState();
    loadJson();

  }


  void saveAllPopUp(SaveInfo save){
    switch(save){
      case SaveInfo.saveGado:
        checkGadoNullField(0);
        break;
      case SaveInfo.saveLeite:
        checkLeiteNullField(1);
        break;
      case SaveInfo.saveQueijo:
        checkQueijoNullField(2);
        break;
      case SaveInfo.saveRequeijao:
        checkRequeijaoNullField(3);
        break;
      case SaveInfo.saveAll:
        checkGadoNullField(4);
    }

  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
        onWillPop: _requestPop,
        child: Scaffold(
          backgroundColor: Colors.brown,
          appBar: AppBar(
            centerTitle: true,
            title: Text("Gado e seus Derivados",
              textScaleFactor: 1,
              style: TextStyle(fontSize: 5 * SizeConfig.blockSizeHorizontal),
            ),
            backgroundColor: Colors.green,
            actions: [
              PopupMenuButton<SaveInfo>(
                itemBuilder: (context) => <PopupMenuEntry<SaveInfo>>[
                  const PopupMenuItem(
                    child: Text("Salvar Dados do Gado"),
                    value: SaveInfo.saveGado,
                  ),
                  const PopupMenuItem(
                    child: Text("Salvar Dados do Leite"),
                    value: SaveInfo.saveLeite,
                  ),
                  const PopupMenuItem(
                    child: Text("Salvar Dados do Queijo"),
                    value: SaveInfo.saveQueijo,
                  ),
                  const PopupMenuItem(
                    child: Text("Salvar Dados do Requeijão"),
                    value: SaveInfo.saveRequeijao,
                  ),
                  const PopupMenuItem(
                    child: Text("Salvar Todos os Dados "),
                    value: SaveInfo.saveAll,
                  ),
                ],
                onSelected: saveAllPopUp,
              )
            ],
          ),
          body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 5 * SizeConfig.blockSizeVertical,
                  ),
                  itemName("Gado"),
                  despesasUIFunction("Preço" , "Quantidade", gadoController, gadoQuantityController, finalResultGado, resultFunctionGado,0,1),
                  Container(
                    height: 10 * SizeConfig.blockSizeVertical,
                  ),
                  itemName("Leite"),
                  despesasUIFunction("Preço", "Litros",leiteController, leiteQuantityController, finalResultLeite, resultFunctionLeite,2,3),
                  Container(
                    height: 10 * SizeConfig.blockSizeVertical,
                  ),
                  itemName("Queijo"),
                  despesasUIFunction("Preço", "Quantidade",queijoController, queijoQuantityController, finalResultQueijo, resultFunctionQueijo,4,5),
                  Container(
                    height: 10 * SizeConfig.blockSizeVertical,
                  ),
                  itemName("Requeijão"),
                  despesasUIFunction("Preço", "Quantidade",requeijaoController, requeijaoQuantityController, finalResultRequeijao, resultFunctionRequeijao,6,7),
                  Container(
                    height: 5 * SizeConfig.blockSizeVertical,
                  ),
                ],
              )
          ),
        )
    );
  }

  Widget itemName(String name1){
    return  Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 2.5 * SizeConfig.blockSizeHorizontal, bottom: SizeConfig.blockSizeHorizontal),
          child: Text(name1,
            textScaleFactor: 1,
            style: TextStyle(
              fontSize: 8 * SizeConfig.blockSizeHorizontal,
            ),
          ),
        )
      ],
    );
  }

  Widget despesasUIFunction(
      String labelTxt1, String labelTxt2,
      TextEditingController textEditingController1,
      TextEditingController textEditingController2,
      double finalResult,
      Function functionDecider, int controllerIndex, int controllerQntIndex){
    return Container(
      height: 15 * SizeConfig.blockSizeVertical,
      width: 98 * SizeConfig.blockSizeHorizontal,
      decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
              side: BorderSide(width: 2.0, style: BorderStyle.solid),
              borderRadius: BorderRadius.all(Radius.circular(15.0))
          )
      ),
      child: Row(
        children: [
          Container(
            width:  25 * SizeConfig.blockSizeHorizontal,
            padding: EdgeInsets.only(left: 3 * SizeConfig.blockSizeHorizontal, right: SizeConfig.blockSizeHorizontal),
            child: TextField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                prefixText: "R\$",
                labelText: labelTxt1,
                border: OutlineInputBorder(),

              ),
              controller: textEditingController1,
              onChanged: functionDecider,
              onTap: (){
                if(controllerIndex == 0) {
                  gadoController.text = "";
                } else if(controllerIndex == 2){
                  leiteController.text = "";
                } else if(controllerIndex == 4){
                  queijoController.text = "";
                } else if(controllerIndex == 6){
                  requeijaoController.text = "";
                }
              },
              onEditingComplete: () {
                if (controllerIndex == 0) {
                  if (gadoController.text == "") {
                    gadoController.text = "0.00";
                    FocusScope.of(context).unfocus();
                  }
                }else if(controllerIndex == 2){
                  if(leiteController.text == ""){
                    leiteController.text = "0.00";
                    FocusScope.of(context).unfocus();
                  }
                }else if(controllerIndex == 4){
                  if(queijoController.text == ""){
                    queijoController.text = "0.00";
                    FocusScope.of(context).unfocus();
                  }
                }else if(controllerIndex == 6){
                  if(requeijaoController.text == ""){
                    requeijaoController.text = "0.00";
                    FocusScope.of(context).unfocus();
                  }
                }
                FocusScope.of(context).unfocus();
              },
            ),
          ),
          Icon(
              Icons.close
          ),

          Container(
            width: 35 * SizeConfig.blockSizeHorizontal,

            child: TextField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: labelTxt2,
                border: OutlineInputBorder(),

              ),
              controller: textEditingController2,
              onChanged: functionDecider,
              onTap: (){
                if(controllerQntIndex == 1) {
                  gadoQuantityController.text = "";
                }else if(controllerQntIndex == 3){
                  leiteQuantityController.text = "";
                }else if(controllerQntIndex == 5){
                  queijoQuantityController.text = "";
                }else if(controllerQntIndex == 7){
                  requeijaoQuantityController.text = "";
                }
              },
              onEditingComplete: (){
                if (controllerQntIndex == 1) {
                  if (gadoQuantityController.text == "") {
                    gadoQuantityController.text = "0";
                    FocusScope.of(context).unfocus();
                  }
                }else if(controllerQntIndex == 3){
                  if(leiteQuantityController.text == ""){
                    leiteQuantityController.text = "0";
                    FocusScope.of(context).unfocus();
                  }
                }else if(controllerQntIndex == 5){
                  if(queijoQuantityController.text == ""){
                    queijoQuantityController.text = "0";
                    FocusScope.of(context).unfocus();
                  }
                }else if(controllerQntIndex == 7){
                  if(requeijaoQuantityController.text == ""){
                    requeijaoQuantityController.text = "0";
                    FocusScope.of(context).unfocus();
                  }
                }
                FocusScope.of(context).unfocus();
              },

            ),
          ),
          Icon(
              Icons.drag_handle
          ),


          Container(
            alignment: Alignment.center,
            height: 15 * SizeConfig.blockSizeHorizontal,
            decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1.0, style: BorderStyle.solid),
                    borderRadius: BorderRadius.all(Radius.circular(7.0))
                )
            ),
            child: Text("R\$${(finalResult).toStringAsFixed(1)}0",
              textScaleFactor: 1,
              style: TextStyle(fontSize: 4 * SizeConfig.blockSizeHorizontal),
              textAlign: TextAlign.center,),
          )
        ],
      ),
    );
  }

  void resultFunctionGado(String text){
    setState(() {
      gado = double.parse(gadoController.text);
      quantitiesG = double.parse(gadoQuantityController.text);
      finalResultGado = gado * quantitiesG;
      gadoEdited = true;
    });

  }

  void resultFunctionLeite(String text){
    setState(() {
      leite = double.parse(leiteController.text);
      quantitiesL = double.parse(leiteQuantityController.text);
      finalResultLeite = leite * quantitiesL;
      leiteEdited = true;
    });

  }

  void resultFunctionQueijo(String text){
    setState(() {
      queijo = double.parse(queijoController.text);
      quantitiesQ = double.parse(queijoQuantityController.text);
      finalResultQueijo = queijo * quantitiesQ;
      queijoEdited = true;
    });
  }

  void resultFunctionRequeijao(String text){
    setState(() {
      requeijao = double.parse(requeijaoController.text);
      quantitiesR = double.parse(requeijaoQuantityController.text);
      finalResultRequeijao = requeijao * quantitiesR;
      requeijaoEdited = true;
    });
  }

  Future<bool> _requestPop(){
    if(gadoEdited == true || leiteEdited == true || queijoEdited == true || requeijaoEdited == true){
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








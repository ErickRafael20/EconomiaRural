//import 'dart:html';
import 'dart:async';
import 'dart:convert';
import 'package:despesas_galinhas/ui/Class/YearClass/year_mapGAnimais.dart';
import 'package:despesas_galinhas/ui/Class/size_config.dart';
import 'package:despesas_galinhas/ui/Class/jsonPath.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:despesas_galinhas/ui/Class/loadJsons.dart';

enum SaveInfo {saveMilho,saveCanjica,saveSal,saveRacao,saveAll}

class DespesasUI extends StatefulWidget {
  @override
  _DespesasUIState createState() => _DespesasUIState();
}


class _DespesasUIState extends State<DespesasUI> {
  final milhoController = TextEditingController(text: "0.00");
  final milhoQuantityController = TextEditingController(text: "0");
  final canjicaController = TextEditingController(text: "0.00");
  final canjicaQuantityController = TextEditingController(text: "0");
  final salController = TextEditingController(text: "0.00");
  final salQuantityController = TextEditingController(text: "0");
  final racaoController = TextEditingController(text: "0.00");
  final racaoQuantityController = TextEditingController(text: "0");
  TextEditingController dateControllerTxt = TextEditingController();

  DateTime _dateTime = DateTime.now();

  double finalResultMilho = 0;
  double finalResultCanjica = 0;
  double finalResultSal = 0;
  double finalResultRacao = 0;
  double milho;
  double canjica;
  double sal;
  double racao;
  double quantitiesM;
  double quantitiesC;
  double quantitiesS;
  double quantitiesR;

  int indexDropDown = 0;
  int indexYearDropDown = 0;

  bool canjicaEdited = false;
  bool milhoEdited = false;
  bool salEdited = false;
  bool racaoEdited = false;
  bool fileExists = false ;
  bool saveOnlyOneSuccessful = false;
  bool saveAllSuccessful = false;
  Map<String, dynamic> fileContent;
  Map<String, dynamic> fieldContent;
  String jsonStart = "despesas";
  String chooseMonth = "Month";
  String chooseYear = "Year";
  String dateText;
  List<String> gastosNome = ["Milho","Canjica","Sal","Ração"];
  List<String> valoresSalvos = ["Valor","Qnt","Result"];


  Future loadJson() async{
    fileContent = await LoadJsons().loadJsonGAnimais;
  }



  Future createNewYear()async{
    Timer(Duration(milliseconds: 10),()
    {
      YearMapGAnimais().newYearGAnimaisFunction();
    });
  }
  void checkMilhoNullField(int x) {
  if(double.parse(milhoController.text) >= 0.1 &&
  milhoQuantityController.text == "0") {
  inputValueInFields("a quantidade", "de sacos de Milho");
  }else if (int.parse(milhoQuantityController.text) >= 1 &&
  milhoController.text == "0.00") {
  inputValueInFields("o preço", "do Milho");
  } else if(milhoQuantityController.text == "0" && milhoController.text == "0.00" ){
  inputValueInFields("os dados", "dos dois campos");
  } else if(x == 0) {
  print(fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth]);
  alertSaveButton(0);
  }else if(x == 4){
  checkCanjicaNullField(4);
  }
}

void checkCanjicaNullField(int x){
  if(double.parse(canjicaController.text) >= 0.1 && canjicaQuantityController.text == "0"){
    inputValueInFields("a quantidade", "de sacos de Canjica");
  }else if(int.parse(canjicaQuantityController.text) >= 1 && canjicaController.text == "0.00"){
    inputValueInFields("o preço", "da Canjica");
  }else if(canjicaController.text == "0.00" && canjicaQuantityController.text == "0"){
    inputValueInFields("os dados", "dos dois campos");
  }else if(x == 1){
    alertSaveButton(1);
  }else if(x == 4){
    checkSalNullField(4);
  }
}

void checkSalNullField(int x){
  if(double.parse(salController.text) >= 0.1 && salQuantityController.text == "0"){
    inputValueInFields("a quantidade", "de sacos de Sal");
  }else if(int.parse(salQuantityController.text) >= 1 && salController.text == "0.00"){
    inputValueInFields("o preço", "do Sal");
  }else if(salController.text == "0.00" && salQuantityController.text == "0"){
    inputValueInFields("os dados", "dos dois campos");
  }else if (x == 2){
    alertSaveButton(2);
  }else if (x == 4){
    checkRacaoNullField(4);
  }
}

void checkRacaoNullField(int x){
  if(double.parse(racaoController.text) >= 0.1 && racaoQuantityController.text == "0"){
    inputValueInFields("a quantidade", "de sacos de Ração");
  }else if(int.parse(racaoQuantityController.text) >= 1 && racaoController.text == "0.00"){
    inputValueInFields("o preço", "da Ração");
  }else if(racaoQuantityController.text == "0" && racaoController.text == "0.00"){
    inputValueInFields("os dados", "dos dois campos");
  }else if (x == 3){
    alertSaveButton(3);
  }else if( x == 4){
    alertSaveButton(4);
  }
}




Future<File> saveDataMilho() async{
  final file = await JsonPath().localGAnimaisFileJson;
  int increment = 0;
  List<dynamic> fieldValuesMilho = [milho,quantitiesM,finalResultMilho];

  increment = fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][0]["Milho"]["LengthIncrement"];


  if(fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][0]["Milho"].containsKey("Datas$increment")){

    increment++;
    fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][0]["Milho"]["LengthIncrement"] =
        increment;

    fieldContent = {"Datas$increment": {"Data": "", "Valores": []}};

    fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][0]["Milho"]
        .addAll(fieldContent);

    fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][0]["Milho"]["Datas$increment"]["Data"] =
        dateText;


    (fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][0]["Milho"]["Datas$increment"]["Valores"])
        .addAll([milho, quantitiesM, finalResultMilho]);


  }else {
    fieldContent = {"Datas$increment": {"Data": "", "Valores": []}};

    fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][0]["Milho"]
        .addAll(fieldContent);

    fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][0]["Milho"]["Datas$increment"]["Data"] =
        dateText;


    (fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][0]["Milho"]["Datas$increment"]["Valores"])
        .addAll([milho, quantitiesM, finalResultMilho]);


    increment++;
    fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][0]["Milho"]["LengthIncrement"] =
        increment;
  }


  //Guardar valores no JSON do Milho
  for(int i = 0; i <= 2; i++){
    fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][0]["Milho"][valoresSalvos[i]] =
        fieldValuesMilho[i] +
            fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][0]["Milho"][valoresSalvos[i]];
    print(valoresSalvos[i]);
    print(fieldValuesMilho[i]);
  }

  fileContent[jsonStart][indexYearDropDown]["Milho"]["Result"] = finalResultMilho + fileContent[jsonStart][indexYearDropDown]["Milho"]["Result"];


  print(fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][0]["Milho"]);
  Map<String, dynamic> newMapRootJson = json.decode(
      file.readAsStringSync());
  newMapRootJson.addAll(fileContent);

  milhoEdited = false;
  if(saveOnlyOneSuccessful){
    saveSuccessful();
    saveOnlyOneSuccessful = false;
  }
  return file.writeAsString(json.encode(newMapRootJson));
}
Future saveDataCanjica() async{
  final file = await JsonPath().localGAnimaisFileJson;
  List<dynamic> fieldValuesCanjica = [canjica, quantitiesC, finalResultCanjica];
  int increment = 0;

  increment = fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][1]["Canjica"]["LengthIncrement"];

  if(fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][1]["Canjica"].containsKey("Datas$increment")){

    increment++;
    fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][1]["Canjica"]["LengthIncrement"] =
        increment;

    fieldContent = {"Datas$increment": {"Data": "", "Valores": []}};

    fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][1]["Canjica"]
        .addAll(fieldContent);

    fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][1]["Canjica"]["Datas$increment"]["Data"] =
        dateText;

    (fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][1]["Canjica"]["Datas$increment"]["Valores"])
        .addAll([canjica, quantitiesC, finalResultCanjica]);


  }else {
    fieldContent = {"Datas$increment": {"Data": "", "Valores": []}};

    fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][1]["Canjica"]
        .addAll(fieldContent);

    fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][1]["Canjica"]["Datas$increment"]["Data"] =
        dateText;

    (fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][1]["Canjica"]["Datas$increment"]["Valores"])
        .addAll([canjica, quantitiesC, finalResultCanjica]);

    increment++;
    fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][1]["Canjica"]["LengthIncrement"] =
        increment;

  }


  //Guardar valores no JSON da Canjica
  for(int i = 0; i <= 2; i++) {
    fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][1]["Canjica"][valoresSalvos[i]] =
        fieldValuesCanjica[i] +
            fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][1]["Canjica"][valoresSalvos[i]];
  }

  fileContent[jsonStart][indexYearDropDown]["Canjica"]["Result"] = finalResultCanjica + fileContent[jsonStart][indexYearDropDown]["Canjica"]["Result"];

    Map<String, dynamic> newMapRootJson = json.decode(
        file.readAsStringSync());
    newMapRootJson.addAll(fileContent);

    canjicaEdited = false;
    if(saveOnlyOneSuccessful){
      saveSuccessful();
      saveOnlyOneSuccessful = false;
    }
    return file.writeAsString(json.encode(newMapRootJson));
  }

Future saveDataSal() async{
  final file = await JsonPath().localGAnimaisFileJson;
  List<dynamic> fieldValuesSal = [sal, quantitiesS, finalResultSal];
  int increment = 0;

  increment = fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][2]["Sal"]["LengthIncrement"];
  if(fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][2]["Sal"].containsKey("Datas$increment")){

    increment++;
    fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][2]["Sal"]["LengthIncrement"] =
        increment;

    fieldContent = {"Datas$increment": {"Data": "", "Valores": []}};

    fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][2]["Sal"]
        .addAll(fieldContent);

    fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][2]["Sal"]["Datas$increment"]["Data"] =
        dateText;


    (fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][2]["Sal"]["Datas$increment"]["Valores"])
        .addAll([sal, quantitiesS, finalResultSal]);


  }else {
    fieldContent = {"Datas$increment": {"Data": "", "Valores": []}};


    fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][2]["Sal"]
        .addAll(fieldContent);

    fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][2]["Sal"]["Datas$increment"]["Data"] =
        dateText;


    (fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][2]["Sal"]["Datas$increment"]["Valores"])
        .addAll([sal, quantitiesS, finalResultSal]);


    increment++;
    fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][2]["Sal"]["LengthIncrement"] =
        increment;

  }

  //Guardar valores no JSON do Sal
  for(int i = 0; i <= 2; i++){
    fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][2]["Sal"][valoresSalvos[i]] =
        fieldValuesSal[i] +
            fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][2]["Sal"][valoresSalvos[i]];
  }

  fileContent[jsonStart][indexYearDropDown]["Sal"]["Result"] = finalResultSal + fileContent[jsonStart][indexYearDropDown]["Sal"]["Result"];

  Map<String, dynamic> newMapRootJson = json.decode(
      file.readAsStringSync());
  newMapRootJson.addAll(fileContent);

  salEdited = false;
  if(saveOnlyOneSuccessful){
    saveSuccessful();
    saveOnlyOneSuccessful = false;
  }
  return file.writeAsString(json.encode(newMapRootJson));

}

Future saveDataRacao() async{
  final file = await JsonPath().localGAnimaisFileJson;
  List<dynamic> fieldValuesRacao = [racao, quantitiesR, finalResultRacao];
  int increment = 0;

  increment = fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][3]["Ração"]["LengthIncrement"];

  if(fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][3]["Ração"].containsKey("Datas$increment")){

    increment++;
    fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][3]["Ração"]["LengthIncrement"] =
        increment;

    fieldContent = {"Datas$increment": {"Data": "", "Valores": []}};

    fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][3]["Ração"]
        .addAll(fieldContent);

    fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][3]["Ração"]["Datas$increment"]["Data"] =
        dateText;


    (fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][3]["Ração"]["Datas$increment"]["Valores"])
        .addAll([racao, quantitiesR, finalResultRacao]);


  }else {
    fieldContent = {"Datas$increment": {"Data": "", "Valores": []}};


    fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][3]["Ração"]
        .addAll(fieldContent);

    fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][3]["Ração"]["Datas$increment"]["Data"] =
        dateText;


    (fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][3]["Ração"]["Datas$increment"]["Valores"])
        .addAll([racao, quantitiesR, finalResultRacao]);


    increment++;
    fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][3]["Ração"]["LengthIncrement"] =
        increment;

  }

  //Guardar valores no JSON da Ração
  for(int i = 0; i <= 2; i++){
    fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][3]["Ração"][valoresSalvos[i]] =
        fieldValuesRacao[i] +
            fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][3]["Ração"][valoresSalvos[i]];
  }

  fileContent[jsonStart][indexYearDropDown]["Ração"]["Result"] = finalResultRacao + fileContent[jsonStart][indexYearDropDown]["Ração"]["Result"];

  Map<String, dynamic> newMapRootJson = json.decode(
      file.readAsStringSync());
  newMapRootJson.addAll(fileContent);

  racaoEdited = false;
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
              milhoController.text = "0.00";
              milhoQuantityController.text = "0";
              canjicaController.text = "0.00";
              canjicaQuantityController.text = "0";
              salController.text = "0.00";
              salQuantityController.text = "0";
              racaoController.text = "0.00";
              racaoQuantityController.text = "0";
              dateControllerTxt.text = "";
              finalResultMilho = 0;
              finalResultCanjica = 0;
              finalResultSal = 0;
              finalResultRacao = 0;
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
        saveDataMilho();
        saveOnlyOneSuccessful = true;
        if(y == fileContent[jsonStart].length - 1){
          createNewYear();
          print("Create new Year Function");
        }
      }else if(z == 1){
        saveDataCanjica();
        saveOnlyOneSuccessful = true;
        if(y == fileContent[jsonStart].length - 1){
          createNewYear();
        }
      }else if(z == 2){
        saveDataSal();
        saveOnlyOneSuccessful = true;
        if(y == fileContent[jsonStart].length - 1){
          createNewYear();
        }
      }else if(z == 3){
        saveDataRacao();
        saveOnlyOneSuccessful = true;
        if(y == fileContent[jsonStart].length - 1){
          createNewYear();
        }
      }else if(z == 4){
        saveDataMilho();
        Timer(Duration(milliseconds: 50), () {
          saveDataCanjica();
        });
        Timer(Duration(milliseconds: 100), () {
          saveDataSal();
        });
        Timer(Duration(milliseconds: 150), () {
          saveDataRacao();
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
    case SaveInfo.saveMilho:
      checkMilhoNullField(0);
      break;
    case SaveInfo.saveCanjica:
      checkCanjicaNullField(1);
      break;
    case SaveInfo.saveSal:
      checkSalNullField(2);
      break;
    case SaveInfo.saveRacao:
      checkRacaoNullField(3);
      break;
    case SaveInfo.saveAll:
      checkMilhoNullField(4);
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
          title: Text("Gastos Mensais",
            textScaleFactor: 1,
            style: TextStyle(fontSize: 5 * SizeConfig.blockSizeHorizontal),
          ),
          backgroundColor: Colors.green,
          actions: [
            PopupMenuButton<SaveInfo>(
              itemBuilder: (context) => <PopupMenuEntry<SaveInfo>>[
                const PopupMenuItem(
                  child: Text("Salvar Dados do Milho"),
                  value: SaveInfo.saveMilho,
                ),
                const PopupMenuItem(
                  child: Text("Salvar Dados da Canjica"),
                  value: SaveInfo.saveCanjica,
                ),
                const PopupMenuItem(
                  child: Text("Salvar Dados do Sal"),
                  value: SaveInfo.saveSal,
                ),
                const PopupMenuItem(
                  child: Text("Salvar Dados da Ração"),
                  value: SaveInfo.saveRacao,
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
                itemName("Milho"),
                despesasUIFunction("Preço" , "Qnt de Sacos", milhoController, milhoQuantityController, finalResultMilho, resultFunctionMilho,0,1),
                Container(
                  height: 10 * SizeConfig.blockSizeVertical,
                ),
                itemName("Canjica"),
                despesasUIFunction("Preço", "Qnt de Sacos",canjicaController, canjicaQuantityController, finalResultCanjica, resultFunctionCanjica,2,3),
                Container(
                  height: 10 * SizeConfig.blockSizeVertical,
                ),
                itemName("Sal"),
                despesasUIFunction("Preço", "Qnt de Sacos",salController, salQuantityController, finalResultSal, resultFunctionSal,4,5),
                Container(
                  height: 10 * SizeConfig.blockSizeVertical,
                ),
                itemName("Ração"),
                despesasUIFunction("Preço", "Qnt de Sacos",racaoController, racaoQuantityController, finalResultRacao, resultFunctionRacao,6,7),
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
                milhoController.text = "";
              } else if(controllerIndex == 2){
                canjicaController.text = "";
              } else if(controllerIndex == 4){
                salController.text = "";
              } else if(controllerIndex == 6){
                racaoController.text = "";
              }
            },
            onEditingComplete: () {
              if (controllerIndex == 0) {
                if (milhoController.text == "") {
                  milhoController.text = "0.00";
                  FocusScope.of(context).unfocus();
                }
              }else if(controllerIndex == 2){
                if(canjicaController.text == ""){
                  canjicaController.text = "0.00";
                  FocusScope.of(context).unfocus();
                }
              }else if(controllerIndex == 4){
                if(salController.text == ""){
                  salController.text = "0.00";
                  FocusScope.of(context).unfocus();
                }
              }else if(controllerIndex == 6){
                if(racaoController.text == ""){
                  racaoController.text = "0.00";
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
                milhoQuantityController.text = "";
              }else if(controllerQntIndex == 3){
                canjicaQuantityController.text = "";
              }else if(controllerQntIndex == 5){
                salQuantityController.text = "";
              }else if(controllerQntIndex == 7){
                racaoQuantityController.text = "";
              }
            },
            onEditingComplete: (){
              if (controllerQntIndex == 1) {
                if (milhoQuantityController.text == "") {
                  milhoQuantityController.text = "0";
                  FocusScope.of(context).unfocus();
                }
              }else if(controllerQntIndex == 3){
                if(canjicaQuantityController.text == ""){
                  canjicaQuantityController.text = "0";
                  FocusScope.of(context).unfocus();
                }
              }else if(controllerQntIndex == 5){
                if(salQuantityController.text == ""){
                  salQuantityController.text = "0";
                  FocusScope.of(context).unfocus();
                }
              }else if(controllerQntIndex == 7){
                if(racaoQuantityController.text == ""){
                  racaoQuantityController.text = "0";
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

void resultFunctionMilho(String text){
  setState(() {
    milho = double.parse(milhoController.text);
    quantitiesM = double.parse(milhoQuantityController.text);
    finalResultMilho = milho * quantitiesM;
    milhoEdited = true;
  });

}

void resultFunctionCanjica(String text){
  setState(() {
    canjica = double.parse(canjicaController.text);
    quantitiesC = double.parse(canjicaQuantityController.text);
    finalResultCanjica = canjica * quantitiesC;
    canjicaEdited = true;
  });

}

void resultFunctionSal(String text){
  setState(() {
    sal = double.parse(salController.text);
    quantitiesS = double.parse(salQuantityController.text);
    finalResultSal = sal * quantitiesS;
    salEdited = true;
  });
}

void resultFunctionRacao(String text){
  setState(() {
    racao = double.parse(racaoController.text);
    quantitiesR = double.parse(racaoQuantityController.text);
    finalResultRacao = racao * quantitiesR;
    racaoEdited = true;
  });
}

Future<bool> _requestPop(){
  if(milhoEdited == true || canjicaEdited == true || salEdited == true || racaoEdited == true){
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









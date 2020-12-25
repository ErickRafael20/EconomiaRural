import 'dart:async';
import 'dart:convert';
import 'package:despesas_galinhas/ui/Class/size_config.dart';
import 'package:flutter/services.dart';
import 'package:despesas_galinhas/ui/Class/YearClass/year_mapGAnimais.dart';
import 'package:despesas_galinhas/ui/Class/jsonPath.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:despesas_galinhas/ui/Class/loadJsons.dart';

enum SaveInfo {saveOvo,saveFrango,saveAll}

class LucroUI extends StatefulWidget {

  @override
  _LucroUIState createState() => _LucroUIState();
}


class _LucroUIState extends State<LucroUI> {

  final ovoController = TextEditingController(text: "0.00");
  final ovoQuantityController = TextEditingController(text: "0");
  final frangoController = TextEditingController(text: "0.00");
  final frangoQuantityController = TextEditingController(text: "0");
  TextEditingController dateControllerTxt = TextEditingController();

  DateTime _dateTime = DateTime.now();

  double finalResultOvo = 0;
  double finalResultFrango = 0;
  double ovo;
  double frango;
  double quantitiesO;
  double quantitiesF;


  int indexDropDown = 0;
  int indexYearDropDown = 0;

  bool frangoEdited = false;
  bool ovoEdited = false;
  bool fileExists = false ;
  bool saveAllSuccessful = false;
  bool saveOnlyOneSuccessful = false;
  Map<String, dynamic> fileContent;
  Map<String, dynamic> fieldContent;
  String jsonStart = "lucro";
  String chooseMonth = "Month";
  String chooseYear = "Year";
  String dateText;

  Future permissionL() async{
    if(await Permission.storage.request().isGranted){
      loadJsonL();
    }else{
      SystemNavigator.pop();
    }
  }


  Future loadJsonL() async{
     fileContent = await LoadJsons().loadJsonOvosFrangos;
  }



  Future createNewYear()async{
    Timer(Duration(milliseconds: 10),()
    {
      YearMapGAnimais().newYearGAnimaisFunction();
    });
  }


  Future saveDataOvos()async{
    final file = await JsonPath().localOvoFrangoFileJson;
    int increment = 0;
    List<dynamic> fieldValuesOvos = [ovo, quantitiesO,finalResultOvo];
    List<String> nameJsonString = ["Valor","Qnt","Result"];
    increment = fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][0]["Ovo"]["LengthIncrement"];
    if(fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][0]["Ovo"].containsKey("Datas$increment")){
      increment++;
      fieldContent = {"Datas$increment": {"Data": "", "Valores": []}};

      fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][0]["Ovo"]
          .addAll(fieldContent);

      fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][0]["Ovo"]["Datas$increment"]["Data"] =
          dateText;

      (fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][0]["Ovo"]["Datas$increment"]["Valores"])
          .addAll([ovo, quantitiesO,finalResultOvo]);

      fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][0]["Ovo"]["LengthIncrement"] =
          increment;
    }else {

      fieldContent = {"Datas$increment": {"Data": "", "Valores": []}};

      fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][0]["Ovo"]
          .addAll(fieldContent);

      fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][0]["Ovo"]["Datas$increment"]["Data"] =
          dateText;

      (fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][0]["Ovo"]["Datas$increment"]["Valores"])
          .addAll([ovo, quantitiesO, finalResultOvo]);

      increment++;

      fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][0]["Ovo"]["LengthIncrement"] =
          increment;
    }

    for(int i = 0; i <= 2; i++){
      fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][0]["Ovo"][nameJsonString[i]] = fieldValuesOvos[i] +
          fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][0]["Ovo"][nameJsonString[i]];
    }

    fileContent[jsonStart][indexYearDropDown]["Ovo"]["Result"] = finalResultOvo + fileContent[jsonStart][indexYearDropDown]["Ovo"]["Result"];

    Map<String, dynamic> newMapRootJson = json.decode(
        file.readAsStringSync());
    newMapRootJson.addAll(fileContent);

    ovoEdited = false;
    if(saveOnlyOneSuccessful){
      saveSuccessful();
      saveOnlyOneSuccessful = false;
    }
    return file.writeAsString(json.encode(newMapRootJson));

  }

  Future saveDataFrangos() async{
    final file2 = await JsonPath().localOvoFrangoFileJson;
    int increment = 0;
    List<dynamic> fieldValuesFrangos = [frango, quantitiesF,finalResultFrango];
    List<String> nameJsonString = ["Valor","Qnt","Result"];
    increment = fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][1]["Frango"]["LengthIncrement"];
    if(fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][1]["Frango"].containsKey("Datas$increment")){
      increment++;
      fieldContent = {"Datas$increment": {"Data": "", "Valores": []}};

      fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][1]["Frango"]
          .addAll(fieldContent);

      fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][1]["Frango"]["Datas$increment"]["Data"] =
          dateText;

      (fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][1]["Frango"]["Datas$increment"]["Valores"])
          .addAll([frango, quantitiesF,finalResultFrango]);

      fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][1]["Frango"]["LengthIncrement"] =
          increment;
    }else {

      fieldContent = {"Datas$increment": {"Data": "", "Valores": []}};

      fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][1]["Frango"]
          .addAll(fieldContent);

      fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][1]["Frango"]["Datas$increment"]["Data"] =
          dateText;

      (fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][1]["Frango"]["Datas$increment"]["Valores"])
          .addAll([frango, quantitiesF, finalResultFrango]);

      increment++;

      fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][1]["Frango"]["LengthIncrement"] =
          increment;
    }

    for(int i = 0; i <= 2; i++){
      fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][1]["Frango"][nameJsonString[i]] = fieldValuesFrangos[i] +
          fileContent[jsonStart][indexYearDropDown][chooseYear][indexDropDown][chooseMonth][1]["Frango"][nameJsonString[i]];
    }

    fileContent[jsonStart][indexYearDropDown]["Frango"]["Result"] = finalResultFrango + fileContent[jsonStart][indexYearDropDown]["Frango"]["Result"];

    Map<String, dynamic> newMapRootJson2 = json.decode(file2.readAsStringSync());
    newMapRootJson2.addAll(fileContent);

    frangoEdited = false;
    if(saveAllSuccessful){
      saveSuccessful();
      saveAllSuccessful = false;
    }else if(saveOnlyOneSuccessful){
      saveSuccessful();
      saveOnlyOneSuccessful = false;
    }

    return file2.writeAsString(json.encode(newMapRootJson2));
  }

  void checkAllNullFields(int x){
    if(ovoController.text == "0.00" && frangoController.text == "0.00" && ovoQuantityController.text == "0"
        && frangoQuantityController.text == "0"){
      inputValueInFields("o valor", "de todos os campos");
    }else{
      checkOvoNullField(2);
    }
  }


  void checkOvoNullField(int x) {
    if (double.parse(ovoController.text) >= 0.1 &&
        ovoQuantityController.text == "0") {
      inputValueInFields("as dúzias", "de Ovos");
    }else if (int.parse(ovoQuantityController.text) >= 1 &&
        ovoController.text == "0.00") {
      inputValueInFields("o preço", "dos Ovos");
    } else if (x == 0){
      alertSaveButton(0);
    } else if(x == 2){
      checkFrangoNullField(2);
    }
  }

  void checkFrangoNullField(int x){
    if(double.parse(frangoController.text) >= 0.1 && frangoQuantityController.text == "0"){
      inputValueInFields("a quantidade", "de Frangos");
    }else if(int.parse(frangoQuantityController.text) >= 1 && frangoController.text == "0.00"){
      inputValueInFields("o preço", "dos Frangos");
    }else if(x == 1){
     alertSaveButton(1);
    }else if(x == 2){
      alertSaveButton(2);
    }
  }


  void inputValueInFields(String nameField, String priceQnt){
    showDialog(context: context, builder: (context){
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
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text("Salvo com sucesso",textScaleFactor: 1),
        content: Text("O item foi salvo com sucesso. Deseja salvar outro item?",textScaleFactor: 1),
        actions: <Widget>[
          FlatButton(
            child: Text("Sim",textScaleFactor: 1),
            onPressed: (){
              setState(() {
                ovoController.text = "0.00";
                ovoQuantityController.text = "0";
                frangoController.text = "0.00";
                frangoQuantityController.text = "0";
                dateControllerTxt.text = "";
                finalResultOvo = 0;
                finalResultFrango = 0;
              });

              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
          FlatButton(
            child: Text("Não",textScaleFactor: 1,
            ),
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
        saveDataOvos();
        saveOnlyOneSuccessful = true;
          if(y == fileContent[jsonStart].length - 1){
            createNewYear();
        }
        }else if(z == 1){
          saveDataFrangos();
          saveOnlyOneSuccessful = true;
          if(y == fileContent[jsonStart].length - 1){
            createNewYear();
          }
        }else if(z == 2){
          saveDataOvos();
          Timer(Duration(milliseconds: 50), () {
            saveDataFrangos();
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

  void monthIndex(int y){
    int z = 1;
    int u = 0;
    for (int i = 0; i <= 11; i++){
      if (_dateTime.month == z){
        indexDropDown = u;
        i = 12;
        yearIndex(y);
      }else{
        z++;
        u++;
      }
    }

  }


  void alertSaveButton(int y) {
    DateTime _dateTime = DateTime.now();
    bool dateNull = false;
    int date;
    int dateLength;
    dateLength = fileContent[jsonStart].length;
    dateLength--;
    date = int.parse(fileContent[jsonStart][dateLength]["Ano"]);
    date++;
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
                          monthIndex(y);
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
    permissionL();

  }

  void saveAllPopUp(SaveInfo save){
    switch(save){
      case SaveInfo.saveOvo:
        checkOvoNullField(0);
        break;
      case SaveInfo.saveFrango:
        checkFrangoNullField(1);
        break;
      case SaveInfo.saveAll:
        checkAllNullFields(2);
        break;
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
            title: Text("Ovos e Frangos",
              textScaleFactor: 1,
              style: TextStyle(
                  fontSize: 5 * SizeConfig.blockSizeHorizontal),
            ),
            backgroundColor: Colors.green,
            actions: [
              PopupMenuButton<SaveInfo>(
                itemBuilder: (context) => <PopupMenuEntry<SaveInfo>>[
                  const PopupMenuItem(
                    child: Text("Salvar Dado dos Ovos"),
                    value: SaveInfo.saveOvo,
                  ),
                  const PopupMenuItem(
                    child: Text("Salvar Dado dos Frangos"),
                    value: SaveInfo.saveFrango,
                  ),
                  const PopupMenuItem(
                    child: Text("Salvar Tudo"),
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
                    height:  17 * SizeConfig.blockSizeVertical,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 2.5 * SizeConfig.blockSizeHorizontal, bottom: SizeConfig.blockSizeHorizontal),
                        child: Text("Ovos",
                          textScaleFactor: 1,
                          style: TextStyle(
                          fontSize: 8 * SizeConfig.blockSizeHorizontal,
                        ),),
                      )
                    ],
                  ),
                  despesasUIFunction("Preço" , "Dúzias", ovoController, ovoQuantityController, finalResultOvo, resultFunctionOvo, 0,1),
                  Container(
                    height:  10 * SizeConfig.blockSizeVertical,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 2.5 * SizeConfig.blockSizeHorizontal, bottom: SizeConfig.blockSizeHorizontal),
                        child: Text("Frangos",
                          textScaleFactor: 1,
                          style: TextStyle(
                          fontSize:  8 * SizeConfig.blockSizeHorizontal,
                        ),),
                      )
                    ],
                  ),
                  despesasUIFunction("Preço", "Quantidades", frangoController, frangoQuantityController, finalResultFrango, resultFunctionFrango,2,3),
                ],
              )
          ),
        )
    );
  }

  Widget despesasUIFunction(String labelTxt1, String labelTxt2,
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
            width: 25 * SizeConfig.blockSizeHorizontal,
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
                  ovoController.text = "";
                } else if(controllerIndex == 2){
                  frangoController.text = "";
                }
              },
              onEditingComplete: () {
                if (controllerIndex == 0) {
                  if (ovoController.text == "") {
                    ovoController.text = "0.00";
                    FocusScope.of(context).unfocus();
                  }
                }else if(controllerIndex == 2){
                  if(frangoController.text == ""){
                    frangoController.text = "0.00";
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
                  ovoQuantityController.text = "";
                }else if(controllerQntIndex == 3){
                  frangoQuantityController.text = "";
                }
              },
              onEditingComplete: (){
                if (controllerQntIndex == 1) {
                  if (ovoQuantityController.text == "") {
                    ovoQuantityController.text = "0";
                    FocusScope.of(context).unfocus();
                  }
                }else if(controllerQntIndex == 3){
                  if(frangoQuantityController.text == ""){
                    frangoQuantityController.text = "0";
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

  void resultFunctionOvo(String text){
    setState(() {
      ovo = double.parse(ovoController.text);
      quantitiesO = double.parse(ovoQuantityController.text);
      finalResultOvo = ovo * quantitiesO;
      ovoEdited = true;
    });


  }

  void resultFunctionFrango(String text){
    setState(() {
      frango = double.parse(frangoController.text);
      quantitiesF = double.parse(frangoQuantityController.text);
      finalResultFrango = frango * quantitiesF;
      frangoEdited = true;
    });

  }


  Future<bool> _requestPop(){
    if(ovoEdited == true || frangoEdited == true){
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
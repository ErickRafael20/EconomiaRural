import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:despesas_galinhas/ui/BalancoFinanceiro/balancoFinanceiro_Options.dart';
import 'package:despesas_galinhas/ui/Class/reset_Data.dart';
import 'package:despesas_galinhas/ui/Class/size_config.dart';
import 'package:despesas_galinhas/ui/gastosChartOptions.dart';
import 'package:despesas_galinhas/ui/gastos_options.dart';
import 'package:despesas_galinhas/ui/vendasChartOptions.dart';
import 'package:despesas_galinhas/ui/vendas_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Class/jsonPath.dart';

enum ResetOptions {resetDesp,resetLucro,resetAll,editarSalario}

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  bool fileExists = false;
  bool checkBool = false;
  bool checkPermission = false;

  double salario;

  DateTime _dateTime = DateTime.now();

  final salarioController = TextEditingController();
  Map<String, dynamic> salarioContent;
  int indexDropDown = 0;
  int indexYearDropDown = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.brown,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Controle Financeiro",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 2.5 * SizeConfig.blockSizeVertical),textScaleFactor: 1,),
        actions: [
        PopupMenuButton<ResetOptions>(
          itemBuilder: (context) => <PopupMenuEntry<ResetOptions>>[
            const PopupMenuItem(
                child: Text("Limpar dados dos Gastos") ,
                value: ResetOptions.resetDesp ,
            ),
            const PopupMenuItem(
              child: Text("Limpar dados das Vendas") ,
              value: ResetOptions.resetLucro ,
            ),
            const PopupMenuItem(
              child: Text("Limpar dados dos Gastos e das Vendas") ,
              value: ResetOptions.resetAll ,
            ),
            const PopupMenuItem(
                child: Text("Editar Salário"),
              value: ResetOptions.editarSalario,
            )
          ],
          onSelected: _resetList,
        )
        ],
        backgroundColor: Colors.green,

      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 5 * SizeConfig.blockSizeVertical,
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => GastoOptions()));
                      },
                      child: Text("Gastos Mensais",
                        textScaleFactor: 1,
                        style: TextStyle(color: Colors.white70, fontSize: 2.5 * SizeConfig.blockSizeVertical),
                      ),
                    ),
                  ),
              ],
            ),
            Container(
              height: 5 * SizeConfig.blockSizeVertical,
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => GastoChartOptions()));
                      },
                      child: Text("Relatório de Gastos",
                        textScaleFactor: 1,
                        style: TextStyle(color: Colors.white70, fontSize: 2.5 * SizeConfig.blockSizeVertical),
                      ),
                    ),
                  ),
              ],
            ),
            Container(
              height: 5 * SizeConfig.blockSizeVertical,
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => VendasOptions()));
                      },
                      child: Text("Vendas Mensais",
                        textScaleFactor: 1,
                        style: TextStyle(color: Colors.white70, fontSize: 2.5 * SizeConfig.blockSizeVertical),
                      ),
                    ),
                  ),
              ],
            ),
            Container(
              height: 5 * SizeConfig.blockSizeVertical,
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => VendasChartOptions()));
                      },
                      child: Text("Relatório de Vendas",
                        textScaleFactor: 1,
                        style: TextStyle(color: Colors.white70, fontSize: 2.5 * SizeConfig.blockSizeVertical),
                      ),
                    ),
                  ),
              ],
            ),
            Container(
              height: 5 * SizeConfig.blockSizeVertical,
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => BFOptions()));
                        },
                        child: Text("Balanço Financeiro",
                        textScaleFactor: 1,
                        style: TextStyle(color: Colors.white70, fontSize: 2.5 * SizeConfig.blockSizeVertical),
                        ),
                      ),
                    ),
                ],
            ),
            Container(
              height: 5 * SizeConfig.blockSizeVertical
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
                      exitConfirmation();
                    },
                    child: Text("Sair",
                      textScaleFactor: 1,
                      style: TextStyle(color: Colors.white70, fontSize: 2.5 * SizeConfig.blockSizeVertical),
                    ),
                  ),
                ),

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 3 * SizeConfig.blockSizeHorizontal),
                  child: Text("   Feito por \n Erick Rafael",
                      textScaleFactor: 1 ,
                      style: TextStyle(
                          color: Colors.white70
                      ),
                    ),
                ),
              ],
            )
          ],
        ),
      )
    );
  }

  @override
  void initState() {
    super.initState();
   checkPermissionFunction();
  }

  Future checkPermissionFunction() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    checkPermission = pref.getBool("Permission");
    if(checkPermission == null) {
      grantPermission();
    }else{
      createJson();
    }
  }

  Future permission() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    if(await Permission.storage.request().isGranted){
      checkPermission = true;
      pref.setBool("Permission", checkPermission);
      createJson();
    }else{
      SystemNavigator.pop();
    }
  }

  Future grantPermission() async{
    showDialog(context: context, barrierDismissible: false ,builder: (context){
      return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Text("Permitir acesso ao Armazenamento",textScaleFactor: 1),
          content: Text("Para usar esse aplicativo é necessário permitir o uso do armazenamento",textScaleFactor: 1),
          actions: <Widget>[
            FlatButton(
              child: Text("Sim",textScaleFactor: 1),
              onPressed: (){
                permission();
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text("Não", textScaleFactor: 1,),
              onPressed: (){
                SystemNavigator.pop();
              },
            )
          ],
        ),
      );
    }
    );
  }

  void _resetList (ResetOptions result){
      switch(result){
        case ResetOptions.resetDesp:
          resetButton("de todos os Gastos: Alimentação Animal, Gastos Gerais e Outros", 0);
          break;
        case ResetOptions.resetLucro:
          resetButton("de todas as Vendas: Ovos e Frango, Gado e Outros", 1);
          break;
        case ResetOptions.resetAll:
          resetButton("dos Gastos e das Vendas", 2);
          break;
        case ResetOptions.editarSalario:
          salarioButton();
      }
  }

  void exitConfirmation(){
      showDialog(context: context, barrierDismissible: false ,builder: (context){
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: Text("Você quer sair?",textScaleFactor: 1),
            content: Text("Você realmente deseja sair?",textScaleFactor: 1),
            actions: <Widget>[
              FlatButton(
                child: Text("Sim",textScaleFactor: 1),
                onPressed: (){
                  SystemNavigator.pop();
                },
              ),
              FlatButton(
                child: Text("Não", textScaleFactor: 1,),
                onPressed: (){
                  Navigator.pop(context);
                },
              )
            ],
          ),
        );
      }
      );

  }


  void checkYear() {
    int x = 2020;
    int y = 0;
    for(int i = 0; i <= salarioContent["salario"].length; i++){
      if(_dateTime.year == x){
        indexYearDropDown = y;
        i = salarioContent["salario"].length + 1;
        checkMonth();
      }else{
        x++;
        y++;
      }
    }
  }

  void checkMonth(){
    int x = 1;
    int y = 0;
    for (int i = 0; i <= 11; i++){
      if(_dateTime.month == x){
        indexDropDown = y;
        i = 12;
        salario = salarioContent["salario"][indexYearDropDown]["Year"][indexDropDown]["Month"]["Salário"];
        checkBool = salarioContent["salario"][indexYearDropDown]["Year"][indexDropDown]["Month"]["SemSalário"];
        checkSalarioMonth();
      }else{
        x++;
        y++;
      }
    }
  }


  void checkSalarioMonth(){
    if(salarioContent["salario"][indexYearDropDown]["Year"][indexDropDown]["Month"]["SemSalário"] == false){
      print(salario);
      if(salario >= 1){

      }else{
        checkSalario("Insira o salário do Mês", "Insira o salario para ser utilizado nesse mês");
      }
    }
  }
  Future loadSalario() async{
      final file = await JsonPath().localFileSalarioJson;
      if(await file.exists()){
      print("FileExists");
      salarioContent = json.decode(await file.readAsString());
      Timer(Duration(milliseconds: 20),(){
      checkYear();
      });

      }else{
        print("File Sal Doesn't exist");
      }

  }

  Future checkSalario(String title, content) async{
    Map<String, dynamic> newMap;
    bool textEnabled;

    if(checkBool == false){
      textEnabled = true;
    }else{
      textEnabled = false;
    }

    final file = await JsonPath().localFileSalarioJson;
    newMap = json.decode(file.readAsStringSync());

    salarioController.text = salarioContent["salario"][indexYearDropDown]["Year"][indexDropDown]["Month"]["Salário"].toString();

      Timer(Duration(milliseconds: 10), () {
        showDialog(context: context,barrierDismissible: false, builder: (context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              title: Text("$title"),
              content: Text(
                  "$content. Caso não tenha assinale o campo. Isso pode ser alterado mais tarde"),
              actions: <Widget>[
                Padding(
                      padding: EdgeInsets.only(
                          right: 20 * SizeConfig.blockSizeHorizontal),
                      child: Container(
                        width: 35 * SizeConfig.blockSizeHorizontal,
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: "0.00",
                            prefixText: "R\$",
                            border: OutlineInputBorder(),
                          ),

                          enabled: textEnabled,
                          controller: salarioController,
                        ),
                      ),
                    ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Não tenho Salário"),
                    StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState){
                        return Checkbox(
                                value: checkBool,
                                onChanged: (bool value){
                                    setState(() {
                                      checkBool = value;
                                      if(checkBool == false){
                                        textEnabled = true;
                                      }else{
                                        textEnabled = false;
                                      }
                                      Navigator.pop(context);
                                      checkSalario("Insira o salário do Mês", "Insira o salario para ser utilizado nesse mês");
                                    });
                                  },
                        );
                      },

                    ),
                  ],
                ),
                FlatButton(
                  child: Text("Ok"),
                  onPressed: () {
                    if(salarioController.text == "0.0" && checkBool == false){
                      resetSuccessful("Erro!", "Insira um valor do salário ou marque a caixa",true);
                    }else {
                      salarioContent["salario"][indexYearDropDown]["Year"][indexDropDown]["Month"]["Salário"] =
                          double.parse(salarioController.text);
                      salarioContent["salario"][indexYearDropDown]["Year"][indexDropDown]["Month"]["SemSalário"] =
                          checkBool;
                      newMap.addAll(salarioContent);
                      file.writeAsStringSync(json.encode(newMap));
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          );
        }
        );
      });
  }

  Future salarioButton() async{
    Map<String, dynamic> newMap;
    bool textEnabled;

    if(checkBool == false){
      textEnabled = true;
    }else{
      textEnabled = false;
    }

    final file = await JsonPath().localFileSalarioJson;
    newMap = json.decode(file.readAsStringSync());

    salarioController.text = salarioContent["salario"][indexYearDropDown]["Year"][indexDropDown]["Month"]["Salário"].toString();
    showDialog(context: context,barrierDismissible: false, builder: (context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Text("Editar Salário"),
          content: Text(
              "Insira um novo salário para o mês atual. Caso não tenha um, assinale o campo."),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  right: 20 * SizeConfig.blockSizeHorizontal),
              child: Container(
                width: 35 * SizeConfig.blockSizeHorizontal,
                child: TextField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: "0.00",
                    prefixText: "R\$",
                    border: OutlineInputBorder(),
                  ),

                  enabled: textEnabled,
                  controller: salarioController,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Não tenho Salário"),
                StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState){
                    return Checkbox(
                      value: checkBool,
                      onChanged: (bool value){
                        setState(() {
                          checkBool = value;
                          if(checkBool == false){
                            textEnabled = true;
                          }else{
                            textEnabled = false;
                          }
                          Navigator.pop(context);
                          salarioButton();
                        });
                      },
                    );
                  },

                ),
              ],
            ),
            Row(
              children: [
                FlatButton(
                  child: Text("Sim, editar"),
                  onPressed: () {
                    if(salarioController.text == "0.0" && checkBool == false){
                      resetSuccessful("Erro!", "Insira um valor do salário ou marque a caixa",true);
                    }else{
                      salarioContent["salario"][indexYearDropDown]["Year"][indexDropDown]["Month"]["Salário"] = double.parse(salarioController.text);
                      salarioContent["salario"][indexYearDropDown]["Year"][indexDropDown]["Month"]["SemSalário"] = checkBool;
                      if(checkBool == true){
                        print("True");
                        salarioContent["salario"][indexYearDropDown]["Year"][indexDropDown]["Month"]["Salário"] = 0.00;
                      }
                      newMap.addAll(salarioContent);
                      file.writeAsStringSync(json.encode(newMap));
                      resetSuccessful("Salário Editado", "Salário Editado com sucesso!",false);
                    }

                  },
                ),
                Container(
                  width: 8 * SizeConfig.blockSizeVertical,
                ),
                FlatButton(
                  child: Text("Não, cancelar"),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                )
              ],
            ),

          ],
        ),
      );
    }
    );
  }

  void resetButton(String dialog, int index) {

    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text("Resetar Dados"),
        content: Text("Isso irá deletar todos os dados $dialog."
            "Você tem certeza disso?"),
        actions: <Widget>[
          FlatButton(
            child: Text("Sim, resetar"),
            onPressed: (){
              if(index == 0) {
                resetDesp();
              }if(index == 1){
                resetLucro();
              }if(index == 2){
                resetAllData();
              }

            },
          ),
          FlatButton(
            child: Text("Não, cancelar"),
            onPressed: (){
              Navigator.pop(context);
            },
          )
        ],
      );
    }
    );
  }


  void resetSuccessful(String title, content, bool error) {
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          FlatButton(
            child: Text("OK"),
            onPressed: (){
              if(error == true){
                Navigator.pop(context);
              }else{
                Navigator.pop(context);
                Navigator.pop(context);
              }

            },
          ),
        ],
      );
    }
    );
  }

  Future resetAllData() async{
    await ResetDataJson().resetAllDataGastosVendas();
    resetSuccessful("Dados Resetados", "Os dados foram resetados com sucesso!",false);
    Timer(Duration(milliseconds: 100),(){
      loadSalario();
    });
  }

  Future resetDesp() async{
    await ResetDataJson().resetAllDataGastos();
    resetSuccessful("Dados Resetados", "Os dados foram resetados com sucesso!",false);
  }

  Future resetLucro() async{
    await ResetDataJson().resetAllDataVendas();
    resetSuccessful("Dados Resetados", "Os dados foram resetados com sucesso!",false);
    Timer(Duration(milliseconds: 100),(){
      loadSalario();
    });
  }


  Future createJson() async{
    final filePath = await JsonPath().localGAnimaisFileJson;
    fileExists = await filePath.exists();
    if(fileExists){
      loadSalario();
    }else {
      print("File Doesn't Exists");
      await ResetDataJson().createDataGastos();
      await ResetDataJson().createDataVendas();
      Timer(Duration(milliseconds: 100),(){
        loadSalario();
      });
    }
  }


}


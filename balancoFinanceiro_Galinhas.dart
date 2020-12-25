import 'package:despesas_galinhas/ui/Class/loadJsons.dart';
import 'package:despesas_galinhas/ui/Class/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class BFGalinhas extends StatefulWidget {
  final int indexYearDropDown;
  const BFGalinhas(this.indexYearDropDown);

  @override
  _BFGalinhasState createState() => _BFGalinhasState();
}

class _BFGalinhasState extends State<BFGalinhas> {



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

  Map<String,dynamic> fileContentGAnimais;
  Map<String,dynamic> fileContentOvosFrangos;

  double finalResultMilho = 0;
  double finalResultCanjica = 0;
  double finalResultGastos = 0;
  double finalResultOvos = 0;
  double finalResultFrangos = 0;
  double finalResultVendas = 0;
  double finalResultAll = 0;

  bool fileExists = false;

  int indexDropDown = 0;
  List<int> checkRsltEntrada = [3,3,3,3,3,3,3,3,3];
  List<int> checkRsltSaida = [3,3,3,3,3,3,3,3,3];
  int checkAllRslt = 3;

  String chooseMonth = "Month";
  String chooseYear = "Year";
  String balanco = "";


  Future loadJson() async{
    fileContentGAnimais = await LoadJsons().loadJsonGAnimais;
    fileContentOvosFrangos = await LoadJsons().loadJsonOvosFrangos;


    print(fileContentGAnimais["despesas"][widget.indexYearDropDown][chooseYear][10][chooseMonth][3]["Ração"]);
    print(fileContentGAnimais);
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadJson();
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.brown,
      appBar: AppBar(
        title: Text("Balanço Financeiro Galinhas",
          textScaleFactor: 1,
          style: TextStyle(fontSize: 5 * SizeConfig.blockSizeHorizontal),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),

      body: SingleChildScrollView(
        child: Column(
            children:[
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

                              });

                              finalResultMilho = fileContentGAnimais["despesas"][widget.indexYearDropDown][chooseYear][indexDropDown][chooseMonth][0]["Milho"]["Result"];
                              finalResultCanjica = fileContentGAnimais["despesas"][widget.indexYearDropDown][chooseYear][indexDropDown][chooseMonth][1]["Canjica"]["Result"];


                              finalResultGastos = finalResultMilho + finalResultCanjica;

                              finalResultOvos = fileContentOvosFrangos["lucro"][widget.indexYearDropDown][chooseYear][indexDropDown][chooseMonth][0]["Ovo"]["Result"];
                              finalResultFrangos = fileContentOvosFrangos["lucro"][widget.indexYearDropDown][chooseYear][indexDropDown][chooseMonth][1]["Frango"]["Result"];

                              finalResultVendas = finalResultOvos + finalResultFrangos;

                              finalResultAll = finalResultVendas - finalResultGastos;

                              checkResultEntrada();
                              checkResultSaida();

                              if(finalResultAll >= 0 && finalResultAll <= 9 || finalResultAll >= -9 && finalResultAll <= -1){
                                checkAllRslt = 3;
                              }else if(finalResultAll >= 10 && finalResultAll <= 99 || finalResultAll >= -99 && finalResultAll <= -10){
                                checkAllRslt = 4;
                              }else if(finalResultAll >= 100 && finalResultAll <= 999 || finalResultAll >= -999 && finalResultAll <= -100){
                                checkAllRslt = 5;
                              }else if(finalResultAll >= 1000 && finalResultAll <= 9999 || finalResultAll >= -9999 && finalResultAll <= -1000){
                                print(finalResultAll);
                                checkAllRslt = 6;
                              }else if(finalResultAll >= 10000 && finalResultAll <= 99999 || finalResultAll >= -99999 && finalResultAll <= -10000){
                                checkAllRslt = 7;
                              }

                              if(finalResultAll >= 0){
                                balanco = "Positivo!";
                              }else{
                                balanco = "Negativo!";
                              }

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
              Container(
                height: 2.5 * SizeConfig.blockSizeHorizontal,
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 12 * SizeConfig.blockSizeHorizontal),
                    child: Text("Entrada", style: TextStyle(
                        fontSize: 7 * SizeConfig.blockSizeHorizontal
                    ),),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30 * SizeConfig.blockSizeHorizontal),
                    child: Text("Saída", style: TextStyle(
                        fontSize: 7 * SizeConfig.blockSizeHorizontal
                    ),),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 2.5 * SizeConfig.blockSizeHorizontal),
                    child: Container(
                      alignment: Alignment.topLeft,
                      height: 15 * SizeConfig.blockSizeVertical,
                      width: 45 * SizeConfig.blockSizeHorizontal,
                      decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                              side: BorderSide(width: 2.0, style: BorderStyle.solid),
                              borderRadius: BorderRadius.all(Radius.circular(7.0))
                          )
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Ovos: R\$${finalResultOvos.toStringAsPrecision(checkRsltEntrada[1])}", style: TextStyle(
                                fontSize: 5 * SizeConfig.blockSizeHorizontal
                            ),),
                            Divider(
                              color: Colors.black,
                              thickness: 1 * SizeConfig.blockSizeHorizontal,
                            ),

                            Text("Frangos: R\$${finalResultFrangos.toStringAsPrecision(checkRsltEntrada[2])}", style: TextStyle(
                                fontSize: 5 * SizeConfig.blockSizeHorizontal
                            ),),
                            Divider(
                              color: Colors.black,
                              thickness: 1 * SizeConfig.blockSizeHorizontal,
                            ),
                            Text("Total: R\$${finalResultVendas.toStringAsPrecision(checkRsltEntrada[8])}", style: TextStyle(
                                fontSize: 5 * SizeConfig.blockSizeHorizontal
                            ),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 5 * SizeConfig.blockSizeHorizontal,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    height: 15 * SizeConfig.blockSizeVertical,
                    width: 45 * SizeConfig.blockSizeHorizontal,
                    decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(width: 2.0, style: BorderStyle.solid),
                            borderRadius: BorderRadius.all(Radius.circular(7.0))
                        )
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Milho: R\$${finalResultMilho.toStringAsPrecision(checkRsltSaida[0])}", style: TextStyle(
                              fontSize: 5 * SizeConfig.blockSizeHorizontal
                          ),),
                          Divider(
                            color: Colors.black,
                            thickness: 1 * SizeConfig.blockSizeHorizontal,
                          ),
                          Text("Canjica: R\$${finalResultCanjica.toStringAsPrecision(checkRsltSaida[1])}", style: TextStyle(
                              fontSize: 5 * SizeConfig.blockSizeHorizontal
                          ),),
                          Divider(
                            color: Colors.black,
                            thickness: 1 * SizeConfig.blockSizeHorizontal,
                          ),
                          Text("Total: R\$${finalResultGastos.toStringAsPrecision(checkRsltSaida[8])}", style: TextStyle(
                              fontSize: 5 * SizeConfig.blockSizeHorizontal
                          ),),
                        ],
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
                  Text("Total Geral",
                    style: TextStyle(fontSize: 7 * SizeConfig.blockSizeHorizontal),)
                ],
              ),
              Container(
                height: 1 * SizeConfig.blockSizeVertical,
              ),
              Container(
                alignment: Alignment.center,
                height: 7 * SizeConfig.blockSizeVertical,
                width: 45 * SizeConfig.blockSizeHorizontal,
                decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(width: 2.0, style: BorderStyle.solid),
                        borderRadius: BorderRadius.all(Radius.circular(7.0))
                    )
                ),
                child: Text("R\$${finalResultAll.toStringAsPrecision(checkAllRslt)}",
                  style: TextStyle(fontSize: 7 * SizeConfig.blockSizeHorizontal),
                ),
              ),
              Container(
                height: 1 * SizeConfig.blockSizeVertical,
              ),
              Text("$balanco",
                style: TextStyle(fontSize: 7 * SizeConfig.blockSizeHorizontal),
              ),
            ]
        ),
      ),
    );
  }


  void checkResultSaida(){
    if(finalResultMilho >= 0 && finalResultMilho <= 9){
      checkRsltSaida[0] = 3;
    }else if(finalResultMilho >= 10 && finalResultMilho <= 99){
      checkRsltSaida[0] = 4;
    }else if(finalResultMilho >= 100 && finalResultMilho <= 999){
      checkRsltSaida[0] = 5;
    }else if(finalResultMilho >= 1000 && finalResultMilho <= 9999){
      checkRsltSaida[0] = 6;
    }else if(finalResultMilho >= 10000 && finalResultMilho <= 99999){
      checkRsltSaida[0] = 7;
    }

    if(finalResultCanjica >= 0 && finalResultCanjica <= 9){
      checkRsltSaida[1] = 3;
    }else if(finalResultCanjica >= 10 && finalResultCanjica <= 99){
      checkRsltSaida[1] = 4;
    }else if(finalResultCanjica >= 100 && finalResultCanjica <= 999){
      checkRsltSaida[1] = 5;
    }else if(finalResultCanjica >= 1000 && finalResultCanjica <= 9999){
      checkRsltSaida[1] = 6;
    }else if(finalResultCanjica >= 10000 && finalResultCanjica <= 99999){
      checkRsltSaida[1] = 7;
    }

    if(finalResultGastos >= 0 && finalResultGastos <= 9){
      checkRsltSaida[8] = 3;
    }else if(finalResultGastos >= 10 && finalResultGastos <= 99){
      checkRsltSaida[8] = 4;
    }else if(finalResultGastos >= 100 && finalResultGastos <= 999){
      checkRsltSaida[8] = 5;
    }else if(finalResultGastos >= 1000 && finalResultGastos <= 9999){
      checkRsltSaida[8] = 6;
    }else if(finalResultGastos >= 10000 && finalResultGastos <= 99999){
      checkRsltSaida[8] = 7;
    }

  }

  void checkResultEntrada(){
    if(finalResultOvos >= 0 && finalResultOvos <= 9){
      checkRsltEntrada[1] = 3;
    }else if(finalResultOvos >= 10 && finalResultOvos <= 99){
      checkRsltEntrada[1] = 4;
    }else if(finalResultOvos >= 100 && finalResultOvos <= 999){
      checkRsltEntrada[1] = 5;
    }else if(finalResultOvos >= 1000 && finalResultOvos <= 9999){
      checkRsltEntrada[1] = 6;
    }else if(finalResultOvos >= 10000 && finalResultOvos <= 99999){
      checkRsltEntrada[1] = 7;
    }

    if(finalResultFrangos >= 0 && finalResultFrangos <= 9){
      checkRsltEntrada[2] = 3;
    }else if(finalResultFrangos >= 10 && finalResultFrangos <= 99){
      checkRsltEntrada[2] = 4;
    }else if(finalResultFrangos >= 100 && finalResultFrangos <= 999){
      checkRsltEntrada[2] = 5;
    }else if(finalResultFrangos >= 1000 && finalResultFrangos <= 9999){
      checkRsltEntrada[2] = 6;
    }else if(finalResultFrangos >= 10000 && finalResultFrangos <= 99999){
      checkRsltEntrada[2] = 7;
    }

    if(finalResultVendas >= 0 && finalResultVendas <= 9){
      checkRsltEntrada[8] = 3;
    }else if(finalResultVendas >= 10 && finalResultVendas <= 99){
      checkRsltEntrada[8] = 4;
    }else if(finalResultVendas >= 100 && finalResultVendas <= 999){
      checkRsltEntrada[8] = 5;
    }else if(finalResultVendas >= 1000 && finalResultVendas <= 9999){
      checkRsltEntrada[8] = 6;
    }else if(finalResultVendas >= 10000 && finalResultVendas <= 99999){
      checkRsltEntrada[8] = 7;
    }

  }
}

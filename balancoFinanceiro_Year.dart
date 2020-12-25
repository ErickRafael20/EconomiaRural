import 'package:despesas_galinhas/ui/Class/loadJsons.dart';
import 'package:despesas_galinhas/ui/Class/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class BFYear extends StatefulWidget {

  @override
  _BFYearState createState() => _BFYearState();
}

class _BFYearState extends State<BFYear> {



  var _currentItemSelected = "----------";
  List<String> _yearList = ["----------"];

  Map<String,dynamic> fileContentGAnimais;
  Map<String,dynamic> fileContentFarmacia;
  Map<String,dynamic> fileContentGasolina;
  Map<String,dynamic> fileContentMercado;
  Map<String,dynamic> fileContentOutrosGastos;
  Map<String,dynamic> fileContentOvosFrangos;
  Map<String,dynamic> fileContentGado;
  Map<String,dynamic> fileContentOutrasVendas;
  Map<String,dynamic> fileContentSalario;

  double finalResultMilho = 0;
  double finalResultCanjica = 0;
  double finalResultSal = 0;
  double finalResultRacao = 0;
  double finalResultFarmacia = 0;
  double finalResultGasolina = 0;
  double finalResultMercado = 0;
  double finalResultOutrosGastos = 0;
  double finalResultGastos = 0;
  double finalResultOvos = 0;
  double finalResultFrangos = 0;
  double finalResultGado = 0;
  double finalResultLeite = 0;
  double finalResultQueijo = 0;
  double finalResultRequeijao = 0;
  double finalResultOutrasVendas = 0;
  double finalResultVendas = 0;
  double finalResultAll = 0;
  double salario = 0;

  bool fileExists = false;

  List<int> checkRsltEntrada = [3,3,3,3,3,3,3,3,3];
  List<int> checkRsltSaida = [3,3,3,3,3,3,3,3,3];
  int checkAllRslt = 3;
  int indexYearDropDown = 0;

  String chooseMonth = "Month";
  String chooseYear = "Year";
  String balanco = "";


  Future loadJson() async{

    fileContentGAnimais = await LoadJsons().loadJsonGAnimais;
    fileContentFarmacia = await LoadJsons().loadJsonFarmacia;
    fileContentGasolina = await LoadJsons().loadJsonGasolina;
    fileContentMercado = await LoadJsons().loadJsonMercado;
    fileContentOutrosGastos = await LoadJsons().loadJsonOutrosGastos;
    fileContentOvosFrangos = await LoadJsons().loadJsonOvosFrangos;
    fileContentGado = await LoadJsons().loadJsonGado;
    fileContentOutrasVendas = await LoadJsons().loadJsonOutrasVendas;
    fileContentSalario = await LoadJsons().loadJsonSalario;
    loadDropDownYear();

  }

  void loadDropDownYear(){
    int x = 0;

    setState(() {
      for(int i = 1; i <= fileContentSalario["salario"].length ;i++ ){
        _yearList.add(fileContentSalario["salario"][x]["Ano"]);
        print("Ano: ${fileContentSalario["salario"][x]["Ano"]}");
        x++;
        print("i = $i");
      }
    });
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
        title: Text("Balanço Financeiro Anual",
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
                      "Escolha o Ano",
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
                            items: _yearList.map((String dropDownStringItem) {
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
                                indexYearDropDown = _yearList.indexOf(value);
                                indexYearDropDown = indexYearDropDown - 1;

                                if(indexYearDropDown == -1){
                                  indexYearDropDown = 0;
                                  this._currentItemSelected = "2020";
                                }

                              });

                              finalResultMilho = fileContentGAnimais["despesas"][indexYearDropDown]["Milho"]["Result"];
                              finalResultCanjica = fileContentGAnimais["despesas"][indexYearDropDown]["Canjica"]["Result"];
                              finalResultSal = fileContentGAnimais["despesas"][indexYearDropDown]["Sal"]["Result"];
                              finalResultRacao = fileContentGAnimais["despesas"][indexYearDropDown]["Ração"]["Result"];

                              finalResultFarmacia = fileContentFarmacia["farmacia"][indexYearDropDown]["Result"];
                              finalResultGasolina = fileContentGasolina["gasolina"][indexYearDropDown]["Result"];
                              finalResultMercado = fileContentMercado["mercado"][indexYearDropDown]["Result"];

                              finalResultOutrosGastos = fileContentOutrosGastos["outros"][indexYearDropDown]["Result"];

                              finalResultGastos = finalResultMilho + finalResultCanjica + finalResultSal + finalResultRacao +finalResultFarmacia + finalResultGasolina + finalResultMercado + finalResultOutrosGastos;

                              finalResultOvos = fileContentOvosFrangos["lucro"][indexYearDropDown]["Ovo"]["Result"];
                              finalResultFrangos = fileContentOvosFrangos["lucro"][indexYearDropDown]["Frango"]["Result"];

                              finalResultGado = fileContentGado["gado"][indexYearDropDown]["Gado"]["Result"];
                              finalResultLeite = fileContentGado["gado"][indexYearDropDown]["Leite"]["Result"];
                              finalResultQueijo = fileContentGado["gado"][indexYearDropDown]["Queijo"]["Result"];
                              finalResultRequeijao = fileContentGado["gado"][indexYearDropDown]["Requeijao"]["Result"];

                              finalResultOutrasVendas = fileContentOutrasVendas["outros"][indexYearDropDown]["Result"];

                              for(int i = 0; i <= 11; i++){
                                salario = fileContentSalario["salario"][indexYearDropDown][chooseYear][i][chooseMonth]["Salário"] + salario;
                              }
                              finalResultVendas = finalResultOvos + finalResultFrangos +  finalResultGado + finalResultLeite + finalResultQueijo + finalResultRequeijao + finalResultOutrasVendas + salario;

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

                              print("CheckAllResult: $checkAllRslt");

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
                      height: 45 * SizeConfig.blockSizeVertical,
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
                            Text("Salário: R\$${(salario).toStringAsPrecision(checkRsltEntrada[0])}", style: TextStyle(
                                fontSize: 5 * SizeConfig.blockSizeHorizontal
                            ),),
                            Divider(
                              color: Colors.black,
                              thickness: 1 * SizeConfig.blockSizeHorizontal,
                            ),
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

                            Text("Gado: R\$${finalResultGado.toStringAsPrecision(checkRsltEntrada[3])}", style: TextStyle(
                                fontSize: 5 * SizeConfig.blockSizeHorizontal
                            ),),
                            Divider(
                              color: Colors.black,
                              thickness: 1 * SizeConfig.blockSizeHorizontal,
                            ),

                            Text("Leite: R\$${finalResultLeite.toStringAsPrecision(checkRsltEntrada[4])}", style: TextStyle(
                                fontSize: 5 * SizeConfig.blockSizeHorizontal
                            ),),
                            Divider(
                              color: Colors.black,
                              thickness: 1 * SizeConfig.blockSizeHorizontal,
                            ),

                            Text("Queijo: R\$${finalResultQueijo.toStringAsPrecision(checkRsltEntrada[5])}", style: TextStyle(
                                fontSize: 5 * SizeConfig.blockSizeHorizontal
                            ),),
                            Divider(
                              color: Colors.black,
                              thickness: 1 * SizeConfig.blockSizeHorizontal,
                            ),

                            Text("Requeijão: R\$${finalResultRequeijao.toStringAsPrecision(checkRsltEntrada[6])}", style: TextStyle(
                                fontSize: 5 * SizeConfig.blockSizeHorizontal
                            ),),
                            Divider(
                              color: Colors.black,
                              thickness: 1 * SizeConfig.blockSizeHorizontal,
                            ),
                            Text("Outros: R\$${finalResultOutrasVendas.toStringAsPrecision(checkRsltEntrada[7])}", style: TextStyle(
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
                    height: 45 * SizeConfig.blockSizeVertical,
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

                          Text("Sal: R\$${finalResultSal.toStringAsPrecision(checkRsltSaida[2])}", style: TextStyle(
                              fontSize: 5 * SizeConfig.blockSizeHorizontal
                          ),),
                          Divider(
                            color: Colors.black,
                            thickness: 1 * SizeConfig.blockSizeHorizontal,
                          ),

                          Text("Ração: R\$${finalResultRacao.toStringAsPrecision(checkRsltSaida[3])}", style: TextStyle(
                              fontSize: 5 * SizeConfig.blockSizeHorizontal
                          ),),
                          Divider(
                            color: Colors.black,
                            thickness: 1 * SizeConfig.blockSizeHorizontal,
                          ),

                          Text("Farmácia:R\$${finalResultFarmacia.toStringAsPrecision(checkRsltSaida[4])}", style: TextStyle(
                              fontSize: 5 * SizeConfig.blockSizeHorizontal
                          ),),
                          Divider(
                            color: Colors.black,
                            thickness: 1 * SizeConfig.blockSizeHorizontal,
                          ),

                          Text("Gasolina: R\$${finalResultGasolina.toStringAsPrecision(checkRsltSaida[5])}", style: TextStyle(
                              fontSize: 5 * SizeConfig.blockSizeHorizontal
                          ),),
                          Divider(
                            color: Colors.black,
                            thickness: 1 * SizeConfig.blockSizeHorizontal,
                          ),

                          Text("Mercado: R\$${finalResultMercado.toStringAsPrecision(checkRsltSaida[6])}", style: TextStyle(
                              fontSize: 5 * SizeConfig.blockSizeHorizontal
                          ),),
                          Divider(
                            color: Colors.black,
                            thickness: 1 * SizeConfig.blockSizeHorizontal,
                          ),

                          Text("Outros: R\$${finalResultOutrosGastos.toStringAsPrecision(checkRsltSaida[7])}", style: TextStyle(
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


    if(finalResultSal >= 0 && finalResultSal <= 9){
      checkRsltSaida[2] = 3;
    }else if(finalResultSal >= 10 && finalResultSal <= 99){
      checkRsltSaida[2] = 4;
    }else if(finalResultSal >= 100 && finalResultSal <= 999){
      checkRsltSaida[2] = 5;
    }else if(finalResultSal >= 1000 && finalResultSal <= 9999){
      checkRsltSaida[2] = 6;
    }else if(finalResultSal >= 10000 && finalResultSal <= 99999){
      checkRsltSaida[2] = 7;
    }

    if(finalResultRacao >= 0 && finalResultRacao <= 9){
      checkRsltSaida[3] = 3;
    }else if(finalResultRacao >= 10 && finalResultRacao <= 99){
      checkRsltSaida[3] = 4;
    }else if(finalResultRacao >= 100 && finalResultRacao <= 999){
      checkRsltSaida[3] = 5;
    }else if(finalResultRacao >= 1000 && finalResultRacao <= 9999){
      checkRsltSaida[3] = 6;
    }else if(finalResultRacao >= 10000 && finalResultRacao <= 99999){
      checkRsltSaida[3] = 7;
    }

    if(finalResultFarmacia >= 0 && finalResultFarmacia <= 9){
      checkRsltSaida[4] = 3;
    }else if(finalResultFarmacia >= 10 && finalResultFarmacia <= 99){
      checkRsltSaida[4] = 4;
    }else if(finalResultFarmacia >= 100 && finalResultFarmacia <= 999){
      checkRsltSaida[4] = 5;
    }else if(finalResultFarmacia >= 1000 && finalResultFarmacia <= 9999){
      checkRsltSaida[4] = 6;
    }else if(finalResultFarmacia >= 10000 && finalResultFarmacia <= 99999){
      checkRsltSaida[4] = 7;
    }

    if(finalResultGasolina >= 0 && finalResultGasolina <= 9){
      checkRsltSaida[5] = 3;
    }else if(finalResultGasolina >= 10 && finalResultGasolina <= 99){
      checkRsltSaida[5] = 4;
    }else if(finalResultGasolina >= 100 && finalResultGasolina <= 999){
      checkRsltSaida[5] = 5;
    }else if(finalResultGasolina >= 1000 && finalResultGasolina <= 9999){
      checkRsltSaida[5] = 6;
    }else if(finalResultGasolina >= 10000 && finalResultGasolina <= 99999){
      checkRsltSaida[5] = 7;
    }

    if(finalResultMercado >= 0 && finalResultMercado <= 9){
      checkRsltSaida[6] = 3;
    }else if(finalResultMercado >= 10 && finalResultMercado <= 99){
      checkRsltSaida[6] = 4;
    }else if(finalResultMercado >= 100 && finalResultMercado <= 999){
      checkRsltSaida[6] = 5;
    }else if(finalResultMercado >= 1000 && finalResultMercado <= 9999){
      checkRsltSaida[6] = 6;
    }else if(finalResultMercado >= 10000 && finalResultMercado <= 99999){
      checkRsltSaida[6] = 7;
    }

    if(finalResultOutrosGastos >= 0 && finalResultOutrosGastos <= 9){
      checkRsltSaida[7] = 3;
    }else if(finalResultOutrosGastos >= 10 && finalResultOutrosGastos <= 99){
      checkRsltSaida[7] = 4;
    }else if(finalResultOutrosGastos >= 100 && finalResultOutrosGastos <= 999){
      checkRsltSaida[7] = 5;
    }else if(finalResultOutrosGastos >= 1000 && finalResultOutrosGastos <= 9999){
      checkRsltSaida[7] = 6;
    }else if(finalResultOutrosGastos >= 10000 && finalResultOutrosGastos <= 99999){
      checkRsltSaida[7] = 7;
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
    if(salario >= 0 && salario <= 9){
      checkRsltEntrada[0] = 3;
    }else if(salario >= 10 && salario <= 99){
      checkRsltEntrada[0] = 4;
    }else if(salario >= 100 && salario <= 999){
      checkRsltEntrada[0] = 5;
    }else if(salario >= 1000 && salario <= 9999){
      checkRsltEntrada[0] = 6;
    }else if(salario >= 10000 && salario <= 99999){
      checkRsltEntrada[0] = 7;
    }

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

    if(finalResultGado >= 0 && finalResultGado <= 9){
      checkRsltEntrada[3] = 3;
    }else if(finalResultGado >= 10 && finalResultGado <= 99){
      checkRsltEntrada[3] = 4;
    }else if(finalResultGado >= 100 && finalResultGado <= 999){
      checkRsltEntrada[3] = 5;
    }else if(finalResultGado >= 1000 && finalResultGado <= 9999){
      checkRsltEntrada[3] = 6;
    }else if(finalResultGado >= 10000 && finalResultGado <= 99999){
      checkRsltEntrada[3] = 7;
    }

    if(finalResultLeite >= 0 && finalResultLeite <= 9){
      checkRsltEntrada[4] = 3;
    }else if(finalResultLeite >= 10 && finalResultLeite <= 99){
      checkRsltEntrada[4] = 4;
    }else if(finalResultLeite >= 100 && finalResultLeite <= 999){
      checkRsltEntrada[4] = 5;
    }else if(finalResultLeite >= 1000 && finalResultLeite <= 9999){
      checkRsltEntrada[4] = 6;
    }else if(finalResultLeite >= 10000 && finalResultLeite <= 99999){
      checkRsltEntrada[4] = 7;
    }

    if(finalResultQueijo >= 0 && finalResultQueijo <= 9){
      checkRsltEntrada[5] = 3;
    }else if(finalResultQueijo >= 10 && finalResultQueijo <= 99){
      checkRsltEntrada[5] = 4;
    }else if(finalResultQueijo >= 100 && finalResultQueijo <= 999){
      checkRsltEntrada[5] = 5;
    }else if(finalResultQueijo >= 1000 && finalResultQueijo <= 9999){
      checkRsltEntrada[5] = 6;
    }else if(finalResultQueijo >= 10000 && finalResultQueijo <= 99999){
      checkRsltEntrada[5] = 7;
    }

    if(finalResultRequeijao >= 0 && finalResultRequeijao <= 9){
      checkRsltEntrada[6] = 3;
    }else if(finalResultRequeijao >= 10 && finalResultRequeijao <= 99){
      checkRsltEntrada[6] = 4;
    }else if(finalResultRequeijao >= 100 && finalResultRequeijao <= 999){
      checkRsltEntrada[6] = 5;
    }else if(finalResultRequeijao >= 1000 && finalResultRequeijao <= 9999){
      checkRsltEntrada[6] = 6;
    }else if(finalResultRequeijao >= 10000 && finalResultRequeijao <= 99999){
      checkRsltEntrada[6] = 7;
    }

    if(finalResultOutrasVendas >= 0 && finalResultOutrasVendas <= 9){
      checkRsltEntrada[7] = 3;
    }else if(finalResultOutrasVendas >= 10 && finalResultOutrasVendas <= 99){
      checkRsltEntrada[7] = 4;
    }else if(finalResultOutrasVendas >= 100 && finalResultOutrasVendas <= 999){
      checkRsltEntrada[7] = 5;
    }else if(finalResultOutrasVendas >= 1000 && finalResultOutrasVendas <= 9999){
      checkRsltEntrada[7] = 6;
    }else if(finalResultOutrasVendas >= 10000 && finalResultOutrasVendas <= 99999){
      checkRsltEntrada[7] = 7;
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

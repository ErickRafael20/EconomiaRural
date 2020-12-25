import 'dart:async';

import 'package:despesas_galinhas/ui/Class/jsonPath.dart';
import 'dart:convert';
import 'package:despesas_galinhas/ui/Class/YearClass/year_mapFarmacia.dart';
import 'package:despesas_galinhas/ui/Class/YearClass/year_mapGasolina.dart';
import 'package:despesas_galinhas/ui/Class/YearClass/year_mapMercado.dart';
import 'package:despesas_galinhas/ui/Class/YearClass/year_mapOutrosGastos.dart';
import 'package:despesas_galinhas/ui/Class/YearClass/year_mapOvoFrango.dart';
import 'package:despesas_galinhas/ui/Class/YearClass/year_mapGado.dart';
import 'package:despesas_galinhas/ui/Class/YearClass/year_mapOutrasVendas.dart';

class YearMapGAnimais{
  Map<String, dynamic> yearMapGAnimais;
  Map<String, dynamic> fileContentGAnimais;

  Future newYearGAnimaisFunction()async{
    final jsonFileGAnimais = await JsonPath().localGAnimaisFileJson;

    fileContentGAnimais = json.decode(jsonFileGAnimais.readAsStringSync());

    print(fileContentGAnimais);

    int y = 0;
    y = fileContentGAnimais["YearIncrement"];

    fileContentGAnimais["despesas"].addAll([newYearGAnimais(y)]);

    y++;

    fileContentGAnimais["YearIncrement"] = y;

    print("Criando Mapa");

    Map<String, dynamic> mapIncrementGAnimais;

    mapIncrementGAnimais = json.decode(jsonFileGAnimais.readAsStringSync());


    mapIncrementGAnimais.addAll(fileContentGAnimais);

     jsonFileGAnimais.writeAsStringSync(json.encode(mapIncrementGAnimais));

     Timer(Duration(milliseconds: 20),(){
       YearMapFarmacia().newYearFunctionFarmacia();
     });
    Timer(Duration(milliseconds: 40),(){
      YearMapGasolina().newYearGasolinaFunction();
    });
    Timer(Duration(milliseconds: 60),(){
      YearMapMercado().newYearMercadoFunction();
    });
    Timer(Duration(milliseconds: 80),(){
      YearMapOutrosGastos().newYearOutrosGastosFunction();
    });
    Timer(Duration(milliseconds: 100),(){
      YearMapOvoFrango().newYearOvoFrangoFunction();
    });
    Timer(Duration(milliseconds: 120),(){
      YearMapGado().newYearGadoFunction();
    });
    Timer(Duration(milliseconds: 140),(){
      YearMapOutrasVendas().newYearOutrasVendasFunction();
    });


  }


  Map<String,dynamic> newYearGAnimais(int i) {
   return yearMapGAnimais = {
     "Ano": "$i",
     "Milho":
     {
       "Result": 0.00
     },
     "Canjica":
     {
       "Result": 0.00
     },
     "Sal":
     {
       "Result": 0.00
     },
     "Ração":
     {
       "Result": 0.00
     },
     "Year":
     [
       {
         "Mês":"Janeiro",
         "Month":
         [
           {
             "Milho":
             {
               "Valor": 0.00,
               "Qnt": 0.00,
               "Result": 0.00,
               "LengthIncrement" : 0
             }
           },
           {
             "Canjica":
             {
               "Valor": 0.00,
               "Qnt": 0.00,
               "Result": 0.00,
               "LengthIncrement" : 0
             }
           },
           {
             "Sal":
             {
               "Valor": 0.00,
               "Qnt": 0.00,
               "Result": 0.00,
               "LengthIncrement" : 0
             }
           },
           {
             "Ração":
             {
               "Valor": 0.00,
               "Qnt": 0.00,
               "Result": 0.00,
               "LengthIncrement" : 0

             }
           }
         ]
       },
       {
         "Mês":"Fevereiro",
         "Month":
         [
           {
             "Milho":
             {
               "Valor": 0.00,
               "Qnt": 0.00,
               "Result": 0.00,
               "LengthIncrement" : 0
             }
           },
           {
             "Canjica":
             {
               "Valor": 0.00,
               "Qnt": 0.00,
               "Result": 0.00,
               "LengthIncrement" : 0
             }
           },
           {
             "Sal":
             {
               "Valor": 0.00,
               "Qnt": 0.00,
               "Result": 0.00,
               "LengthIncrement" : 0
             }
           },
           {
             "Ração":
             {
               "Valor": 0.00,
               "Qnt": 0.00,
               "Result": 0.00,
               "LengthIncrement" : 0

             }
           }
         ]
       },
       {
         "Mês":"Março",
         "Month":
         [
           {
             "Milho":
             {
               "Valor": 0.00,
               "Qnt": 0.00,
               "Result": 0.00,
               "LengthIncrement" : 0
             }
           },
           {
             "Canjica":
             {
               "Valor": 0.00,
               "Qnt": 0.00,
               "Result": 0.00,
               "LengthIncrement" : 0
             }
           },
           {
             "Sal":
             {
               "Valor": 0.00,
               "Qnt": 0.00,
               "Result": 0.00,
               "LengthIncrement" : 0
             }
           },
           {
             "Ração":
             {
               "Valor": 0.00,
               "Qnt": 0.00,
               "Result": 0.00,
               "LengthIncrement" : 0

             }
           }
         ]
       },
       {
         "Mês":"Abril",
         "Month":
         [
           {
             "Milho":
             {
               "Valor": 0.00,
               "Qnt": 0.00,
               "Result": 0.00,
               "LengthIncrement" : 0
             }
           },
           {
             "Canjica":
             {
               "Valor": 0.00,
               "Qnt": 0.00,
               "Result": 0.00,
               "LengthIncrement" : 0
             }
           },
           {
             "Sal":
             {
               "Valor": 0.00,
               "Qnt": 0.00,
               "Result": 0.00,
               "LengthIncrement" : 0
             }
           },
           {
             "Ração":
             {
               "Valor": 0.00,
               "Qnt": 0.00,
               "Result": 0.00,
               "LengthIncrement" : 0

             }
           }
         ]
       },
       {
         "Mês":"Maio",
         "Month":
         [
           {
             "Milho":
             {
               "Valor": 0.00,
               "Qnt": 0.00,
               "Result": 0.00,
               "LengthIncrement" : 0
             }
           },
           {
             "Canjica":
             {
               "Valor": 0.00,
               "Qnt": 0.00,
               "Result": 0.00,
               "LengthIncrement" : 0
             }
           },
           {
             "Sal":
             {
               "Valor": 0.00,
               "Qnt": 0.00,
               "Result": 0.00,
               "LengthIncrement" : 0
             }
           },
           {
             "Ração":
             {
               "Valor": 0.00,
               "Qnt": 0.00,
               "Result": 0.00,
               "LengthIncrement" : 0

             }
           }
         ]
       },
       {
         "Mês":"Junho",
         "Month":
         [
           {
             "Milho":
             {
               "Valor": 0.00,
               "Qnt": 0.00,
               "Result": 0.00,
               "LengthIncrement" : 0
             }
           },
           {
             "Canjica":
             {
               "Valor": 0.00,
               "Qnt": 0.00,
               "Result": 0.00,
               "LengthIncrement" : 0
             }
           },
           {
             "Sal":
             {
               "Valor": 0.00,
               "Qnt": 0.00,
               "Result": 0.00,
               "LengthIncrement" : 0
             }
           },
           {
             "Ração":
             {
               "Valor": 0.00,
               "Qnt": 0.00,
               "Result": 0.00,
               "LengthIncrement" : 0

             }
           }
         ]
       },
       {
         "Mês":"Julho",
         "Month":
         [
           {
             "Milho":
             {
               "Valor": 0.00,
               "Qnt": 0.00,
               "Result": 0.00,
               "LengthIncrement" : 0
             }
           },
           {
             "Canjica":
             {
               "Valor": 0.00,
               "Qnt": 0.00,
               "Result": 0.00,
               "LengthIncrement" : 0
             }
           },
           {
             "Sal":
             {
               "Valor": 0.00,
               "Qnt": 0.00,
               "Result": 0.00,
               "LengthIncrement" : 0
             }
           },
           {
             "Ração":
             {
               "Valor": 0.00,
               "Qnt": 0.00,
               "Result": 0.00,
               "LengthIncrement" : 0

             }
           }
         ]
       },
       {
         "Mês":"Agosto",
         "Month":
         [
           {
             "Milho":
             {
               "Valor": 0.00,
               "Qnt": 0.00,
               "Result": 0.00,
               "LengthIncrement" : 0
             }
           },
           {
             "Canjica":
             {
               "Valor": 0.00,
               "Qnt": 0.00,
               "Result": 0.00,
               "LengthIncrement" : 0
             }
           },
           {
             "Sal":
             {
               "Valor": 0.00,
               "Qnt": 0.00,
               "Result": 0.00,
               "LengthIncrement" : 0
             }
           },
           {
             "Ração":
             {
               "Valor": 0.00,
               "Qnt": 0.00,
               "Result": 0.00,
               "LengthIncrement" : 0

             }
           }
         ]
       },
       {
         "Mês":"Setembro",
         "Month":
         [
           {
             "Milho":
             {
               "Valor": 0.00,
               "Qnt": 0.00,
               "Result": 0.00,
               "LengthIncrement" : 0
             }
           },
           {
             "Canjica":
             {
               "Valor": 0.00,
               "Qnt": 0.00,
               "Result": 0.00,
               "LengthIncrement" : 0
             }
           },
           {
             "Sal":
             {
               "Valor": 0.00,
               "Qnt": 0.00,
               "Result": 0.00,
               "LengthIncrement" : 0
             }
           },
           {
             "Ração":
             {
               "Valor": 0.00,
               "Qnt": 0.00,
               "Result": 0.00,
               "LengthIncrement" : 0

             }
           }
         ]
       },
       {
         "Mês":"Outubro",
         "Month":
         [
           {
             "Milho":
             {
               "Valor": 0.00,
               "Qnt": 0.00,
               "Result": 0.00,
               "LengthIncrement" : 0
             }
           },
           {
             "Canjica":
             {
               "Valor": 0.00,
               "Qnt": 0.00,
               "Result": 0.00,
               "LengthIncrement" : 0
             }
           },
           {
             "Sal":
             {
               "Valor": 0.00,
               "Qnt": 0.00,
               "Result": 0.00,
               "LengthIncrement" : 0
             }
           },
           {
             "Ração":
             {
               "Valor": 0.00,
               "Qnt": 0.00,
               "Result": 0.00,
               "LengthIncrement" : 0

             }
           }
         ]
       },
       {
         "Mês":"Novembro",
         "Month":
         [
           {
             "Milho":
             {
               "Valor": 0.00,
               "Qnt": 0.00,
               "Result": 0.00,
               "LengthIncrement" : 0
             }
           },
           {
             "Canjica":
             {
               "Valor": 0.00,
               "Qnt": 0.00,
               "Result": 0.00,
               "LengthIncrement" : 0
             }
           },
           {
             "Sal":
             {
               "Valor": 0.00,
               "Qnt": 0.00,
               "Result": 0.00,
               "LengthIncrement" : 0
             }
           },
           {
             "Ração":
             {
               "Valor": 0.00,
               "Qnt": 0.00,
               "Result": 0.00,
               "LengthIncrement" : 0

             }
           }
         ]
       },
       {
         "Mês":"Dezembro",
         "Month":
         [
           {
             "Milho":
             {
               "Valor": 0.00,
               "Qnt": 0.00,
               "Result": 0.00,
               "LengthIncrement" : 0
             }
           },
           {
             "Canjica":
             {
               "Valor": 0.00,
               "Qnt": 0.00,
               "Result": 0.00,
               "LengthIncrement" : 0
             }
           },
           {
             "Sal":
             {
               "Valor": 0.00,
               "Qnt": 0.00,
               "Result": 0.00,
               "LengthIncrement" : 0
             }
           },
           {
             "Ração":
             {
               "Valor": 0.00,
               "Qnt": 0.00,
               "Result": 0.00,
               "LengthIncrement" : 0

             }
           }
         ]
       }
     ]
   };
  }
}
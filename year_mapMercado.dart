import 'dart:convert';

import 'package:despesas_galinhas/ui/Class/jsonPath.dart';

class YearMapMercado{
  Map<String, dynamic> yearMapMercado;
  Map<String, dynamic> fileContentMercado;

  Future newYearMercadoFunction()async{

    final jsonFileMercado = await JsonPath().localFileMercadoJson;

    fileContentMercado = json.decode(jsonFileMercado.readAsStringSync());

    int y = 0;
    y = fileContentMercado["YearIncrement"];

    print("Add all Year Map");

    fileContentMercado["mercado"].addAll([newYearMercado(y)]);

    y++;

    fileContentMercado["YearIncrement"] = y;


    print("Criando Mapa");

    Map<String, dynamic> mapIncrementMercado;

    mapIncrementMercado = json.decode(jsonFileMercado.readAsStringSync());

    mapIncrementMercado.addAll(fileContentMercado);

    print("MapasAdicionados");

    jsonFileMercado.writeAsStringSync(json.encode(mapIncrementMercado));


  }


  Map<String,dynamic> newYearMercado(int i) {
    return yearMapMercado = {
      "Ano": "$i",
      "Result": 0.00,
      "Year":
      [
        {
              "Mês":"Janeiro",
              "Month":
              {
                "Valor": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Mês":"Fevereiro",
              "Month":
              {
                "Valor": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Mês":"Março",
              "Month":
              {
                "Valor": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Mês":"Abril",
              "Month":
              {
                "Valor": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Mês":"Maio",
              "Month":
              {
                "Valor": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Mês":"Junho",
              "Month":
              {
                "Valor": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Mês":"Julho",
              "Month":
              {
                "Valor": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Mês":"Agosto",
              "Month":
              {
                "Valor": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Mês":"Setembro",
              "Month":
              {
                "Valor": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Mês":"Outubro",
              "Month":
              {
                "Valor": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Mês":"Novembro",
              "Month":
              {
                "Valor": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Mês":"Dezembro",
              "Month":
              {
                "Valor": 0.00,
                "LengthIncrement" : 0
              }
            }
          ]

    };
  }
}
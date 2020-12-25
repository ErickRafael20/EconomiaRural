import 'dart:convert';

import 'package:despesas_galinhas/ui/Class/jsonPath.dart';

class YearMapFarmacia{
  Map<String, dynamic> yearMapFarmacia;
  Map<String, dynamic> fileContentFarmacia;

  Future newYearFunctionFarmacia()async{
    final jsonFileFarmacia = await JsonPath().localFileFarmaciaJson;

    fileContentFarmacia = json.decode(jsonFileFarmacia.readAsStringSync());

    int y = 0;
    y = fileContentFarmacia["YearIncrement"];

    print("Add all Year Map");

    fileContentFarmacia["farmacia"].addAll([newYearFarmacia(y)]);

    y++;

    fileContentFarmacia["YearIncrement"] = y;

    print("Criando Mapa");

    Map<String, dynamic> mapIncrementFarmacia;

    mapIncrementFarmacia = json.decode(jsonFileFarmacia.readAsStringSync());

    mapIncrementFarmacia.addAll(fileContentFarmacia);

    print("MapasAdicionados");

    jsonFileFarmacia.writeAsStringSync(json.encode(mapIncrementFarmacia));

  }


  Map<String,dynamic> newYearFarmacia(int i) {
    return yearMapFarmacia = {
      "Ano":"$i",
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
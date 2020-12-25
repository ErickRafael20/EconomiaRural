import 'dart:convert';

import 'package:despesas_galinhas/ui/Class/jsonPath.dart';

class YearMapGasolina{
  Map<String, dynamic> yearMapGasolina;
  Map<String, dynamic> fileContentGasolina;

  Future newYearGasolinaFunction()async{
    final jsonFileGasolina = await JsonPath().localFileGasolinaJson;

    fileContentGasolina = json.decode(jsonFileGasolina.readAsStringSync());

    int y = 0;
    y = fileContentGasolina["YearIncrement"];

    fileContentGasolina["gasolina"].addAll([newYearGasolina(y)]);

    y++;

    fileContentGasolina["YearIncrement"] = y;

    Map<String, dynamic> mapIncrementGasolina;

    mapIncrementGasolina = json.decode(jsonFileGasolina.readAsStringSync());

    mapIncrementGasolina.addAll(fileContentGasolina);

    print("MapasAdicionados");

    jsonFileGasolina.writeAsStringSync(json.encode(mapIncrementGasolina));

  }


  Map<String,dynamic> newYearGasolina(int i) {
    return yearMapGasolina = {
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
import 'dart:convert';

import 'package:despesas_galinhas/ui/Class/jsonPath.dart';

class YearMapOvoFrango{
  Map<String, dynamic> yearMapOvoFrango;
  Map<String, dynamic> fileContentOvosFrangos;


  Future newYearOvoFrangoFunction()async{
    final jsonFileOvosFrangos = await JsonPath().localOvoFrangoFileJson;

    fileContentOvosFrangos = json.decode(jsonFileOvosFrangos.readAsStringSync());


    int y = 0;
    y = fileContentOvosFrangos["YearIncrement"];

    fileContentOvosFrangos["lucro"].addAll([newYearOvoFrango(y)]);

    y++;

    fileContentOvosFrangos["YearIncrement"] = y;


    Map<String,dynamic> mapIncrementOvosFrangos;


    mapIncrementOvosFrangos = json.decode(jsonFileOvosFrangos.readAsStringSync());


    mapIncrementOvosFrangos.addAll(fileContentOvosFrangos);


    jsonFileOvosFrangos.writeAsStringSync(json.encode(mapIncrementOvosFrangos));

  }


  Map<String,dynamic> newYearOvoFrango(int i) {
    return yearMapOvoFrango = {
      "Ano": "$i",
      "Ovo":
      {
        "Result": 0.00
      },
      "Frango":
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
              "Ovo":
              {
                "Valor": 0.00,
                "Qnt": 0.00,
                "Result": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Frango":
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
              "Ovo":
              {
                "Valor": 0.00,
                "Qnt": 0.00,
                "Result": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Frango":
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
              "Ovo":
              {
                "Valor": 0.00,
                "Qnt": 0.00,
                "Result": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Frango":
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
              "Ovo":
              {
                "Valor": 0.00,
                "Qnt": 0.00,
                "Result": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Frango":
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
              "Ovo":
              {
                "Valor": 0.00,
                "Qnt": 0.00,
                "Result": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Frango":
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
              "Ovo":
              {
                "Valor": 0.00,
                "Qnt": 0.00,
                "Result": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Frango":
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
              "Ovo":
              {
                "Valor": 0.00,
                "Qnt": 0.00,
                "Result": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Frango":
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
              "Ovo":
              {
                "Valor": 0.00,
                "Qnt": 0.00,
                "Result": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Frango":
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
              "Ovo":
              {
                "Valor": 0.00,
                "Qnt": 0.00,
                "Result": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Frango":
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
              "Ovo":
              {
                "Valor": 0.00,
                "Qnt": 0.00,
                "Result": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Frango":
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
              "Ovo":
              {
                "Valor": 0.00,
                "Qnt": 0.00,
                "Result": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Frango":
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
              "Ovo":
              {
                "Valor": 0.00,
                "Qnt": 0.00,
                "Result": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Frango":
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
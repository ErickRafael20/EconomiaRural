import 'dart:convert';

import 'package:despesas_galinhas/ui/Class/jsonPath.dart';

class YearMapOutrosGastos{
  Map<String, dynamic> yearMapOutrosGastos;
  Map<String, dynamic> fileContentOtrGastos;

  Future newYearOutrosGastosFunction()async{
    final jsonFileOtrGastos = await JsonPath().localFileOutrosGastosJson;


    fileContentOtrGastos = json.decode(jsonFileOtrGastos.readAsStringSync());


    int y = 0;
    y = fileContentOtrGastos["YearIncrement"];

    fileContentOtrGastos["outros"].addAll([newYearOutrosGastos(y)]);

    y++;

    fileContentOtrGastos["YearIncrement"] = y;


    Map<String, dynamic> mapIncrementOtrGastos;

    mapIncrementOtrGastos = json.decode(jsonFileOtrGastos.readAsStringSync());

    mapIncrementOtrGastos.addAll(fileContentOtrGastos);

    print("MapasAdicionados");

    jsonFileOtrGastos.writeAsStringSync(json.encode(mapIncrementOtrGastos));


  }


  Map<String,dynamic> newYearOutrosGastos(int i) {
    return yearMapOutrosGastos = {
      "Ano":"2021",
      "Result": 0.00,
      "Year":
      [
        {
          "Mês":"Janeiro",
          "Month":
          [
            {
              "Outros1":
              {
                "Valor": 0.00,
                "LengthIncrement" : 0
              }

            },
            {
              "Outros2":
              {
                "Valor": 0.00,
                "Qnt": 0,
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
              "Outros1":
              {
                "Valor": 0.00,
                "LengthIncrement" : 0
              }

            },
            {
              "Outros2":
              {
                "Valor": 0.00,
                "Qnt": 0,
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
              "Outros1":
              {
                "Valor": 0.00,
                "LengthIncrement" : 0
              }

            },
            {
              "Outros2":
              {
                "Valor": 0.00,
                "Qnt": 0,
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
              "Outros1":
              {
                "Valor": 0.00,
                "LengthIncrement" : 0
              }

            },
            {
              "Outros2":
              {
                "Valor": 0.00,
                "Qnt": 0,
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
              "Outros1":
              {
                "Valor": 0.00,
                "LengthIncrement" : 0
              }

            },
            {
              "Outros2":
              {
                "Valor": 0.00,
                "Qnt": 0,
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
              "Outros1":
              {
                "Valor": 0.00,
                "LengthIncrement" : 0
              }

            },
            {
              "Outros2":
              {
                "Valor": 0.00,
                "Qnt": 0,
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
              "Outros1":
              {
                "Valor": 0.00,
                "LengthIncrement" : 0
              }

            },
            {
              "Outros2":
              {
                "Valor": 0.00,
                "Qnt": 0,
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
              "Outros1":
              {
                "Valor": 0.00,
                "LengthIncrement" : 0
              }

            },
            {
              "Outros2":
              {
                "Valor": 0.00,
                "Qnt": 0,
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
              "Outros1":
              {
                "Valor": 0.00,
                "LengthIncrement" : 0
              }

            },
            {
              "Outros2":
              {
                "Valor": 0.00,
                "Qnt": 0,
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
              "Outros1":
              {
                "Valor": 0.00,
                "LengthIncrement" : 0
              }

            },
            {
              "Outros2":
              {
                "Valor": 0.00,
                "Qnt": 0,
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
              "Outros1":
              {
                "Valor": 0.00,
                "LengthIncrement" : 0
              }

            },
            {
              "Outros2":
              {
                "Valor": 0.00,
                "Qnt": 0,
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
              "Outros1":
              {
                "Valor": 0.00,
                "LengthIncrement" : 0
              }

            },
            {
              "Outros2":
              {
                "Valor": 0.00,
                "Qnt": 0,
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
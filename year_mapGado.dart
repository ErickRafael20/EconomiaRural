import 'dart:convert';

import 'package:despesas_galinhas/ui/Class/jsonPath.dart';

class YearMapGado{
  Map<String, dynamic> yearMapGado;
  Map<String, dynamic> fileContentGado;

  Future newYearGadoFunction()async{
    final jsonFileGado = await JsonPath().localFileGadoJson;

    fileContentGado = json.decode(jsonFileGado.readAsStringSync());

    int y = 0;
    y = fileContentGado["YearIncrement"];

    fileContentGado["gado"].addAll([newYearGado(y)]);

    y++;

    fileContentGado["YearIncrement"] = y;

    Map<String, dynamic> mapIncrementGado;

    mapIncrementGado = json.decode(jsonFileGado.readAsStringSync());


    mapIncrementGado.addAll(fileContentGado);


    jsonFileGado.writeAsStringSync(json.encode(mapIncrementGado));

  }


  Map<String,dynamic> newYearGado(int i) {
    return yearMapGado = {
      "Ano": "$i",
      "Gado":
      {
        "Result": 0.00
      },
      "Leite":
      {
        "Result": 0.00
      },
      "Queijo":
      {
        "Result": 0.00
      },
      "Requeijao":
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
              "Gado":
              {
                "Valor": 0.00,
                "Qnt": 0.00,
                "Result": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Leite":
              {
                "Valor": 0.00,
                "Qnt": 0.00,
                "Result": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Queijo":
              {
                "Valor": 0.00,
                "Qnt": 0.00,
                "Result": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Requeijao":
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
              "Gado":
              {
                "Valor": 0.00,
                "Qnt": 0.00,
                "Result": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Leite":
              {
                "Valor": 0.00,
                "Qnt": 0.00,
                "Result": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Queijo":
              {
                "Valor": 0.00,
                "Qnt": 0.00,
                "Result": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Requeijao":
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
              "Gado":
              {
                "Valor": 0.00,
                "Qnt": 0.00,
                "Result": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Leite":
              {
                "Valor": 0.00,
                "Qnt": 0.00,
                "Result": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Queijo":
              {
                "Valor": 0.00,
                "Qnt": 0.00,
                "Result": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Requeijao":
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
              "Gado":
              {
                "Valor": 0.00,
                "Qnt": 0.00,
                "Result": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Leite":
              {
                "Valor": 0.00,
                "Qnt": 0.00,
                "Result": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Queijo":
              {
                "Valor": 0.00,
                "Qnt": 0.00,
                "Result": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Requeijao":
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
              "Gado":
              {
                "Valor": 0.00,
                "Qnt": 0.00,
                "Result": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Leite":
              {
                "Valor": 0.00,
                "Qnt": 0.00,
                "Result": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Queijo":
              {
                "Valor": 0.00,
                "Qnt": 0.00,
                "Result": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Requeijao":
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
              "Gado":
              {
                "Valor": 0.00,
                "Qnt": 0.00,
                "Result": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Leite":
              {
                "Valor": 0.00,
                "Qnt": 0.00,
                "Result": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Queijo":
              {
                "Valor": 0.00,
                "Qnt": 0.00,
                "Result": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Requeijao":
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
              "Gado":
              {
                "Valor": 0.00,
                "Qnt": 0.00,
                "Result": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Leite":
              {
                "Valor": 0.00,
                "Qnt": 0.00,
                "Result": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Queijo":
              {
                "Valor": 0.00,
                "Qnt": 0.00,
                "Result": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Requeijao":
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
              "Gado":
              {
                "Valor": 0.00,
                "Qnt": 0.00,
                "Result": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Leite":
              {
                "Valor": 0.00,
                "Qnt": 0.00,
                "Result": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Queijo":
              {
                "Valor": 0.00,
                "Qnt": 0.00,
                "Result": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Requeijao":
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
              "Gado":
              {
                "Valor": 0.00,
                "Qnt": 0.00,
                "Result": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Leite":
              {
                "Valor": 0.00,
                "Qnt": 0.00,
                "Result": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Queijo":
              {
                "Valor": 0.00,
                "Qnt": 0.00,
                "Result": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Requeijao":
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
              "Gado":
              {
                "Valor": 0.00,
                "Qnt": 0.00,
                "Result": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Leite":
              {
                "Valor": 0.00,
                "Qnt": 0.00,
                "Result": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Queijo":
              {
                "Valor": 0.00,
                "Qnt": 0.00,
                "Result": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Requeijao":
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
              "Gado":
              {
                "Valor": 0.00,
                "Qnt": 0.00,
                "Result": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Leite":
              {
                "Valor": 0.00,
                "Qnt": 0.00,
                "Result": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Queijo":
              {
                "Valor": 0.00,
                "Qnt": 0.00,
                "Result": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Requeijao":
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
              "Gado":
              {
                "Valor": 0.00,
                "Qnt": 0.00,
                "Result": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Leite":
              {
                "Valor": 0.00,
                "Qnt": 0.00,
                "Result": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Queijo":
              {
                "Valor": 0.00,
                "Qnt": 0.00,
                "Result": 0.00,
                "LengthIncrement" : 0
              }
            },
            {
              "Requeijao":
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
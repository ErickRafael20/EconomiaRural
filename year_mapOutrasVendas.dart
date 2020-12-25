import 'dart:convert';

import 'package:despesas_galinhas/ui/Class/jsonPath.dart';

class YearMapOutrasVendas{
  Map<String, dynamic> yearMapOutrasVendas;
  Map<String, dynamic> fileContentOtrVendas;

  Future newYearOutrasVendasFunction()async{
    final jsonFileOtrVendas = await JsonPath().localFileOutrasVendasJson;

    fileContentOtrVendas = json.decode(jsonFileOtrVendas.readAsStringSync());

    int y = 0;

    y = fileContentOtrVendas["YearIncrement"];

    fileContentOtrVendas["outros"].addAll([newYearOutrasVendas(y)]);

    y++;

    fileContentOtrVendas["YearIncrement"] = y;

    Map<String, dynamic> mapIncrementOtrVendas;


    mapIncrementOtrVendas = json.decode(jsonFileOtrVendas.readAsStringSync());

    mapIncrementOtrVendas.addAll(fileContentOtrVendas);

    jsonFileOtrVendas.writeAsStringSync(json.encode(mapIncrementOtrVendas));


  }


  Map<String,dynamic> newYearOutrasVendas(int i) {
    return yearMapOutrasVendas = {
      "Ano": "$i",
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
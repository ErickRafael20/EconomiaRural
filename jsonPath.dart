import 'package:path_provider/path_provider.dart';
import 'dart:io';
class JsonPath{

  Future<String> get localPathJson async{
    final Directory directoryJson = await getExternalStorageDirectory();
    return directoryJson.path;
  }

  Future<File> get localGAnimaisFileJson async{
    final pathJson = await localPathJson;
    return File("$pathJson/Json/Gastos/GastosAnimais/despesas_data.json");
  }
  Future<File> get localFileFarmaciaJson async{
    final pathJson = await localPathJson;
    return File("$pathJson/Json/Gastos/Farmacia/farmacia_data.json");
  }
  Future<File> get localFileGasolinaJson async{
    final pathJson = await localPathJson;
    return File("$pathJson/Json/Gastos/Gasolina/gasolina_data.json");
  }
  Future<File> get localFileMercadoJson async{
    final pathJson = await localPathJson;
    return File("$pathJson/Json/Gastos/Mercado/mercado_data.json");
  }
  Future<File> get localFileOutrosGastosJson async{
    final pathJson = await localPathJson;
    return File("$pathJson/Json/Gastos/OutrosGastos/outrosgastos_data.json");
  }
  Future<File> get localOvoFrangoFileJson async{
    final pathJson = await localPathJson;
    return File("$pathJson/Json/Vendas/OvosFrangos/lucro_data.json");
  }
  Future<File> get localFileGadoJson async{
    final pathJson = await localPathJson;
    return File ("$pathJson/Json/Vendas/Gado/gado_data.json");
  }
  Future<File> get localFileOutrasVendasJson async{
    final pathJson = await localPathJson;
    return File("$pathJson/Json/Vendas/OutrasVendas/outrasvendas_data.json");
  }

  Future<File> get localFileSalarioJson async{
    final pathjson = await localPathJson;
    return File("$pathjson/Json/Salario/salario_data.json");
  }

}
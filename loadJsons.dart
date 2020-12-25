import 'package:despesas_galinhas/ui/Class/jsonPath.dart';
import 'dart:convert';


class LoadJsons{


  Future<Map<String,dynamic>> get loadJsonGAnimais async{
    final fileGAnimais = await JsonPath().localGAnimaisFileJson;
    return json.decode(fileGAnimais.readAsStringSync());

  }

  Future<Map<String,dynamic>> get loadJsonFarmacia async{
    final fileFarmacia = await JsonPath().localFileFarmaciaJson;
    return json.decode(fileFarmacia.readAsStringSync());
  }

  Future<Map<String,dynamic>> get loadJsonGasolina async{
    final fileGasolina = await JsonPath().localFileGasolinaJson;
    return json.decode(fileGasolina.readAsStringSync());
  }

  Future<Map<String,dynamic>> get loadJsonMercado async{
    final fileMercado = await JsonPath().localFileMercadoJson;
    return json.decode(fileMercado.readAsStringSync());
  }

  Future<Map<String,dynamic>> get loadJsonOutrosGastos async{
    final fileOutrosGastos = await JsonPath().localFileOutrosGastosJson;
    return json.decode(fileOutrosGastos.readAsStringSync());
  }

  Future<Map<String,dynamic>> get loadJsonOvosFrangos async{
    final fileOvosFrangos = await JsonPath().localOvoFrangoFileJson;
    return json.decode(fileOvosFrangos.readAsStringSync());
  }

  Future<Map<String,dynamic>> get loadJsonGado async{
    final fileGado = await JsonPath().localFileGadoJson;
    return json.decode(fileGado.readAsStringSync());
  }

  Future<Map<String,dynamic>> get loadJsonOutrasVendas async{
    final fileOutrasVendas = await JsonPath().localFileOutrasVendasJson;
    return json.decode(fileOutrasVendas.readAsStringSync());
  }

  Future<Map<String,dynamic>> get loadJsonSalario async{
    final fileSalario = await JsonPath().localFileSalarioJson;
    return json.decode(fileSalario.readAsStringSync());
  }
}
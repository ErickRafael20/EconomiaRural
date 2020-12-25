import 'dart:async';

import 'package:flutter/services.dart';
import 'jsonPath.dart';
import 'dart:io';
import 'directory.dart';

class ResetDataJson{

  Future createDataGastos() async{
    String despStr = await rootBundle.loadString("assets/Json/Gastos/GastosAnimais/gastosanimais.json");
    String farmStr = await rootBundle.loadString("assets/Json/Gastos/Farmacia/farmacia.json");
    String gasoStr = await rootBundle.loadString("assets/Json/Gastos/Gasolina/gasolina.json");
    String mercStr = await rootBundle.loadString("assets/Json/Gastos/Mercado/mercado.json");
    String otrGStr = await rootBundle.loadString("assets/Json/Gastos/OutrosGastos/outrosGastos.json");

    final despStrDir = await GetJsonDirectory().getJsonDirectoryGastosAnimais();
    final farmStrDir = await GetJsonDirectory().getJsonDirectoryGastosFarmacia();
    final gasoStrDir = await GetJsonDirectory().getJsonDirectoryGastosGasolina();
    final mercStrDir = await GetJsonDirectory().getJsonDirectoryGastosMercado();
    final otrGStrDir = await GetJsonDirectory().getJsonDirectoryGastosOutrosGastos();

    File despFile = File("${despStrDir}despesas_data.json");
    File farmFile = File("${farmStrDir}farmacia_data.json");
    File gasoFile = File("${gasoStrDir}gasolina_data.json");
    File mercFile = File("${mercStrDir}mercado_data.json");
    File otrGFile = File("${otrGStrDir}outrosgastos_data.json");

    despFile.writeAsStringSync(despStr);
    farmFile.writeAsStringSync(farmStr);
    gasoFile.writeAsStringSync(gasoStr);
    mercFile.writeAsStringSync(mercStr);
    otrGFile.writeAsStringSync(otrGStr);
  }

  Future createDataVendas() async{
    String lucroStr = await rootBundle.loadString("assets/Json/Vendas/OvosFrango/vendaovofrango.json");
    String gadoStr = await rootBundle.loadString("assets/Json/Vendas/Gado/gado.json");
    String otrVStr = await rootBundle.loadString("assets/Json/Vendas/OutrasVendas/outrasvendas.json");
    String salStr = await rootBundle.loadString("assets/Json/Vendas/Salario/salario.json");

    final lucroStrDir = await GetJsonDirectory().getJsonDirectoryVendasOvoFrango();
    final gadoStrDir = await GetJsonDirectory().getJsonDirectoryVendasGado();
    final otrVStrDir = await GetJsonDirectory().getJsonDirectoryVendasOutrasVendas();
    final salStrDir = await GetJsonDirectory().getJsonDirectorySalario();

    File lucroFile = File("${lucroStrDir}lucro_data.json");
    File gadoFile = File("${gadoStrDir}gado_data.json");
    File otrVFile = File("${otrVStrDir}outrasvendas_data.json");
    File salFile = File("${salStrDir}salario_data.json");

    lucroFile.writeAsStringSync(lucroStr);
    gadoFile.writeAsStringSync(gadoStr);
    otrVFile.writeAsStringSync(otrVStr);
    salFile.writeAsStringSync(salStr);
  }

  Future resetAllDataGastosVendas() async{
    final fileDesp = await JsonPath().localGAnimaisFileJson;
    final fileFarm = await JsonPath().localFileFarmaciaJson;
    final fileGaso = await JsonPath().localFileGasolinaJson;
    final fileMerc = await JsonPath().localFileMercadoJson;
    final fileOtrG = await JsonPath().localFileOutrosGastosJson;
    final fileLucro = await JsonPath().localOvoFrangoFileJson;
    final fileGado = await JsonPath().localFileGadoJson;
    final fileOtrV = await JsonPath().localFileOutrasVendasJson;
    final fileSal = await JsonPath().localFileSalarioJson;

    fileDesp.delete();
    fileFarm.delete();
    fileGaso.delete();
    fileMerc.delete();
    fileOtrG.delete();
    fileLucro.delete();
    fileGado.delete();
    fileOtrV.delete();
    fileSal.delete();

    createDataGastos();
    Timer(Duration(milliseconds: 10), ()
    {
      createDataVendas();
    });
  }

  Future resetAllDataGastos() async{
    final fileDesp = await JsonPath().localGAnimaisFileJson;
    final fileFarm = await JsonPath().localFileFarmaciaJson;
    final fileGaso = await JsonPath().localFileGasolinaJson;
    final fileMerc = await JsonPath().localFileMercadoJson;
    final fileOtrG = await JsonPath().localFileOutrosGastosJson;

    fileDesp.delete();
    fileFarm.delete();
    fileGaso.delete();
    fileMerc.delete();
    fileOtrG.delete();
    Timer(Duration(milliseconds: 10), ()
    {
      createDataGastos();
    });
  }

  Future resetAllDataVendas() async{
    final fileLucro = await JsonPath().localOvoFrangoFileJson;
    final fileGado = await JsonPath().localFileGadoJson;
    final fileOtrV = await JsonPath().localFileOutrasVendasJson;
    final fileSal = await JsonPath().localFileSalarioJson;

    fileLucro.delete();
    fileGado.delete();
    fileOtrV.delete();
    fileSal.delete();
    Timer(Duration(milliseconds: 10), ()
    {
      createDataVendas();
    });
  }

  Future resetDataGAnimais() async{
    final fileDesp = await JsonPath().localGAnimaisFileJson;

    fileDesp.delete();

    String despStr = await rootBundle.loadString("assets/Json/Gastos/GastosAnimais/gastosanimais.json");

    final despStrDir = await GetJsonDirectory().getJsonDirectoryGastosAnimais();

    File despFile = File("${despStrDir}despesas_data.json");

    despFile.writeAsStringSync(despStr);
  }

  Future resetDataFGM() async{
    final fileFarm = await JsonPath().localFileFarmaciaJson;
    final fileGaso = await JsonPath().localFileGasolinaJson;
    final fileMerc = await JsonPath().localFileMercadoJson;

    fileFarm.delete();
    fileGaso.delete();
    fileMerc.delete();

    String farmStr = await rootBundle.loadString("assets/Json/Gastos/Farmacia/farmacia.json");
    String gasoStr = await rootBundle.loadString("assets/Json/Gastos/Gasolina/gasolina.json");
    String mercStr = await rootBundle.loadString("assets/Json/Gastos/Mercado/mercado.json");

    final farmStrDir = await GetJsonDirectory().getJsonDirectoryGastosFarmacia();
    final gasoStrDir = await GetJsonDirectory().getJsonDirectoryGastosGasolina();
    final mercStrDir = await GetJsonDirectory().getJsonDirectoryGastosMercado();

    File farmFile = File("${farmStrDir}farmacia_data.json");
    File gasoFile = File("${gasoStrDir}gasolina_data.json");
    File mercFile = File("${mercStrDir}mercado_data.json");

    farmFile.writeAsStringSync(farmStr);
    gasoFile.writeAsStringSync(gasoStr);
    mercFile.writeAsStringSync(mercStr);
  }

  Future resetDataOutrosGastos() async{
    final fileOtrG = await JsonPath().localFileOutrosGastosJson;

    fileOtrG.delete();

    String otrGStr = await rootBundle.loadString("assets/Json/Gastos/OutrosGastos/outrosGastos.json");

    final otrGStrDir = await GetJsonDirectory().getJsonDirectoryGastosOutrosGastos();

    File otrGFile = File("${otrGStrDir}outrosgastos_data.json");

    otrGFile.writeAsStringSync(otrGStr);
  }

  Future resetDataOvosFrangos() async{
    final fileLucro = await JsonPath().localOvoFrangoFileJson;

    fileLucro.delete();

    String lucroStr = await rootBundle.loadString("assets/Json/Vendas/OvosFrango/vendaovofrango.json");

    final lucroStrDir = await GetJsonDirectory().getJsonDirectoryVendasOvoFrango();

    File lucroFile = File("${lucroStrDir}lucro_data.json");

    lucroFile.writeAsStringSync(lucroStr);
  }

  Future resetDataGado() async{
    final fileGado = await JsonPath().localFileGadoJson;

    fileGado.delete();

    String gadoStr = await rootBundle.loadString("assets/Json/Vendas/Gado/gado.json");

    final gadoStrDir = await GetJsonDirectory().getJsonDirectoryVendasGado();

    File gadoFile = File("${gadoStrDir}gado_data.json");

    gadoFile.writeAsStringSync(gadoStr);
  }

  Future resetDataOutrasVendas() async{
    final fileOtrV = await JsonPath().localFileOutrasVendasJson;

    fileOtrV.delete();

    String otrVStr = await rootBundle.loadString("assets/Json/Vendas/OutrasVendas/outrasvendas.json");

    final otrVStrDir = await GetJsonDirectory().getJsonDirectoryVendasOutrasVendas();

    File otrVFile = File("${otrVStrDir}outrasvendas_data.json");

    otrVFile.writeAsStringSync(otrVStr);
  }
}
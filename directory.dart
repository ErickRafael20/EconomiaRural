import 'dart:io';
import 'package:path_provider/path_provider.dart';

class GetJsonDirectory{

  Future<String> getJsonDirectoryGastosAnimais() async{
    final Directory stringPath = await getExternalStorageDirectory();
    final Directory _gastosAnimaisDir = Directory("${stringPath.path}/Json/Gastos/GastosAnimais/");
    final Directory _gastoAnimaisDirNewFolder = await _gastosAnimaisDir.create(recursive: true);
    return _gastoAnimaisDirNewFolder.path;
  }

  Future<String> getJsonDirectoryGastosFarmacia() async{
    final Directory stringPath =  await getExternalStorageDirectory();
    final Directory _gastosFarmaciaDir = Directory("${stringPath.path}/Json/Gastos/Farmacia/");
    final Directory _gastoFarmaciaDirNewFolder = await _gastosFarmaciaDir.create(recursive: true);
    return _gastoFarmaciaDirNewFolder.path;
  }

  Future<String> getJsonDirectoryGastosGasolina() async{
    final Directory stringPath = await getExternalStorageDirectory();
    final Directory _gastosGasolinaDir = Directory("${stringPath.path}/Json/Gastos/Gasolina/");
    final Directory _gastoGasolinaDirNewFolder = await _gastosGasolinaDir.create(recursive: true);
    return _gastoGasolinaDirNewFolder.path;
  }

  Future<String> getJsonDirectoryGastosMercado() async{
    final Directory stringPath = await getExternalStorageDirectory();
    final Directory _gastosMercadoDir = Directory("${stringPath.path}/Json/Gastos/Mercado/");
    final Directory _gastoMercadoDirNewFolder = await _gastosMercadoDir.create(recursive: true);
    return _gastoMercadoDirNewFolder.path;
  }

  Future<String> getJsonDirectoryGastosOutrosGastos() async{
    final Directory stringPath = await getExternalStorageDirectory();
    final Directory _gastosOutrosGastosDir = Directory("${stringPath.path}/Json/Gastos/OutrosGastos/");
    final Directory _gastoOutrosGastosDirNewFolder = await _gastosOutrosGastosDir.create(recursive: true);
    return _gastoOutrosGastosDirNewFolder.path;
  }

  Future<String> getJsonDirectoryVendasOvoFrango() async{
    final Directory stringPath = await getExternalStorageDirectory();
    final Directory _gastosOvosFrangosDir = Directory("${stringPath.path}/Json/Vendas/OvosFrangos/");
    final Directory _gastoOvosFrangosDirNewFolder = await _gastosOvosFrangosDir.create(recursive: true);
    return _gastoOvosFrangosDirNewFolder.path;
  }

  Future<String> getJsonDirectoryVendasGado() async{
    final Directory stringPath = await getExternalStorageDirectory();
    final Directory _gastosGadoDir = Directory("${stringPath.path}/Json/Vendas/Gado/");
    final Directory _gastoGadoDirNewFolder = await _gastosGadoDir.create(recursive: true);
    return _gastoGadoDirNewFolder.path;
  }

  Future<String> getJsonDirectoryVendasOutrasVendas() async{
    final Directory stringPath = await getExternalStorageDirectory();
    final Directory _gastosOutrasVendasDir = Directory("${stringPath.path}/Json/Vendas/OutrasVendas/");
    final Directory _gastoOutrasVendasDirNewFolder = await _gastosOutrasVendasDir.create(recursive: true);
    return _gastoOutrasVendasDirNewFolder.path;
  }

  Future<String> getJsonDirectorySalario() async{
    final Directory stringPath = await getExternalStorageDirectory();
    final Directory _salarioDir = Directory("${stringPath.path}/Json/Salario/");
    final Directory _salarioDirNewFolder = await _salarioDir.create(recursive: true);
    return _salarioDirNewFolder.path;
  }
}
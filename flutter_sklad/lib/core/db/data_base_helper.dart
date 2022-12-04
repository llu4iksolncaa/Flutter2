import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sklad/data/model/arrival.dart';
import 'package:flutter_sklad/data/model/consumption.dart';
import 'package:flutter_sklad/data/model/issuePoint.dart';
import 'package:flutter_sklad/data/model/product.dart';
import 'package:flutter_sklad/data/model/productCategory.dart';
import 'package:flutter_sklad/data/model/provider.dart';
import 'package:flutter_sklad/data/model/stock.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import '../../common/data_base_request.dart';
import '../../data/model/role.dart';
import '../../data/model/user.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DataBaseHelper {
  static final DataBaseHelper instance = DataBaseHelper._instance();

  DataBaseHelper._instance();

  late final Directory _appDocumentDirectory;
  late final String _pathDB;
  late final Database dataBase;
  int _version = 1;

  Future<void> init() async {
    _appDocumentDirectory =
        await path_provider.getApplicationDocumentsDirectory();

    _pathDB = join(_appDocumentDirectory.path, 'booksstore.db');
    if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
      sqfliteFfiInit();
      dataBase = await databaseFactoryFfi.openDatabase(_pathDB,
          options: OpenDatabaseOptions(
              version: _version,
              onCreate: (dataBase, version) async {
                await onCreateTable(dataBase);
              },
              onUpgrade: (dataBase, oldVersion, newVersion) async {
                await onUpdateTable(dataBase);
              }));
    } else {
      dataBase = await openDatabase(_pathDB, version: _version,
          onCreate: (dataBase, version) async {
        await onCreateTable(dataBase);
      }, onUpgrade: (dataBase, oldVersion, newVersion) async {
        await onUpdateTable(dataBase);
      });
    }
  }

  Future<void> onUpdateTable(Database db) async {
    var tables = await db.rawQuery("SELECT name FROM sqlite_master");

    for (var table in DataBaseRequest.tableList.reversed) {
      if (tables.where((element) => element['name'] == table).isNotEmpty) {
        await db.execute(DataBaseRequest.deleteTable(table));
      }
    }

    for (var i = 0; i < DataBaseRequest.tableList.length; i++) {
      await db.execute(DataBaseRequest.createTableList[i]);
    }
    await onInitTable(db);
  }

  Future<void> onCreateTable(Database db) async {
    for (var i = 0; i < DataBaseRequest.tableList.length; i++) {
      await db.execute(DataBaseRequest.createTableList[i]);
    }
    db.execute('PRAGMA foreign_keys=on');
    await onInitTable(db);
  }

  Future<void> onDropDataBase() async {
    dataBase.close();
    if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
      databaseFactoryFfi.deleteDatabase(dataBase.path);
    } else {
      deleteDatabase(_pathDB);
    }
  }


  Future<void> onInitTable(Database db) async {
    try {
      db.insert(DataBaseRequest.tableRole, Role(role: 'Администратор').toMap());
      db.insert(DataBaseRequest.tableRole, Role(role: 'Грузщик').toMap());

      db.insert(DataBaseRequest.tableUsers, User(name: "Ваня", surname: "Пошлый", patronymic: "Краб", login: "riba", password: "17", phoneNumber: "88005553535", email: "pochta@mail.ru", roleId: 1).toMap());

      db.insert(DataBaseRequest.tableProviders, Provider(name: "Имя", address: "Живу тут", phoneNumber: "88005553535").toMap());

      db.insert(DataBaseRequest.tableStocks, Stock(address: "address ul.17").toMap());

      db.insert(DataBaseRequest.tableProductCategories, ProductCategory(name: "Специи", description: "Соль").toMap());

      db.insert(DataBaseRequest.tableProducts, Product(description: "description", price: 20.20, name: "name", exists: 1, productCategoryId: 1, stockId: 1, count: 2, vendor: "vendor").toMap());

      db.insert(DataBaseRequest.tableArrivals, Arrival(date: DateTime.now().toString(), count: 1, providerId: 1, productId: 1).toMap());

      db.insert(DataBaseRequest.tableIssuePoints, IssuePoint(name: "wb", address: "г. Москва ул.Павелецкая 17").toMap());

      db.insert(DataBaseRequest.tableConsumptions, Consumption(date: DateTime.now().toString(), count: 2, productId: 1, userId: 1, issuePointId: 1, status: "В пути").toMap());

    } on DatabaseException catch (e) {
      print(1);
    }
  }
}

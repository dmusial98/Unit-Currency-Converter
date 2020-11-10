import 'dart:async';

import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'UnitMeasureDB.dart';
import 'UnitMeasureDao.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 4, entities: [UnitMeasureDB])
abstract class AppDatabase extends FloorDatabase {
  UnitMeasureDao get unitMeasureDao;
  // UnitTypeDao get unitTypeDao;
}

// @Entity(tableName: 'unit_measure', foreignKeys: [ForeignKey(childColumns: ['unit_measure_type'], parentColumns: ['unit_type_id'], entity: UnitTypeDB)])
// class UnitMeasureDB {
//   @primaryKey
//   int id;
//
//   String name;
//   String abbreviation;
//
//   @ColumnInfo(name: 'unit_measure_type')
//   int type;
//   final Key key;
//
//   UnitMeasureDB(this.id, this.name, this.abbreviation, this.type, this.key);
// }

// @Entity(tableName: 'unit_type', primaryKeys: ['unit_type_id'])
// class UnitTypeDB {
//
//   @ColumnInfo(name: 'unit_type_id')
//   int id;
//
//   String name;
//
//   UnitTypeDB(this.id, this.name);
// }

// @dao
// abstract class UnitMeasureDao {
//
//   @insert
//   Future<void> insertUnitMeasure(UnitMeasureDB unitMeasure);
//
//   @Query('SELECT * FROM UnitMeasureDB')
//   Future<List<UnitMeasureDB>> getAllUnits();
//
//   @Query('SELECT * FROM UnitMeasureDB, UnitTypeDB WHERE UnitMeasureDB.type = UnitTypeDB.id AND UnitTypeDB.name = :unitTypeName')
//   Future<List<UnitMeasureDB>> getUnitsByType(String unitTypeName);
//
// }

// @dao
// abstract class UnitTypeDao {
//
//   @insert
//   Future<void> insertUnitType(UnitTypeDB unitType);
// }


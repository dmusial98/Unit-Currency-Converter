import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'unit_measure_db/unit_measure_db.dart';
import 'unit_measure_db/unit_measure_dao.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 4, entities: [UnitMeasureDB])
abstract class AppDatabase extends FloorDatabase {
  UnitMeasureDao get unitMeasureDao;
  // UnitTypeDao get unitTypeDao;
}



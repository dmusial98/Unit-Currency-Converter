import 'UnitMeasureDB.dart';
import 'package:floor/floor.dart';

@dao
abstract class UnitMeasureDao {

  @insert
  Future<void> insertUnitMeasure(UnitMeasureDB unitMeasure);

  @update
  Future<void> updateUnitMeasure(UnitMeasureDB unitMeasure);

  @delete
  Future<void> deleteUnitMeasure(UnitMeasureDB unitMeasure);

  @Query('SELECT * FROM UnitMeasureDB WHERE id = :id')
  Future<UnitMeasureDB> findUnitMeasureById(int id);
  
  @Query('SELECT * FROM UnitMeasureDB')
  Future<List<UnitMeasureDB>> getAllUnits();

  @Query('SELECT * FROM task')
  Stream<List<UnitMeasureDB>> findAllUnitsAsStream();

  @Query('SELECT * FROM UnitMeasureDB WHERE UnitMeasureDB.type = :unitType')
  Future<List<UnitMeasureDB>> getUnitsByType(int unitType);

  // @Query('SELECT * FROM UnitMeasureDB WHERE UnitMeasureDB.type = :unitType')
  // Future<List<UnitMeasureDB>> getUnitsByType(int unitType);

}
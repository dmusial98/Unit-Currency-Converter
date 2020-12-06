import 'unit_type_db.dart';
import 'package:floor/floor.dart';

@dao
abstract class UnitTypeDao {

  @insert
  Future<void> insertUnitType(UnitTypeDB unitType);

  @update
  Future<void> updateUnitType(UnitTypeDB unitType);

  @delete
  Future<void> deleteUnitType(UnitTypeDB unitType);

  @Query('SELECT * FROM UnitTypeDB WHERE id = :id')
  Future<UnitTypeDB> findUnitTypeById(int id);

  @Query('SELECT * FROM UnitTypeDB')
  Future<List<UnitTypeDB>> getAllUnitTypes();

  @Query('SELECT * FROM UnitTypeDB')
  Stream<List<UnitTypeDB>> findAllUnitTypesAsStream();
}
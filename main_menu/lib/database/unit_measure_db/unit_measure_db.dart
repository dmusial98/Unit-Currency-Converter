import 'package:floor/floor.dart';
import 'package:main_menu/database/unit_type_db/unit_type_db.dart';

@Entity(
    foreignKeys: [
      ForeignKey(
         childColumns: ['type'],
         parentColumns: ['id'],
         entity: UnitTypeDB
      )
    ]
)

class UnitMeasureDB {

  @PrimaryKey(autoGenerate: true)
  int id;

  String name;
  String abbreviation;
  String equation;

  // @ColumnInfo(name: 'unit_measure_type')
  int type;
  int baseUnitType;
  double lastComputedValue;
  // final Key key;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is UnitMeasureDB &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              name == other.name &&
              abbreviation == other.abbreviation &&
              type == other.type &&
              baseUnitType == other.baseUnitType &&
              equation == other.equation &&
              lastComputedValue == other.lastComputedValue;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ abbreviation.hashCode ^ type.hashCode ^ baseUnitType.hashCode ^ equation.hashCode ^ lastComputedValue.hashCode;

  @override
  String toString() {
    return 'UnitMeasureDB{id: $id, name: $name abbreviation: $abbreviation type: $type baseUnitType $baseUnitType equation: $equation lastComputedValue: $lastComputedValue}';
  }

  UnitMeasureDB(this.id, this.name, this.abbreviation, this.type, this.equation, this.baseUnitType, this.lastComputedValue);
}
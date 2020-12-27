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
  String equationReversed;

  // @ColumnInfo(name: 'unit_measure_type')
  int type;
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
              equation == other.equation &&
              equationReversed == other.equationReversed &&
              lastComputedValue == other.lastComputedValue;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ abbreviation.hashCode ^ type.hashCode ^ equation.hashCode ^ equationReversed.hashCode ^ lastComputedValue.hashCode;

  @override
  String toString() {
    return 'UnitMeasureDB{id: $id, name: $name abbreviation: $abbreviation type: $type equation: $equation equationReversed: $equationReversed lastComputedValue: $lastComputedValue}';
  }

  UnitMeasureDB(this.id, this.name, this.abbreviation, this.type, this.equation, this.equationReversed, this.lastComputedValue);
}
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

  // @ColumnInfo(name: 'unit_measure_type')
  int type;
  int countedValue;
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
              countedValue == other.countedValue;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ abbreviation.hashCode ^ type.hashCode ^ countedValue.hashCode;

  @override
  String toString() {
    return 'UnitMeasureDB{id: $id, name: $name abbreviation: $abbreviation type: $type countedValue $countedValue}';
  }

  UnitMeasureDB(this.id, this.name, this.abbreviation, this.type, this.countedValue);
}
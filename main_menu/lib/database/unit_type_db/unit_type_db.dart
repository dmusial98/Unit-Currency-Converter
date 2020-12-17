import 'package:floor/floor.dart';

@entity
class UnitTypeDB {
  @PrimaryKey(autoGenerate: true)
  int id;
  String name;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is UnitTypeDB &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  @override
  String toString() {
    return 'UnitTypeDB{id: $id, name: $name}';
  }

  UnitTypeDB(this.id, this.name);
}
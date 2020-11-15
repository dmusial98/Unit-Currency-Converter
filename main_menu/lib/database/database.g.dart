part of 'database.dart';

class $FloorFlutterDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$FlutterDatabaseBuilder databaseBuilder(String name) =>
      _$FlutterDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$FlutterDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$FlutterDatabaseBuilder(null);
}

class _$FlutterDatabaseBuilder {
  _$FlutterDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$FlutterDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$FlutterDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$FlutterDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$FlutterDatabase extends AppDatabase {
  _$FlutterDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  UnitMeasureDao _unitMeasureDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `UnitMeasureDB` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT, `abbreviation` TEXT, `type` INTEGER)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  UnitMeasureDao get unitMeasureDao {
    return _unitMeasureDaoInstance ??= _$UnitMeasureDao(database, changeListener);
  }
}

class _$UnitMeasureDao extends UnitMeasureDao {
  _$UnitMeasureDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _taskInsertionAdapter = InsertionAdapter(
            database,
            'UnitMeasureDB',
                (UnitMeasureDB item) =>
            <String, dynamic>{'id': item.id, 'name': item.name, 'abbreviation': item.abbreviation, 'type': item.type},
            changeListener),
        _taskUpdateAdapter = UpdateAdapter(
            database,
            'UnitMeasureDB',
            ['id'],
                (UnitMeasureDB item) =>
            <String, dynamic>{'id': item.id, 'name': item.name, 'abbreviation': item.abbreviation, 'type': item.type},
            changeListener),
        _taskDeletionAdapter = DeletionAdapter(
            database,
            'UnitMeasureDB',
            ['id'],
                (UnitMeasureDB item) =>
            <String, dynamic>{'id': item.id, 'name': item.name, 'abbreviation': item.abbreviation, 'type': item.type},
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<UnitMeasureDB> _taskInsertionAdapter;

  final UpdateAdapter<UnitMeasureDB> _taskUpdateAdapter;

  final DeletionAdapter<UnitMeasureDB> _taskDeletionAdapter;

  @override
  Future<UnitMeasureDB> findUnitMeasureById(int id) async {
    return _queryAdapter.query('SELECT * FROM UnitMeasureDB WHERE id = ?',
        arguments: <dynamic>[id],
        mapper: (Map<String, dynamic> row) =>
            UnitMeasureDB(row['id'] as int, row['name'] as String, row['abbreviation'] as String, row['type'] as int));
  }

  @override
  Future<List<UnitMeasureDB>> getUnitsByType(int type) async {
    return _queryAdapter.queryList('SELECT * FROM UnitMeasureDB WHERE type = ?',
        arguments: <dynamic>[type],
        mapper: (Map<String, dynamic> row) =>
            UnitMeasureDB(row['id'] as int, row['name'] as String, row['abbreviation'] as String, row['type'] as int));
  }

  @override
  Future<List<UnitMeasureDB>> getAllUnits() async {
    return _queryAdapter.queryList('SELECT * FROM UnitMeasureDB',
        mapper: (Map<String, dynamic> row) =>
            UnitMeasureDB(row['id'] as int, row['name'] as String, row['abbreviation'] as String, row['type'] as int));
  }

  @override
  Stream<List<UnitMeasureDB>> findAllUnitsAsStream() {
    return _queryAdapter.queryListStream('SELECT * FROM UnitMeasureDB',
        queryableName: 'UnitMeasureDB',
        isView: false,
        mapper: (Map<String, dynamic> row) =>
            UnitMeasureDB(row['id'] as int, row['name'] as String, row['abbreviation'] as String, row['type'] as int));
  }


  // @override
  // Stream<List<UnitMeasureDB>> findAllTasksAsStream() {
  //   return _queryAdapter.queryListStream('SELECT * FROM task',
  //       queryableName: 'Task',
  //       isView: false,
  //       mapper: (Map<String, dynamic> row) =>
  //           UnitMeasureDB(row['id'] as int, row['name'] as String, row['abbreviation'] as String, row['type'] as int, row['key'] as Key));
  // }

  @override
  Future<void> insertUnitMeasure(UnitMeasureDB unitMeasure) async {
    await _taskInsertionAdapter.insert(unitMeasure, OnConflictStrategy.abort);
  }

  // @override
  // Future<void> insertTasks(List<Task> tasks) async {
  //   await _taskInsertionAdapter.insertList(tasks, OnConflictStrategy.abort);
  // }

  @override
  Future<void> updateUnitMeasure(UnitMeasureDB unitMeasure) async {
    await _taskUpdateAdapter.update(unitMeasure, OnConflictStrategy.abort);
  }

  // @override
  // Future<void> updateTasks(List<Task> task) async {
  //   await _taskUpdateAdapter.updateList(task, OnConflictStrategy.abort);
  // }

  @override
  Future<void> deleteUnitMeasure(UnitMeasureDB unitMeasure) async {
    await _taskDeletionAdapter.delete(unitMeasure);
  }

  // @override
  // Future<void> deleteTasks(List<Task> tasks) async {
  //   await _taskDeletionAdapter.deleteList(tasks);
  // }
}
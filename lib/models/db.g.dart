// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  CaloriesDao? _caloriesDaoInstance;

  StepsDao? _stepsDaoInstance;

  DistanceDao? _distanceDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
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
            'CREATE TABLE IF NOT EXISTS `Calories` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `value` REAL NOT NULL, `dateTime` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Steps` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `value` REAL NOT NULL, `dateTime` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Distance` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `value` REAL NOT NULL, `dateTime` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  CaloriesDao get caloriesDao {
    return _caloriesDaoInstance ??= _$CaloriesDao(database, changeListener);
  }

  @override
  StepsDao get stepsDao {
    return _stepsDaoInstance ??= _$StepsDao(database, changeListener);
  }

  @override
  DistanceDao get distanceDao {
    return _distanceDaoInstance ??= _$DistanceDao(database, changeListener);
  }
}

class _$CaloriesDao extends CaloriesDao {
  _$CaloriesDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _caloriesInsertionAdapter = InsertionAdapter(
            database,
            'Calories',
            (Calories item) => <String, Object?>{
                  'id': item.id,
                  'value': item.value,
                  'dateTime': _dateTimeConverter.encode(item.dateTime)
                }),
        _caloriesUpdateAdapter = UpdateAdapter(
            database,
            'Calories',
            ['id'],
            (Calories item) => <String, Object?>{
                  'id': item.id,
                  'value': item.value,
                  'dateTime': _dateTimeConverter.encode(item.dateTime)
                }),
        _caloriesDeletionAdapter = DeletionAdapter(
            database,
            'Calories',
            ['id'],
            (Calories item) => <String, Object?>{
                  'id': item.id,
                  'value': item.value,
                  'dateTime': _dateTimeConverter.encode(item.dateTime)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Calories> _caloriesInsertionAdapter;

  final UpdateAdapter<Calories> _caloriesUpdateAdapter;

  final DeletionAdapter<Calories> _caloriesDeletionAdapter;

  @override
  Future<List<Calories>> findCaloriesbyTime(
    DateTime startTime,
    DateTime endTime,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Calories WHERE dateTime between ?1 and ?2 ORDER BY dateTime ASC',
        mapper: (Map<String, Object?> row) => Calories(row['id'] as int?, row['value'] as double, _dateTimeConverter.decode(row['dateTime'] as int)),
        arguments: [
          _dateTimeConverter.encode(startTime),
          _dateTimeConverter.encode(endTime)
        ]);
  }

  @override
  Future<List<Calories>> findAllCalories() async {
    return _queryAdapter.queryList('SELECT * FROM Calories',
        mapper: (Map<String, Object?> row) => Calories(
            row['id'] as int?,
            row['value'] as double,
            _dateTimeConverter.decode(row['dateTime'] as int)));
  }

  @override
  Future<Calories?> findFirstDayInDb() async {
    return _queryAdapter.query(
        'SELECT * FROM Calories ORDER BY dateTime ASC LIMIT 1',
        mapper: (Map<String, Object?> row) => Calories(
            row['id'] as int?,
            row['value'] as double,
            _dateTimeConverter.decode(row['dateTime'] as int)));
  }

  @override
  Future<Calories?> findLastDayInDb() async {
    return _queryAdapter.query(
        'SELECT * FROM Calories ORDER BY dateTime DESC LIMIT 1',
        mapper: (Map<String, Object?> row) => Calories(
            row['id'] as int?,
            row['value'] as double,
            _dateTimeConverter.decode(row['dateTime'] as int)));
  }

  @override
  Future<void> insertCalories(Calories calories) async {
    await _caloriesInsertionAdapter.insert(calories, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateCalories(Calories calories) async {
    await _caloriesUpdateAdapter.update(calories, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteCalories(Calories calories) async {
    await _caloriesDeletionAdapter.delete(calories);
  }
}

class _$StepsDao extends StepsDao {
  _$StepsDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _stepsInsertionAdapter = InsertionAdapter(
            database,
            'Steps',
            (Steps item) => <String, Object?>{
                  'id': item.id,
                  'value': item.value,
                  'dateTime': _dateTimeConverter.encode(item.dateTime)
                }),
        _stepsUpdateAdapter = UpdateAdapter(
            database,
            'Steps',
            ['id'],
            (Steps item) => <String, Object?>{
                  'id': item.id,
                  'value': item.value,
                  'dateTime': _dateTimeConverter.encode(item.dateTime)
                }),
        _stepsDeletionAdapter = DeletionAdapter(
            database,
            'Steps',
            ['id'],
            (Steps item) => <String, Object?>{
                  'id': item.id,
                  'value': item.value,
                  'dateTime': _dateTimeConverter.encode(item.dateTime)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Steps> _stepsInsertionAdapter;

  final UpdateAdapter<Steps> _stepsUpdateAdapter;

  final DeletionAdapter<Steps> _stepsDeletionAdapter;

  @override
  Future<List<Steps>> findStepsbyTime(
    DateTime startTime,
    DateTime endTime,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Steps WHERE dateTime between ?1 and ?2 ORDER BY dateTime ASC',
        mapper: (Map<String, Object?> row) => Steps(row['id'] as int?, row['value'] as double, _dateTimeConverter.decode(row['dateTime'] as int)),
        arguments: [
          _dateTimeConverter.encode(startTime),
          _dateTimeConverter.encode(endTime)
        ]);
  }

  @override
  Future<List<Steps>> findAllSteps() async {
    return _queryAdapter.queryList('SELECT * FROM Steps',
        mapper: (Map<String, Object?> row) => Steps(
            row['id'] as int?,
            row['value'] as double,
            _dateTimeConverter.decode(row['dateTime'] as int)));
  }

  @override
  Future<Steps?> findFirstDayInDb() async {
    return _queryAdapter.query(
        'SELECT * FROM Steps ORDER BY dateTime ASC LIMIT 1',
        mapper: (Map<String, Object?> row) => Steps(
            row['id'] as int?,
            row['value'] as double,
            _dateTimeConverter.decode(row['dateTime'] as int)));
  }

  @override
  Future<Steps?> findLastDayInDb() async {
    return _queryAdapter.query(
        'SELECT * FROM Steps ORDER BY dateTime DESC LIMIT 1',
        mapper: (Map<String, Object?> row) => Steps(
            row['id'] as int?,
            row['value'] as double,
            _dateTimeConverter.decode(row['dateTime'] as int)));
  }

  @override
  Future<void> insertSteps(Steps steps) async {
    await _stepsInsertionAdapter.insert(steps, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateSteps(Steps steps) async {
    await _stepsUpdateAdapter.update(steps, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteSteps(Steps steps) async {
    await _stepsDeletionAdapter.delete(steps);
  }
}

class _$DistanceDao extends DistanceDao {
  _$DistanceDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _distanceInsertionAdapter = InsertionAdapter(
            database,
            'Distance',
            (Distance item) => <String, Object?>{
                  'id': item.id,
                  'value': item.value,
                  'dateTime': _dateTimeConverter.encode(item.dateTime)
                }),
        _distanceUpdateAdapter = UpdateAdapter(
            database,
            'Distance',
            ['id'],
            (Distance item) => <String, Object?>{
                  'id': item.id,
                  'value': item.value,
                  'dateTime': _dateTimeConverter.encode(item.dateTime)
                }),
        _distanceDeletionAdapter = DeletionAdapter(
            database,
            'Distance',
            ['id'],
            (Distance item) => <String, Object?>{
                  'id': item.id,
                  'value': item.value,
                  'dateTime': _dateTimeConverter.encode(item.dateTime)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Distance> _distanceInsertionAdapter;

  final UpdateAdapter<Distance> _distanceUpdateAdapter;

  final DeletionAdapter<Distance> _distanceDeletionAdapter;

  @override
  Future<List<Distance>> findDistancebyTime(
    DateTime startTime,
    DateTime endTime,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Distance WHERE dateTime between ?1 and ?2 ORDER BY dateTime ASC',
        mapper: (Map<String, Object?> row) => Distance(row['id'] as int?, row['value'] as double, _dateTimeConverter.decode(row['dateTime'] as int)),
        arguments: [
          _dateTimeConverter.encode(startTime),
          _dateTimeConverter.encode(endTime)
        ]);
  }

  @override
  Future<List<Distance>> findAllDistance() async {
    return _queryAdapter.queryList('SELECT * FROM Distance',
        mapper: (Map<String, Object?> row) => Distance(
            row['id'] as int?,
            row['value'] as double,
            _dateTimeConverter.decode(row['dateTime'] as int)));
  }

  @override
  Future<Distance?> findFirstDayInDb() async {
    return _queryAdapter.query(
        'SELECT * FROM Distance ORDER BY dateTime ASC LIMIT 1',
        mapper: (Map<String, Object?> row) => Distance(
            row['id'] as int?,
            row['value'] as double,
            _dateTimeConverter.decode(row['dateTime'] as int)));
  }

  @override
  Future<Distance?> findLastDayInDb() async {
    return _queryAdapter.query(
        'SELECT * FROM Distance ORDER BY dateTime DESC LIMIT 1',
        mapper: (Map<String, Object?> row) => Distance(
            row['id'] as int?,
            row['value'] as double,
            _dateTimeConverter.decode(row['dateTime'] as int)));
  }

  @override
  Future<void> insertDistance(Distance distance) async {
    await _distanceInsertionAdapter.insert(distance, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateDistance(Distance distance) async {
    await _distanceUpdateAdapter.update(distance, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteDistance(Distance distance) async {
    await _distanceDeletionAdapter.delete(distance);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();

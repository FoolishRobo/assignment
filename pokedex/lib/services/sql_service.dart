import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pokedex/models/pokemon_model.dart';
import 'package:sqflite/sqflite.dart';

class SqlService {
  static Database? _database;
  static String dbName = 'pokedex.db';
  static int dbVersion = 1;
  static String tableName = 'favourite';

  SqlService._();

  static final SqlService instance = SqlService._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDb();
    return _database!;
  }

  Future initDb() async {
    final dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, dbName);
    return await openDatabase(
      path,
      version: dbVersion,
      onCreate: onCreate,
    );
  }

  Future onCreate(Database database, int version) async {
    await database.execute('''
        CREATE TABLE $tableName(
            id INTEGER,
            title TEXT,
            subtitle TEXT,
            image TEXT,
            PRIMARY KEY (id)
        )
    ''');
  }

  Future<List<PokemonModel>> queryAll() async {
    Database db = await instance.database;
    final pokemons = await db.query(tableName);
    return pokemons.map((pokemon) => PokemonModel.fromJson(pokemon)).toList();
  }

  Future<int> insert(PokemonModel pokemon) async {
    Database db = await instance.database;
    return await db.insert(
      tableName,
      pokemon.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> update(PokemonModel pokemon) async {
    Database db = await instance.database;
    return await db.update(
      tableName,
      pokemon.toJson(),
      where: 'id = ?',
      whereArgs: pokemon.toJson()['id'],
    );
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    Database db = await instance.database;
    return await db.close();
  }
}

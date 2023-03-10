import 'dart:async';
import 'package:hangman/components/user_scores.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';



class ScoresDatabase {
  static Database? _database;
  ScoresDatabase._init();
  static final ScoresDatabase instance=ScoresDatabase._init();
  Future<Database> get database async{
    if(_database!=null) return _database!;
    _database = await openDB();
    return _database!;
  }
}
//
Future<Database> openDB() async{
  final database=openDatabase(join(await getDatabasesPath(), 'scores_database.db'),
  onCreate: (db,version){
    return db.execute("CREATE TABLE scores(id INTEGER PRIMARY KEY AUTOINCREMENT, scoreDate TEXT, userScore INTEGER )");
  },
  version: 1,
  );
return database;

}
// Future<Database> openDB() async{
//   final dbPath = await getDatabasesPath();
//   final path = join(dbPath, 'scores_database.db');
//       return await openDatabase(path, version: 1, onCreate: _createDB);
// }
// Future _createDB(Database db, int version) async {
//  await db.execute("CREATE TABLE scores(id INTEGER PRIMARY KEY AUTOINCREMENT, scoreDate TEXT NOT NULL, userScore INTEGER NOT NULL )");
// }

Future<void> insertScore(Scores scores, final database) async {
  final Database db = await database;

  await db.insert(
    'scores',
    scores.toMap(),
    conflictAlgorithm: ConflictAlgorithm.ignore,
  );
}
Future<List<Scores>> scores(final database) async {
  final Database db = await database;
  final List<Map<String, dynamic>> maps = await db.query('scores');
  return List.generate(maps.length, (i) {
    return Scores(id: maps[i]['id'],
      scoreDate: maps[i]['scoreDate'],
      userScore: maps[i]['userScore'],
    );
  });
}
Future<void> updateScore(Scores scores, final database) async {
  // Get a reference to the database.
  final db = await database;

  // Update the given Dog.
  await db.update(
    'scores',
    scores.toMap(),
    // Ensure that the Dog has a matching id.
    where: "id = ?",
    // Pass the Dog's id as a whereArg to prevent SQL injection.
    whereArgs: [scores.id],
  );
}

Future<void> deleteScore(int id, final database) async {
  // Get a reference to the database.
  final db = await database;

  // Remove the Dog from the database.
  await db.delete(
    'scores',
    // Use a `where` clause to delete a specific dog.
    where: "id = ?",
    // Pass the Dog's id as a whereArg to prevent SQL injection.
    whereArgs: [id],
  );
}

void manipulateDatabase(Scores scoreObject, final database) async {
  await insertScore(scoreObject, database);
  print(await scores(database));
}




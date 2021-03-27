import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'WorkData.dart';

class LocalDBContainer
{
  Database localdb;

  Future<void> init() async
  {
    localdb = await openDatabase(
      join(await getDatabasesPath(), 'local_database.db'),
      onCreate: (db, version) async {
        await db.execute("DROP TABLE IF EXISTS workData");
        return db.execute(
          '''CREATE TABLE workData(
              isClockIn INTEGER, userId INTEGER, clientId INTEGER, 
              clientPass INTEGER, time REAL, latitude REAL, longitude REAL, 
              tasks TEXT, isAuthenticated INTEGER)''',
        );
      },
      version: 1,
    );
  }
  
  Future<void> insert(WorkData workData) async 
  {
    await localdb.insert(
      'workData',
      workData.stringObjMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

}
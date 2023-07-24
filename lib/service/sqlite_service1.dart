import 'dart:io';
import 'dart:typed_data';

import 'package:c_sok/database/groupe.dart';
import 'package:c_sok/database/proclamateur.dart';
import 'package:c_sok/database/user.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteService {

  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    var path_db = join(path, 'database.db');

    //  Vérifier si la base de donnée existe ou pas
    var exists = await databaseExists(path_db);
    if (!exists) {
      //  Va s'exécuter si c'est la première fois que l'application s'ouvre
      print("Création de la base de données.");

      //Vérifier l'existence réel de la base de donnée :
      try {
        await Directory(dirname(path_db)).create(recursive: true);
      } catch (_) {}

      //  Copie des données venant d'asset
      ByteData data = await rootBundle.load(join("lib/assets", "database.db"));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      //  Écrit et vide les octets écrits
      await File(path_db).writeAsBytes(bytes, flush: true);
    } else {
      print("Ouverture de la base de donnée existante.");
    }

    return openDatabase(
        join(path, 'database.db'),
      onCreate: (database, version) async {
          await database.execute(
            "CREATE table users ("
                "id integer primary key autoincrement,"
                "name text not null, "
                "image text nullable, "
                "email text not null,"
                "password text not null"
            ")"
          );

          await database.execute(
              "create table groupes ("
                  "id integer primary key autoincrement,"
                  "lieu text not null,"
                  "nom_gpe text not null,"
                  "created_at text not null)"
          );

          await database.execute(
            "create table proclamateurs ("
                "id integer primary key,"
                "nom text not null,"
                "prenom text not null,"
                "tel text nullable,"
                "email text nullable,"
                "adresse text not null,"
                "date_naiss text not null,"
                "groupe integer not null"
            ")"
          );

          await database.execute(
            "create table rapports ("
                "id integer primary key,"
                "publ integer not null,"
                "videos integer not null,"
                "nbre_heure integer not null,"
                "nvle_visite integer not null,"
                "cours_bibl integer not null,"
                "proclamateur integer not null"
            ")"
          );
      },
      version: 1,
    );
  }

  Future<void> insertUser(User user) async {
    final data = await initializeDB();
    await data.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //  List User
  Future<List<User>> users() async {
    final db = await initializeDB();
    final List<Map<String, dynamic>> maps = await db.query("users");

    //Conversion de liste simple en liste de users.
    return List.generate(maps.length, (i) {
      return User(
          id: maps[i]['id'],
          name: maps[i]['name'],
          image: maps[i]['image'],
          email: maps[i]['email'],
          password: maps[i]['password']
      );
    });
  }

  // Mise à jour du user
  Future<void> updateUser(User user) async {
    final db = await initializeDB();
    // Update the given User.
    await db.update(
      'users',
      user.toMap(),
      // Ensure that the user has a matching id.
      where: 'id = ?',
      // Pass the User's id as a whereArg to prevent SQL injection.
      whereArgs: [user.id],
    );
  }

  //  Delete user
  Future<void> deleteUser(int id) async {
    final db = await initializeDB();
    // Remove the User from the database.
    await db.delete(
      'users',
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the User's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }


  // Groupe : création
  Future<void> insertGroupe(Groupe groupe) async {
    final data = await initializeDB();
    await data.insert(
      'groupes',
      groupe.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  //  Groupe : Liste
  Future<List<Groupe>> groupes() async {
    final db = await initializeDB();
    final List<Map<String, dynamic>> maps = await db.query("groupes");

    //Conversion de liste simple en liste de groupe.
    return List.generate(maps.length, (i) {
      return Groupe(
          id: maps[i]['id'],
          lieu: maps[i]['lieu'],
          nom_gpe: maps[i]['nom_gpe'],
          created_at: maps[i]['created_at']
      );
    });
  }

  // Mise à jour du Groupe
  Future<void> updateGroupe(Groupe groupe) async {
    final db = await initializeDB();
    // Update the given User.
    await db.update(
      'groupes',
      groupe.toMap(),
      // Ensure that the user has a matching id.
      where: 'id = ?',
      // Pass the groupe id as a whereArg to prevent SQL injection.
      whereArgs: [groupe.id],
    );
  }

  //  Delete groupe
  Future<void> deleteGroupe(int id) async {
    final db = await initializeDB();
    // Remove the User from the database.
    await db.delete(
      'groupes',
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the groupes id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }


  // Proc : création
  Future<void> insertProc(Proclamateur proc) async {
    final data = await initializeDB();
    await data.insert(
      'proclamateurs',
      proc.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  //  Proc : Liste
  Future<List<Proclamateur>> proclamateurs() async {
    final db = await initializeDB();
    final List<Map<String, dynamic>> maps = await db.query("proclamateurs");

    //Conversion de liste simple en liste de proclamateur.
    return List.generate(maps.length, (i) {
      return Proclamateur(
          id: maps[i]['id'],
          nom: maps[i]['nom'],
          prenom: maps[i]['prenom'],
          tel: maps[i]['tel'],
          email: maps[i]['email'],
          adresse: maps[i]['adresse'],
          date_naiss: maps[i]['date_naiss'],
          groupe: maps[i]['groupe']
      );
    });
  }

  // Mise à jour du Proc
  Future<void> updateProc(Proclamateur proc) async {
    final db = await initializeDB();
    // Update the given User.
    await db.update(
      'proclamateurs',
      proc.toMap(),
      // Ensure that the user has a matching id.
      where: 'id = ?',
      // Pass the proclamateur id as a whereArg to prevent SQL injection.
      whereArgs: [proc.id],
    );
  }

  //  Delete Proc
  Future<void> deleteProc(int id) async {
    final db = await initializeDB();
    // Remove the User from the database.
    await db.delete(
      'proclamateurs',
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the proclamateur id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }
}
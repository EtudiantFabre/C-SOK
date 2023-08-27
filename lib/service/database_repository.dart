import 'package:c_sok/constante.dart';
import 'package:c_sok/models/model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseRepository {
  static final DatabaseRepository instance = DatabaseRepository._init();
  DatabaseRepository._init();

  Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('csok.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    print(dbPath);
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      create table ${UserConst.tableName} ( 
        ${UserConst.id} integer primary key autoincrement, 
        ${UserConst.name} text not null,
        ${UserConst.email} text nullable,
        ${UserConst.image} text nullable,
        ${UserConst.password} text not null)
    ''');

    await db.execute('''
      create table ${TypeConst.tableName} ( 
        ${TypeConst.id} integer primary key autoincrement, 
        ${TypeConst.name} text not null)
    ''');

    await db.execute('''
      create table ${GroupeConst.tableName} ( 
        ${GroupeConst.id} integer primary key autoincrement, 
        ${GroupeConst.lieu} text not null,
        ${GroupeConst.nom_gpe} text not null,
        ${GroupeConst.created_at} text not null)
    ''');

    await db.execute('''
      create table ${ProclamateurConst.tableName} ( 
        ${ProclamateurConst.id} integer primary key autoincrement, 
        ${ProclamateurConst.nom} text not null,
        ${ProclamateurConst.prenom} text not null,
        ${ProclamateurConst.tel} text not null,
        ${ProclamateurConst.email} text nullable,
        ${ProclamateurConst.adresse} text not null,
        ${ProclamateurConst.date_naiss} text not null,
        ${ProclamateurConst.groupe} integer nullable,
        ${ProclamateurConst.type} integer nullable)
    ''');

    await db.execute('''
      create table ${RapportConst.tableName} ( 
        ${RapportConst.id} integer primary key autoincrement, 
        ${RapportConst.publ} text not null,
        ${RapportConst.videos} text not null,
        ${RapportConst.nbre_heure} text not null,
        ${RapportConst.nvle_visite} text not null,
        ${RapportConst.cours_bibl} text not null,
        ${RapportConst.created_at} text not null,
        ${RapportConst.proclamateur} integer not null)
    ''');
  }

  Future<void> insertGroupe({required GroupeModel groupe}) async {
    try {
      final db = await instance.database;
      await db.insert(GroupeConst.tableName, groupe.toMap());
      print('groupeAdded');
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<GroupeModel>> getAllGroupes() async {
    final db = await instance.database;

    final result = await db.query(GroupeConst.tableName);

    return result.map((json) => GroupeModel.fromJson(json)).toList();
  }

  Future<void> deleteGroupe(int id) async {
    try {
      final db = await instance.database;
      await db.delete(
        GroupeConst.tableName,
        where: '${GroupeConst.id} = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateGroupe(GroupeModel groupe) async {
    try {
      final db = await instance.database;
      db.update(
        GroupeConst.tableName,
        groupe.toMap(),
        where: '${GroupeConst.id} = ?',
        whereArgs: [groupe.id],
      );
    } catch (e) {
      print(e.toString());
    }
  }

  //  Proclamateur
  Future<void> insertProc({required ProclamateurModel proc}) async {
    try {
      final db = await instance.database;
      await db.insert(ProclamateurConst.tableName, proc.toMap());
      print('ProclamateurAdded');
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<ProclamateurModel>> getAllProc() async {
    final db = await instance.database;

    final result = await db.query(ProclamateurConst.tableName);

    return result.map((json) => ProclamateurModel.fromJson(json)).toList();
  }

  Future<void> deleteProc(int id) async {
    try {
      final db = await instance.database;
      await db.delete(
        ProclamateurConst.tableName,
        where: '${ProclamateurConst.id} = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future<ProclamateurModel?> getProcById(int id) async {
    ProclamateurModel? proclamateur;
    try {
      final db = await instance.database;
      final List<Map<String, dynamic>> maps = await db.query(
        ProclamateurConst.tableName,
        where: '${ProclamateurConst.id} = ?',
        whereArgs: [id],
      );
      if (maps.isNotEmpty) {
        // Vous pouvez supposer ici que l'id est unique et renvoyer le premier élément de la liste
        proclamateur = ProclamateurModel.fromJson(maps.first);
      }
    } catch (e) {
      print(e.toString());
    }
    return proclamateur;
  }

  Future<ProclamateurModel?> getProclamateurById(int id) async {
    ProclamateurModel? proclamateur;
    try {
      proclamateur = await DatabaseRepository.instance.getProcById(id);
    } catch (e) {
      print("Erreur lors de la récupération du proclamateur : $e");
    }

    return proclamateur;
  }

  Future<void> updateProc(ProclamateurModel proc) async {
    try {
      final db = await instance.database;
      db.update(
        ProclamateurConst.tableName,
        proc.toMap(),
        where: '${ProclamateurConst.id} = ?',
        whereArgs: [proc.id],
      );
    } catch (e) {
      print(e.toString());
    }
  }

  //  User
  Future<void> insertUser({required UserModel user}) async {
    try {
      final db = await instance.database;
      await db.insert(UserConst.tableName, user.toMap());
      print('UserAdded');
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<UserModel>> getAllUsers() async {
    final db = await instance.database;

    final result = await db.query(UserConst.tableName);

    return result.map((json) => UserModel.fromJson(json)).toList();
  }

  Future<void> deleteUser(int id) async {
    try {
      final db = await instance.database;
      await db.delete(
        UserConst.tableName,
        where: '${UserConst.id} = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateUser(UserModel user) async {
    try {
      final db = await instance.database;
      db.update(
        UserConst.tableName,
        user.toMap(),
        where: '${UserConst.id} = ?',
        whereArgs: [user.id],
      );
    } catch (e) {
      print(e.toString());
    }
  }

  //  Rapport
  Future<void> insertRapport({required RapportModel rapport}) async {
    try {
      final db = await instance.database;
      await db.insert(RapportConst.tableName, rapport.toMap());
      print('RapportAdded');
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<RapportModel>> getAllRapports() async {
    final db = await instance.database;

    final result = await db.query(RapportConst.tableName);

    return result.map((json) => RapportModel.fromJson(json)).toList();
  }

  Future<void> deleteRapport(int id) async {
    try {
      final db = await instance.database;
      await db.delete(
        RapportConst.tableName,
        where: '${RapportConst.id} = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateRapport(RapportModel rapport) async {
    try {
      final db = await instance.database;
      db.update(
        RapportConst.tableName,
        rapport.toMap(),
        where: '${RapportConst.id} = ?',
        whereArgs: [rapport.id],
      );
    } catch (e) {
      print(e.toString());
    }
  }

  //  Type de frère
  Future<void> insertType({required TypeModel type}) async {
    try {
      final db = await instance.database;
      await db.insert(TypeConst.tableName, type.toMap());
      print('TypeAdded');
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<TypeModel>> getAllTypes() async {
    final db = await instance.database;

    final result = await db.query(TypeConst.tableName);

    return result.map((json) => TypeModel.fromJson(json)).toList();
  }

  Future<void> deleteType(int id) async {
    try {
      final db = await instance.database;
      await db.delete(
        TypeConst.tableName,
        where: '${TypeConst.id} = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateType(TypeModel type) async {
    try {
      final db = await instance.database;
      db.update(
        TypeConst.tableName,
        type.toMap(),
        where: '${TypeConst.id} = ?',
        whereArgs: [type.id],
      );
    } catch (e) {
      print(e.toString());
    }
  }
}

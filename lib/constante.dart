import 'package:flutter/material.dart';

TextButton kTextButton(String label, Function onPressed) {
  return TextButton(
    onPressed: () => onPressed(),
    child: Text(
      label,
      style: TextStyle(color: Colors.white),
    ),
    style: ButtonStyle(
        backgroundColor:
            MaterialStateColor.resolveWith((states) => Colors.blue),
        padding:
            MaterialStateProperty.resolveWith((states) => EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 20,
                ))),
  );
}

class GroupeConst {
  static const String nom_gpe = 'nom_gpe';
  static const String id = 'id';
  static const String lieu = 'lieu';
  static const String created_at = 'created_at';
  static const String tableName = 'groupes';
}

class ProclamateurConst {
  static const String nom = 'nom';
  static const String id = 'id';
  static const String prenom = 'prenom';
  static const String tel = 'tel';
  static const String email = 'email';
  static const String adresse = 'adresse';
  static const String date_naiss = 'date_naiss';
  static const String groupe = 'groupe';
  static const String tableName = 'proclamateurs';
}

class RapportConst {
  static const String publ = 'publ';
  static const String id = 'id';
  static const String videos = 'videos';
  static const String nbre_heure = 'nbre_heure';
  static const String nvle_visite = 'nvle_visite';
  static const String cours_bibl = 'cours_bibl';
  static const String created_at = 'created_at';
  static const String proclamateur = 'proclamateur';
  static const String tableName = 'rapports';
}

class UserConst {
  static const String name = 'name';
  static const String id = 'id';
  static const String image = 'image';
  static const String email = 'email';
  static const String password = 'password';
  static const String tableName = 'users';
}
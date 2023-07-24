class GroupeModel {
  final int? id;
  final String lieu;
  final String nom_gpe;
  final String created_at;
  GroupeModel(
      {required this.nom_gpe,
      this.id,
      required this.created_at,
      required this.lieu});

  factory GroupeModel.fromJson(Map<String, dynamic> map) {
    return GroupeModel(
      nom_gpe: map['nom_gpe'],
      id: map['id'],
      created_at: map['created_at'],
      lieu: map['lieu'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'nom_gpe': nom_gpe,
      'id': id,
      'created_at': created_at,
      'lieu': lieu,
    };
  }
}

class ProclamateurModel {
  final int? id;
  final String nom;
  final String prenom;
  final String tel;
  final String email;
  final String adresse;
  final String date_naiss;
  final int groupe;
  ProclamateurModel(
      {required this.nom,
      this.id,
      required this.prenom,
      required this.tel,
      required this.email,
      required this.adresse,
      required this.date_naiss,
      required this.groupe});

  factory ProclamateurModel.fromJson(Map<String, dynamic> map) {
    return ProclamateurModel(
      nom: map['nom'],
      id: map['id'],
      prenom: map['prenom'],
      tel: map['tel'],
      email: map['email'],
      adresse: map['adresse'],
      date_naiss: map['date_naiss'],
      groupe: map['groupe'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'tel': tel,
      'email': email,
      'adresse': adresse,
      'date_naiss': date_naiss,
      'groupe': groupe
    };
  }

  @override
  String toString() {
    return 'Proclamateur{id: $id, nom: $nom, prenom: $prenom, tel: $tel, email: $email, adresse: $adresse, date_naiss: $date_naiss, groupe: $groupe}';
  }
}

class RapportModel {
  final int? id;
  final String publ;
  final String videos;
  final String nbre_heure;
  final String nvle_visite;
  final String cours_bibl;
  final String created_at;
  final int proclamateur;

  RapportModel({
    required this.publ,
    this.id,
    required this.videos,
    required this.nbre_heure,
    required this.nvle_visite,
    required this.cours_bibl,
    required this.created_at,
    required this.proclamateur,
  });

  factory RapportModel.fromJson(Map<String, dynamic> map) {
    return RapportModel(
      publ: map['publ'],
      id: map['id'],
      videos: map['videos'],
      nbre_heure: map['nbre_heure'],
      nvle_visite: map['nvle_visite'],
      cours_bibl: map['cours_bibl'],
      created_at: map['created_at'],
      proclamateur: map['proclamateur'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'publ': publ,
      'id': id,
      'videos': videos,
      'nbre_heure': nbre_heure,
      'nvle_visite': nvle_visite,
      'cours_bibl': cours_bibl,
      'created_at': created_at,
      'proclamateur': proclamateur,
    };
  }

  @override
  String toString() {
    return 'Rapport{id: $id, publ: $publ, videos: $videos, nbre_heure: $nbre_heure, nvle_visite: $nvle_visite, cours_bibl: $cours_bibl, created_at: $created_at, proclamateur: $proclamateur}';
  }
}

class UserModel {
  final int? id;
  final String name;
  final String image;
  final String email;
  final String password;
  UserModel(
      {required this.name,
      this.id,
      required this.image,
      required this.email,
      required this.password});

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
        name: map['name'],
        id: map['id'],
        image: map['image'],
        email: map['email'],
        password: map['password']);
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'image': image,
      'email': email,
      'password': email
    };
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, image: $image, email: $email, password: $password}';
  }
}

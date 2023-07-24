class Proclamateur {
  final int id;
  final String nom;
  final String prenom;
  final String tel;
  final String email;
  final String adresse;
  final String date_naiss;
  final int groupe;

  const Proclamateur({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.tel,
    required this.email,
    required this.adresse,
    required this.date_naiss,
    required this.groupe
  });

  factory Proclamateur.fromJson(Map<String, dynamic> json){
    return Proclamateur(
      id: json['id'],
      nom: json['nom'],
      prenom: json['prenom'],
      tel: json['tel'],
      email: json['email'],
      adresse: json['adresse'],
      date_naiss: json['date_naiss'],
      groupe: json['groupe'],
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
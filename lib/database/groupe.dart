class Groupe {
  final int id;
  final String lieu;
  final String nom_gpe;
  final String created_at;

  const Groupe ({
    required this.id,
    required this.lieu,
    required this.nom_gpe,
    required this.created_at
  });


  factory Groupe.fromJson(Map<String, dynamic> json) {
    return Groupe(
        id: json['id'],
        lieu: json['lieu'],
        nom_gpe: json['nom_gpe'],
        created_at: json['created_at'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'lieu': lieu,
      'nom_gpe': nom_gpe,
      'created_at': created_at
    };
  }

  @override
  String toString() {
    return '(id: $id, lieu: $lieu, nom_gpe: $nom_gpe, created_at: $created_at)';
  }
}
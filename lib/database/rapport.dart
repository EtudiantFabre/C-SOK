class Rapport {
  final int id;
  final int publ;
  final int videos;
  final int nbre_heure;
  final int nvle_visite;
  final int cours_bibl;
  final int proclamateur;

  const Rapport({
    required this.id,
    required this.publ,
    required this.videos,
    required this.nbre_heure,
    required this.nvle_visite,
    required this.cours_bibl,
    required this.proclamateur,
  });

  factory Rapport.fromJson(Map<String, dynamic> json){
    return Rapport(
      id: json['id'],
      publ: json['publ'],
      videos: json['videos'],
      nbre_heure: json['nbre_heure'],
      nvle_visite: json['nvle_visite'],
      cours_bibl: json['cours_bibl'],
      proclamateur: json['proclamateur'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'publ': publ,
      'videos': videos,
      'nbre_heure': nbre_heure,
      'nvle_visite': nvle_visite,
      'cours_bibl': cours_bibl,
      'proclamateur': proclamateur,
    };
  }

  @override
  String toString() {
    return 'Rapport{id: $id, publ: $publ, videos: $videos, nbre_heure: $nbre_heure, nvle_visite: $nvle_visite, cours_bibl: $cours_bibl, proclamateur: $proclamateur}';
  }
}
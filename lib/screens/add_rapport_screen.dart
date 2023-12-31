import 'package:c_sok/constante.dart';
import 'package:c_sok/models/model.dart';
import 'package:c_sok/service/database_repository.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AddRapportScreen extends StatefulWidget {
  RapportModel? rapport;
  AddRapportScreen({Key? key, this.rapport}) : super(key: key);

  @override
  State<AddRapportScreen> createState() => _AddRapportScreenState();
}

class _AddRapportScreenState extends State<AddRapportScreen> {
  TextEditingController publicationController = TextEditingController();
  TextEditingController videosController = TextEditingController();
  TextEditingController nbreHeureController = TextEditingController();
  TextEditingController nvleVisiteController = TextEditingController();
  TextEditingController coursBibliqueController = TextEditingController();

  var proclSelect;
  List<ProclamateurModel> itemsProcs = [];

  @override
  void initState() {
    addRapportData();
    getProc();
    super.initState();
  }

  @override
  void dispose() {
    publicationController.dispose();
    videosController.dispose();
    nbreHeureController.dispose();
    nvleVisiteController.dispose();
    coursBibliqueController.dispose();
    super.dispose();
  }

  void addRapportData() {
    if (widget.rapport != null) {
      if (mounted) {
        setState(() {
          publicationController.text = widget.rapport!.publ ?? '';
          videosController.text = widget.rapport!.videos ?? '';
          nbreHeureController.text = widget.rapport!.nbre_heure ?? '';
          nvleVisiteController.text = widget.rapport!.nvle_visite ?? '';
          coursBibliqueController.text = widget.rapport!.cours_bibl ?? '';
          proclSelect = widget.rapport!.proclamateur ?? '';
        });
      }
    }
  }

  void addRapport() async {
    if (proclSelect != null) {
      RapportModel rapport = RapportModel(
        publ: publicationController.text,
        videos: videosController.text,
        nbre_heure: nbreHeureController.text,
        nvle_visite: nvleVisiteController.text,
        cours_bibl: coursBibliqueController.text,
        created_at: DateTime.now().toString(),
        proclamateur: proclSelect,
      );
      if (widget.rapport == null) {
        if (rapport.publ != "" &&
            rapport.videos != "" &&
            rapport.nbre_heure != "" &&
            rapport.nvle_visite != "" &&
            rapport.cours_bibl != "" &&
            rapport.proclamateur != "") {
          await DatabaseRepository.instance.insertRapport(rapport: rapport);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Rapport créer avec succès !"),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Remplissez vos champs !"),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        await DatabaseRepository.instance.updateRapport(rapport);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Rapport modifié avec succès !"),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Remplissez les champs !"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void getProc() async {
    await DatabaseRepository.instance.getAllProc().then((value) {
      setState(() {
        itemsProcs = value;
      });
    }).catchError((e) => debugPrint(e.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rapport'),
      ),
      body: Container(
        child: Form(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //  Publication
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 32.0, top: 8.0),
                      child: Text(
                        'Ajout de Rapport',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontStyle: FontStyle.normal,
                            fontSize: 20,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 32.0),
                      child: Text(
                        'Publication laissé',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontStyle: FontStyle.normal,
                            fontSize: 16,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  Container(
                    padding: textFromFieldPadding(),
                    child: TextFormField(
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                      keyboardType: TextInputType.number,
                      controller: publicationController,
                      onTap: () {},
                      validator: (val) =>
                          val!.isEmpty ? 'Valeur invalide.' : null,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Publication laissé",
                      ),
                      enabled: true,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  //  Vidéo
            
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 32.0),
                      child: Text(
                        'Vidéo',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontStyle: FontStyle.normal,
                            fontSize: 16,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  Container(
                    padding: textFromFieldPadding(),
                    child: TextFormField(
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                      keyboardType: TextInputType.number,
                      controller: videosController,
                      onTap: () {},
                      validator: (val) =>
                          val!.isEmpty ? 'Valeur invalide.' : null,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Vidéo montré",
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  //  Heure
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 32.0),
                      child: Text(
                        'Nombre d\'heure',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontStyle: FontStyle.normal,
                            fontSize: 16,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  Container(
                    padding: textFromFieldPadding(),
                    child: TextFormField(
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                      keyboardType: TextInputType.number,
                      controller: nbreHeureController,
                      onTap: () {},
                      validator: (val) =>
                          val!.isEmpty ? 'Heure invalide.' : null,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Heure",
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  //  Nouvelle visite
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 32.0),
                      child: Text(
                        'Nouvelle visite',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontStyle: FontStyle.normal,
                            fontSize: 16,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  Container(
                    padding: textFromFieldPadding(),
                    child: TextFormField(
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                      keyboardType: TextInputType.number,
                      controller: nvleVisiteController,
                      onTap: () {},
                      validator: (val) =>
                          val!.isEmpty ? 'Valeur invalide.' : null,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Nouvelle visite",
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  //  Cours biblique
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 32.0),
                      child: Text(
                        'Cours bibliques',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontStyle: FontStyle.normal,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: textFromFieldPadding(),
                    child: TextFormField(
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                      keyboardType: TextInputType.number,
                      controller: coursBibliqueController,
                      onTap: () {},
                      validator: (val) =>
                          val!.isEmpty ? 'Valeur invalide.' : null,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Cours biblique",
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  //  Proclamateur
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 32.0),
                      child: Text(
                        'Proclamateur',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontStyle: FontStyle.normal,
                            fontSize: 16,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  Container(
                    padding: textFromFieldPadding(),
                    child: DropdownButtonFormField(
                      items: itemsProcs
                          .map((proc) => DropdownMenuItem(
                                value: proc.id ?? "",
                                child:
                                    Text("${proc.nom} ${proc.prenom}" ?? "N/A"),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(
                          () {
                            proclSelect = value;
                          },
                        );
                      },
                      value: proclSelect,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.group,
                        ),
                        prefixIconColor: Colors.black,
                        suffixIconColor: Colors.black,
                        hintText: "Choisir un proclamateur",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Colors.white,

          ),
          onPressed: () {
            addRapport();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.rapport == null ? Icons.add : Icons.update,
                size: 15,
                color: Colors.white70,
              ),
              Text(
                "VALIDER",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

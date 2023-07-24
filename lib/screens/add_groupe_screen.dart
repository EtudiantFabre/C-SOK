import 'package:c_sok/groupe/groupe_list.dart';
import 'package:c_sok/models/model.dart';
import 'package:c_sok/service/database_repository.dart';
import 'package:flutter/material.dart';

class AddGroupeScreen extends StatefulWidget {
  GroupeModel? groupe;
  AddGroupeScreen({Key? key, this.groupe}) : super(key: key);

  @override
  State<AddGroupeScreen> createState() => _AddGroupeScreenState();
}

class _AddGroupeScreenState extends State<AddGroupeScreen> {
  TextEditingController nomController = TextEditingController();
  TextEditingController lieuController = TextEditingController();
  Color bgColor = Colors.black26;

  @override
  void initState() {
    addGroupeData();
    super.initState();
  }

  @override
  void dispose() {
    nomController.dispose();
    lieuController.dispose();
    super.dispose();
  }

  void addGroupeData() {
    if (widget.groupe != null) {
      if (mounted) {
        setState(() {
          nomController.text = widget.groupe!.nom_gpe ?? '';
          lieuController.text = widget.groupe!.lieu ?? '';
        });
      }
    }
  }

  void addGroupe() async {
    GroupeModel groupe = GroupeModel(
        lieu: lieuController.text,
        nom_gpe: nomController.text,
        created_at: DateTime.now().toString());
    if (widget.groupe == null) {
      if (groupe.lieu != "" && groupe.nom_gpe != "") {
        await DatabaseRepository.instance.insertGroupe(groupe: groupe);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Groupe créer avec succès !"),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text("SVP, remplissez les champs !"),
          ),
        );
      }
    } else {
      await DatabaseRepository.instance.updateGroupe(groupe);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Groupe modifié avec succès !"),
        ),
      );
    }

    //Navigator.pushNamed(context, '/groupes');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Groupe : Ajout & Modification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              style: const TextStyle(
                fontSize: 18,
              ),
              keyboardType: TextInputType.text,
              controller: nomController,
              onTap: () {},
              validator: (val) => val!.isEmpty ? 'Nom invalide.' : null,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                focusColor: Colors.red,
                hintText: "Nom du groupe",
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              style: const TextStyle(
                fontSize: 18,
              ),
              keyboardType: TextInputType.text,
              controller: lieuController,
              onTap: () {},
              validator: (val) => val!.isEmpty ? 'Lieu invalide.' : null,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Lieu",
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                ),
                onPressed: addGroupe,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(
                    widget.groupe == null ? Icons.add : Icons.update,
                    size: 15,
                    color: Colors.white70,
                  ),
                  const Text(
                    " Valider",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

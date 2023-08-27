import 'package:c_sok/models/model.dart';
import 'package:c_sok/service/database_repository.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AddProclamateurScreen extends StatefulWidget {
  ProclamateurModel? proc;
  AddProclamateurScreen({Key? key, this.proc}) : super(key: key);

  @override
  State<AddProclamateurScreen> createState() => _AddProclamateurScreenState();
}

class _AddProclamateurScreenState extends State<AddProclamateurScreen> {
  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController telController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController adresseController = TextEditingController();

  var groupeSelect;
  var selectType;

  Color bgColor = Colors.black26;
  List<GroupeModel> itemsGroupe = [];
  List<TypeModel> itemsType = [];
  DateTime creneau = DateTime.now();

  @override
  void initState() {
    addProclamateurData();
    getGroupes();
    super.initState();
  }

  @override
  void dispose() {
    nomController.dispose();
    prenomController.dispose();
    telController.dispose();
    emailController.dispose();
    adresseController.dispose();
    //dateNaissController.dispose();
    //groupe_select.dispose();
    super.dispose();
  }

  void addProclamateurData() {
    if (widget.proc != null) {
      if (mounted) {
        setState(() {
          nomController.text = widget.proc!.nom ?? '';
          prenomController.text = widget.proc!.prenom ?? '';
          telController.text = widget.proc!.tel ?? '';
          emailController.text = widget.proc!.email ?? '';
          adresseController.text = widget.proc!.adresse ?? '';
          groupeSelect = widget.proc!.groupe ?? 0;
          selectType = widget.proc!.type ?? 0;
          creneau = DateTime.parse(widget.proc!.date_naiss);
        });
      }
    }
  }

  void addProclamateur() async {
    if (groupeSelect != null) {
      ProclamateurModel procl = ProclamateurModel(
          nom: nomController.text,
          prenom: prenomController.text,
          tel: telController.text,
          email: emailController.text,
          adresse: adresseController.text,
          date_naiss: creneau.toString(),
          groupe: groupeSelect,
          type: selectType);
      if (widget.proc == null) {
        if (procl.nom != "" &&
            procl.prenom != "" &&
            procl.tel != "" &&
            procl.email != "" &&
            procl.adresse != "" &&
            procl.groupe != "" &&
            procl.type != "" &&
            procl.date_naiss != "") {
          await DatabaseRepository.instance.insertProc(proc: procl);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Proclamateur créer avec succès !"),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Remplissez les champs !"),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        await DatabaseRepository.instance.updateProc(procl);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Proclamateur modifié avec succès !"),
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

  void getGroupes() async {
    await DatabaseRepository.instance.getAllGroupes().then((value) {
      setState(() {
        itemsGroupe = value;
      });
    }).catchError((e) => debugPrint(e.toString()));
  }

  void getTypes() async {
    await DatabaseRepository.instance.getAllTypes().then((value) {
      setState(() {
        itemsType = value;
      });
    }).catchError((e) => debugPrint(e.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajout de proclamateur'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            //  Nom
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
                prefixIcon: Icon(
                  Icons.person,
                ),
                prefixIconColor: Colors.black,
                hintText: "Nom",
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            //  Prénom
            TextFormField(
              style: const TextStyle(
                fontSize: 18,
              ),
              keyboardType: TextInputType.text,
              controller: prenomController,
              onTap: () {},
              validator: (val) => val!.isEmpty ? 'Prénom invalide.' : null,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(
                  Icons.person,
                ),
                prefixIconColor: Colors.black,
                hintText: "Prénom",
              ),
            ),
            const SizedBox(
              height: 15,
            ),

            //  Tel
            TextFormField(
              style: const TextStyle(
                fontSize: 18,
              ),
              controller: telController,
              keyboardType: TextInputType.phone,
              validator: (val) => val!.isEmpty ? 'Numéro invalide.' : null,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(
                  Icons.phone,
                ),
                prefixIconColor: Colors.black,
                hintText: "Télephone",
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            //  Email
            TextFormField(
              style: const TextStyle(
                fontSize: 18,
              ),
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              onTap: () {},
              validator: (val) => val!.isEmpty ? 'Email invalide.' : null,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(
                  Icons.mail,
                ),
                prefixIconColor: Colors.black,
                hintText: "Email",
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            //  Adresse
            TextFormField(
              style: const TextStyle(
                fontSize: 18,
              ),
              keyboardType: TextInputType.streetAddress,
              controller: adresseController,
              onTap: () {},
              validator: (val) => val!.isEmpty ? 'Adresse invalide.' : null,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(
                  Icons.location_city,
                ),
                prefixIconColor: Colors.black,
                hintText: "Adresse",
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            //  Date Naissance
            TextFormField(
              readOnly: true,
              keyboardType: TextInputType.datetime,
              controller: TextEditingController(
                  text:
                      "${creneau.year}/${creneau.month}/${creneau.day}" ?? ""),
              onTap: () async {
                DateTime? date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1950, 11, 4),
                  lastDate: DateTime.now(),
                );

                if (date != null) {
                  setState(() {
                    creneau = date;
                  });
                }
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(
                  Icons.date_range,
                ),
                prefixIconColor: Colors.black,
                labelText: "Date de naissance",
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            //  Groupe associée
            DropdownButtonFormField(
              items: itemsGroupe
                  .map(
                    (groupe) => DropdownMenuItem(
                      value: groupe.id,
                      child: Text(groupe.nom_gpe),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(
                  () {
                    groupeSelect = value;
                  },
                );
              },
              validator: (groupe) {
                if (groupe == "") {
                  return "Ne dois pas être null";
                } else {
                  return null;
                }
              },
              value: groupeSelect,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(
                  Icons.group,
                ),
                prefixIconColor: Colors.black,
                hintText: "Choisir un groupe",
              ),
            ),
            DropdownButtonFormField(
              items: itemsType
                  .map(
                    (type) => DropdownMenuItem(
                      value: type.id,
                      child: Text(type.name),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(
                  () {
                    selectType = value;
                  },
                );
              },
              validator: (groupe) {
                if (groupe == "") {
                  return "Ne dois pas être null";
                } else {
                  return null;
                }
              },
              value: selectType,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(
                  Icons.group,
                ),
                prefixIconColor: Colors.black,
                hintText: "Choisir un groupe",
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 70),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            addProclamateur();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.proc == null ? Icons.add : Icons.update,
                size: 15,
                color: Colors.white70,
              ),
              const Text(
                " VALIDER",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:c_sok/models/model.dart';
import 'package:c_sok/service/database_repository.dart';
import 'package:flutter/material.dart';
import '../constante.dart';

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
    getTypes();
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
        title: const Text('Proclamateur'),
      ),
      body: Container(
        child: Form(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 32.0, top: 8.0),
                      child: Text(
                        'Ajout de proclamateur',
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
                  //  Nom
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 32.0),
                      child: Text(
                        'Nom',
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
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  //  Prénom
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 32.0),
                      child: Text(
                        'Prénom',
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
                      keyboardType: TextInputType.text,
                      controller: prenomController,
                      onTap: () {},
                      validator: (val) =>
                          val!.isEmpty ? 'Prénom invalide.' : null,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.person,
                        ),
                        prefixIconColor: Colors.black,
                        hintText: "Prénom",
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  //  Tel
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 32.0),
                      child: Text(
                        'Numéro de télephone',
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
                      controller: telController,
                      keyboardType: TextInputType.phone,
                      validator: (val) =>
                          val!.isEmpty ? 'Numéro invalide.' : null,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.phone,
                        ),
                        prefixIconColor: Colors.black,
                        hintText: "Télephone",
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  
                  //  Email
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 32.0),
                      child: Text(
                        'Email',
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
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      onTap: () {},
                      validator: (val) =>
                          val!.isEmpty ? 'Email invalide.' : null,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.mail,
                        ),
                        prefixIconColor: Colors.black,
                        hintText: "Email",
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  //  Adresse
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 32.0),
                      child: Text(
                        'Adresse',
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
                      keyboardType: TextInputType.streetAddress,
                      controller: adresseController,
                      onTap: () {},
                      validator: (val) =>
                          val!.isEmpty ? 'Adresse invalide.' : null,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.location_city,
                        ),
                        prefixIconColor: Colors.black,
                        hintText: "Adresse",
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  //  Date Naissance
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 32.0),
                      child: Text(
                        'Date de naissance',
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
                      readOnly: true,
                      keyboardType: TextInputType.datetime,
                      controller: TextEditingController(
                          text:
                              "${creneau.year}/${creneau.month}/${creneau.day}" ??
                                  ""),
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
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  //  Groupe associée
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 32.0),
                      child: Text(
                        'Groupe de prédication',
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
                      items: itemsGroupe
                          .map(
                            (groupe) => DropdownMenuItem(
                              value: groupe.id,
                              child:
                                  Text(capitalizeFirstLetter(groupe.nom_gpe)),
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
                          labelText: "Groupe"),
                    ),
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  //Type de proclamateur
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 32.0),
                      child: Text(
                        'Type de proclamateur',
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
                      items: itemsType
                          .map(
                            (type) => DropdownMenuItem(
                              value: type.id,
                              child:
                                  Text(capitalizeFirstLetter(type.name) ?? ""),
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
                          hintText: "Type de proclamateur",
                          labelText: "Type proclamateur"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
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
      ),
    );
  }

}

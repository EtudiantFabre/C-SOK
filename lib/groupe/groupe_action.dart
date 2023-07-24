import 'package:c_sok/database/groupe.dart';
import 'package:c_sok/constante.dart';
import 'package:c_sok/service/sqlite_service1.dart';
import 'package:flutter/material.dart';

class GroupeAction extends StatefulWidget {
  //const GroupeAction({Key? key}) : super(key: key);
  final Groupe? groupe;
  final String? title;

  GroupeAction({this.groupe, this.title});

  @override
  State<GroupeAction> createState() => _GroupeActionState();
}

class _GroupeActionState extends State<GroupeAction> {
  bool _loading = false;
  TextEditingController nom_gpe = TextEditingController();
  TextEditingController lieu_gpe = TextEditingController();
  Color bgColor = Colors.black26;
  late SqliteService _sqliteService;

  @override
  void initState() {
    super.initState();
    if (widget.groupe != null) {
      nom_gpe.text = widget.groupe!.nom_gpe ?? '';
      lieu_gpe.text = widget.groupe!.lieu ?? '';
    }
    this._sqliteService = SqliteService();
  }

  Future<void> createGroupe(String nom_gpe, String lieu) async {
    var groupes = await SqliteService().groupes();
    Groupe gpe = Groupe(
        id: groupes.length + 1,
        lieu: lieu,
        nom_gpe: nom_gpe,
        created_at: DateTime.now().toString()
    );
    //print("Liste des groupes : $groupes");
    SqliteService().insertGroupe(gpe);
    groupes = await SqliteService().groupes();
    print("Liste des groupe : $groupes");
    Navigator.pushNamed(context, '/dashboard');
  }

  Future<bool> editGroupe(int id_gpe) async {
    Groupe groupe = Groupe(
        id: id_gpe,
        lieu: lieu_gpe.text,
        nom_gpe: nom_gpe.text,
        created_at: DateTime.now().toString()
    );
    SqliteService().updateGroupe(groupe);
    return true;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Groupe'),
      ),
      body: _loading ?
          Center(
            child: CircularProgressIndicator(color: Theme.of(context).primaryColor),
          ) :
        Form(
          child: Container(
            color: Theme.of(context).primaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10,),
                  GestureDetector(
                    onTap: () {
                      setState(() {

                      });
                    },
                    child: Center(
                      child: Container(
                        //color: Colors.red,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: bgColor,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextFormField(
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                              keyboardType: TextInputType.text,
                              controller: nom_gpe,
                              onTap: (){

                              },
                              validator: (val) =>
                              val!.isEmpty ? 'Nom invalide.' : null,
                              decoration: const InputDecoration(
                                enabledBorder: InputBorder.none,
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.account_box,
                                  color: Colors.white,
                                ),
                                focusColor: Colors.red,
                                hintText: "Nom du groupe",

                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  GestureDetector(
                    onTap: () {
                      setState(() {

                      });
                    },
                    child: Center(
                      child: Container(
                        //color: Colors.red,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: bgColor,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextFormField(
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                              keyboardType: TextInputType.text,
                              controller: lieu_gpe,
                              onTap: (){

                              },
                              validator: (val) =>
                              val!.isEmpty ? 'Lieu invalide.' : null,
                              decoration: const InputDecoration(
                                enabledBorder: InputBorder.none,
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.account_box,
                                  color: Colors.white,
                                ),
                                focusColor: Colors.red,
                                hintText: "Lieu",

                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  kTextButton('Enregistrer', () {
                    if (!nom_gpe.text.isEmpty && !lieu_gpe.text.isEmpty) {
                      setState(() {
                        _loading = !_loading;
                      });
                      if (widget.groupe == null) {
                        createGroupe(nom_gpe.text, lieu_gpe.text);
                      } else {
                        editGroupe(widget.groupe!.id ?? 0);
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                            'Attention, veillez entrer des données correct',
                            style: TextStyle(color: Colors.red),
                          )));
                    }
                  }),
                ],
              ),
            ),
          ),
        ),
    );
  }
}

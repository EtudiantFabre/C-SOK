import 'package:c_sok/database/groupe.dart';
import 'package:c_sok/groupe/groupe_action.dart';
import 'package:c_sok/models/model.dart';
import 'package:c_sok/screens/add_groupe_screen.dart';
import 'package:c_sok/service/database_repository.dart';
import 'package:c_sok/service/sqlite_service1.dart';
import 'package:flutter/material.dart';

enum SampleItem { Modifier, Supprimer, Afficher }

class GroupeList extends StatefulWidget {
  const GroupeList({Key? key}) : super(key: key);

  @override
  State<GroupeList> createState() => _GroupeListState();
}


class _GroupeListState extends State<GroupeList> {

  void initDb() async {
    await SqliteService().initializeDB();
  }

  late Future<List<Groupe>> groupesFuture;

  @override
  void initState() {
    initDb();
    super.initState();
    groupesFuture = SqliteService().groupes();
  }

  void _handleDeleteGroupe(int gpe_id) async {
    await SqliteService().deleteGroupe(gpe_id);
  }

  List<GroupeModel> myTodos = [];
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.08);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.2);
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Liste des Groupes'),),
        backgroundColor: Colors.blueGrey,
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<List<Groupe>>(
        future: groupesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          final List<Groupe> listeGroupe = snapshot.data ?? [];
          print("Liste des groupes : $listeGroupe");

          return ListView.builder(
            itemCount: listeGroupe.length,
            itemBuilder: (context, int index) {
              Groupe gpe = listeGroupe[index];
              return ListTile(
                style: ListTileStyle.list,
                tileColor: index.isOdd ? oddItemColor : evenItemColor,
                title: Text(gpe.nom_gpe.toString()),
                trailing: PopupMenuButton<SampleItem>(
                  onSelected: (SampleItem item) {
                    if (item == SampleItem.Modifier) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => GroupeAction(
                            title: 'Edit Groupe',
                            groupe: gpe,
                          )));
                    } else {
                      _handleDeleteGroupe(gpe.id ?? 0);
                    }
                  },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => GroupeAction(
                            title: 'C-Sok',
                            groupe: gpe,
                          )),
                      );
                    },
                    value: SampleItem.Modifier,
                    child: const Text('Modifier'),
                  ),
                  PopupMenuItem(
                    onTap: () {
                      _handleDeleteGroupe(gpe.id);
                    },
                    value: SampleItem.Supprimer,
                    child: const Text(
                        'Supprimer',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                ],
                child: const Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Icon(
                    Icons.more_vert,
                    color: Colors.black,
                  ),
                ),
              ));
            },
          );
        },
      ),
    );
  }

  void getTodos() async {
    await DatabaseRepository.instance.getAllGroupes().then((value) {
      setState(() {
        myTodos = value;
      });
    }).catchError((e) => debugPrint(e.toString()));
  }

  void gotoAddGroupe() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddGroupeScreen();
    }));
  }

  void delete({required GroupeModel groupe, required BuildContext context}) async {
    DatabaseRepository.instance.deleteGroupe(groupe.id!).then((value) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Deleted')));
    }).catchError((e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    });
  }
}

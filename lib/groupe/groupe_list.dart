import 'package:c_sok/groupe/groupe_widget.dart';
import 'package:c_sok/models/model.dart';
import 'package:c_sok/screens/add_groupe_screen.dart';
import 'package:c_sok/screens/export_pdf_groupes.dart';
import 'package:c_sok/service/database_repository.dart';
import 'package:flutter/material.dart';

class GroupeList extends StatefulWidget {
  const GroupeList({Key? key}) : super(key: key);

  @override
  State<GroupeList> createState() => _GroupeListState();
}

class _GroupeListState extends State<GroupeList> {
  bool shadowColor = false;
  double? scrolledUnderElevation;
  static const IconData picture_as_pdf =
      IconData(0xe4c0, fontFamily: 'MaterialIcons');

  @override
  void initState() {
    getGroupes();
    super.initState();
  }

  List<GroupeModel> mesgroupes = [];
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        getGroupes();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Liste des Groupes"),
          automaticallyImplyLeading: false,
          scrolledUnderElevation: scrolledUnderElevation,
          shadowColor:
              shadowColor ? Theme.of(context).colorScheme.shadow : null,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return PdfPreviewPage("Salut");
                    },
                  ),
                );
              },
              icon: const Icon(
                Icons.picture_as_pdf_outlined,
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Theme.of(context).colorScheme.primary,
          onPressed: gotoAddGroupeScreen,
          label: Text('Ajouter'),
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: mesgroupes.isEmpty
            ? const Center(
                child:
                    Text('Vous n\'avez rien pour enregistrer pour l\'instant'))
            : Column(
                children: [
                  /* const SizedBox(
                    height: 10,
                  ), */
                  Expanded(
                    child: ListView.builder(
                      /* separatorBuilder: (context, index) => const SizedBox(
                        height: 20,
                      ), */
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      itemBuilder: (context, index) {
                        final groupe = mesgroupes[index];
                        return GroupeWidget(
                          groupe: groupe,
                          onDeletePressed: () {
                            delete(groupe: groupe, context: context);
                            getGroupes();
                          },
                        );
                      },
                      itemCount: mesgroupes.length,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  void getGroupes() async {
    await DatabaseRepository.instance.getAllGroupes().then(
      (value) {
        setState(
          () {
            mesgroupes = value;
          },
        );
      },
    ).catchError((e) => debugPrint(e.toString()));
  }

  void gotoAddGroupeScreen() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddGroupeScreen();
    }));
    getGroupes();
  }

  void delete(
      {required GroupeModel groupe, required BuildContext context}) async {
    DatabaseRepository.instance.deleteGroupe(groupe.id!).then((value) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Deleted')));
    }).catchError((e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    });
  }
}

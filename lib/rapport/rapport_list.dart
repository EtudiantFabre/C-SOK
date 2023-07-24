import 'package:c_sok/models/model.dart';
import 'package:c_sok/rapport/rapport_widget.dart';
import 'package:c_sok/screens/add_proclamateur_screen.dart';
import 'package:c_sok/screens/add_rapport_screen.dart';
import 'package:c_sok/screens/export_pdf_rapports.dart';
import 'package:c_sok/service/database_repository.dart';
import 'package:flutter/material.dart';

class RapportList extends StatefulWidget {
  const RapportList({Key? key}) : super(key: key);

  @override
  State<RapportList> createState() => RapportListState();
}

class RapportListState extends State<RapportList> {
  @override
  void initState() {
    getRapports();
    super.initState();
  }

  List<RapportModel> mesrapport = [];
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        getRapports();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Rapports"),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return PdfPreviewRapport("Salut");
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
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.primary,
          onPressed: goAddRapportScreen,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: mesrapport.isEmpty
            ? const Center(
                child:
                    Text('Rien pour enregistrer comme rapport pour l\'instant'))
            : Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Liste des Rapports",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 20,
                      ),
                      padding: const EdgeInsets.all(16),
                      itemBuilder: (context, index) {
                        final rapport = mesrapport[index];
                        return RapportWidget(
                            rapport: rapport,
                            onDeletePressed: () {
                              deleteRapport(rap: rapport, context: context);
                              getRapports();
                            });
                      },
                      itemCount: mesrapport.length,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  void getRapports() async {
    await DatabaseRepository.instance.getAllRapports().then((value) {
      setState(() {
        mesrapport = value;
      });
      // ignore: invalid_return_type_for_catch_error
    }).catchError((e) => debugPrint(e.toString()));
  }

  void goAddRapportScreen() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return AddRapportScreen();
        },
      ),
    );
    getRapports();
  }

  void deleteRapport(
      {required RapportModel rap, required BuildContext context}) async {
    DatabaseRepository.instance.deleteRapport(rap.id!).then((value) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Supprimé !')));
    }).catchError((e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    });
  }
}

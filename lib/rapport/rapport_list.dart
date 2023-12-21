import 'package:c_sok/models/model.dart';
import 'package:c_sok/rapport/pdf_choice_dialog.dart';
import 'package:c_sok/rapport/rapport_widget.dart';
import 'package:c_sok/screens/add_proclamateur_screen.dart';
import 'package:c_sok/screens/add_rapport_screen.dart';
import 'package:c_sok/screens/export_pdf_rapports.dart';
import 'package:c_sok/service/database_repository.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';

class RapportList extends StatefulWidget {
  const RapportList({Key? key}) : super(key: key);

  @override
  State<RapportList> createState() => RapportListState();
}

class RapportListState extends State<RapportList> {
  List<RapportModel> mesrapport = [];

  @override
  void initState() {
    getRapports();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //print("Liste des rapports : $mesrapport");
    return RefreshIndicator(
      onRefresh: () async {
        getRapports();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Rapport"),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return PdfPreviewRapport("");
                    },
                  ),
                );
              },
              icon: const Icon(
                Icons.picture_as_pdf_outlined,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return PdfChoiceDialog();
                    },
                  ),
                );
              },
              icon: const Icon(
                Icons.arrow_downward,
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Theme.of(context).colorScheme.primary,
          onPressed: goAddRapportScreen,
          label: const Text(
            'Ajouter',
          ),
          icon: const Icon(
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
                  Expanded(
                    child: ListView.builder(
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
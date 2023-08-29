import 'package:c_sok/models/model.dart';
import 'package:c_sok/proclamateur/proclamateur_widget.dart';
import 'package:c_sok/screens/add_proclamateur_screen.dart';
import 'package:c_sok/screens/export_pdf_proclamateurs.dart';
import 'package:c_sok/service/database_repository.dart';
import 'package:flutter/material.dart';

class ProclamateurList extends StatefulWidget {
  const ProclamateurList({Key? key}) : super(key: key);

  @override
  State<ProclamateurList> createState() => ProclamateurListState();
}

class ProclamateurListState extends State<ProclamateurList> {
  bool shadowColor = false;
  double? scrolledUnderElevation;
  static const IconData picture_as_pdf =
      IconData(0xe4c0, fontFamily: 'MaterialIcons');

  @override
  void initState() {
    getProclamateurs();
    super.initState();
  }

  List<ProclamateurModel> mesprocs = [];
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        getProclamateurs();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Proclamateurs"),
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
                      return PdfPreviewProclamateur("Salut");
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
          //backgroundColor: Theme.of(context).colorScheme.primary,
          onPressed: goAddProcScreen,
          label: Text('Ajouter'),
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        //floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: mesprocs.isEmpty
            ? const Center(
                child:
                    Text('Vous n\'avez rien pour enregistrer pour l\'instant'))
            : Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Liste des Proclamateurs",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: ListView.builder(
                      /* separatorBuilder: (context, index) => const SizedBox(
                        height: 20,
                      ), */
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      itemBuilder: (context, index) {
                        final proc = mesprocs[index];
                        return ProclamateurWidget(
                            proc: proc,
                            onDeletePressed: () {
                              deleteProc(proc: proc, context: context);
                              getProclamateurs();
                            });
                      },
                      itemCount: mesprocs.length,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  void getProclamateurs() async {
    await DatabaseRepository.instance.getAllProc().then((value) {
      setState(() {
        mesprocs = value;
      });
    }).catchError((e) => debugPrint(e.toString()));
  }

  void goAddProcScreen() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return AddProclamateurScreen();
        },
      ),
    );
    getProclamateurs();
  }

  void deleteProc(
      {required ProclamateurModel proc, required BuildContext context}) async {
    DatabaseRepository.instance.deleteProc(proc.id!).then((value) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Supprimé !')));
    }).catchError((e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    });
  }
}

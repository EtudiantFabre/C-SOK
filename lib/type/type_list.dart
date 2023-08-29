import 'package:c_sok/models/model.dart';
import 'package:c_sok/service/database_repository.dart';
import 'package:c_sok/type/build_bottomSheetType.dart';
import 'package:c_sok/type/type_widget.dart';
import 'package:flutter/material.dart';

class TypeList extends StatefulWidget {
  const TypeList({Key? key}) : super(key: key);

  @override
  State<TypeList> createState() => TypeListState();
}

class TypeListState extends State<TypeList> {
  @override
  void initState() {
    getTypes();
    super.initState();
  }

  void updateTypeList() {
    getTypes();
  }

  List<TypeModel> typeList = [];
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        getTypes();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Type Proclamateur"),
          /* actions: [
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
          ], */
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Theme.of(context).colorScheme.primary,
          onPressed: () {
            showModalBottomSheet(
              backgroundColor: const Color(0x00000000),
              isScrollControlled: true,
              context: context,
              builder: (context) => SingleChildScrollView(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom),
                child: BuildBottomSheetType(
                    context: context, updateTypeListCallback: updateTypeList),
              ),
            );
          },
          label: const Text(
            'Ajouter',
          ),
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: typeList.isEmpty
            ? const Center(
                child: Text(
                  'vide',
                ),
              )
            : Column(
                children: [
                  /* const Text(
                    "Types de proclamateur",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ), */
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      itemBuilder: (context, index) {
                        final type = typeList[index];
                        return TypeWidget(
                          type: type,
                          onDeletePressed: () {
                            deleteType(type: type, context: context);
                            getTypes();
                          },
                        );
                      },
                      itemCount: typeList.length,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  void getTypes() async {
    await DatabaseRepository.instance.getAllTypes().then(
      (value) {
        setState(
          () {
            typeList = value;
          },
        );
        // ignore: invalid_return_type_for_catch_error
      },
    ).catchError((e) => debugPrint(e.toString()));
  }

  void deleteType(
      {required TypeModel type, required BuildContext context}) async {
    DatabaseRepository.instance.deleteType(type.id!).then(
      (value) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Supprimé !')));
      },
    ).catchError(
      (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      },
    );
  }
}

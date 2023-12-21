import 'package:c_sok/models/model.dart';
import 'package:c_sok/screens/export_pdf_rapports.dart';
import 'package:c_sok/service/database_repository.dart';
import 'package:flutter/material.dart';
import 'package:c_sok/constante.dart';

class PdfChoiceDialog extends StatefulWidget {
  const PdfChoiceDialog({Key? key}) : super(key: key);

  @override
  PdfChoiceDialogState createState() => PdfChoiceDialogState();
}

class PdfChoiceDialogState extends State<PdfChoiceDialog> {
  //List<TypeModel> itemsType = [];
  List<bool> status = [];
  String? selectedRingtone = "None";

  List<String> choix_exportation = [
    "Janvier",
    "Février",
    "Mars",
    "Avril",
    "Mai",
    "Juin",
    "Juillet",
    "Août",
    "Septembre",
    "Octobre",
    "Novembre",
    "Décembre"
  ];

  bool getValue(String val) {
    int index = choix_exportation.indexOf(val);
    if (index == -1) return false;
    return status[index];
  }

  void toggleValue(String val) {
    int index = choix_exportation.indexOf(val);
    if (index == -1) return;
    setState(() {
      status[index] = !status[index];
    });
  }

  @override
  void initState() {
    //getTypes();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant PdfChoiceDialog oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (choix_exportation.isNotEmpty &&
        choix_exportation.length != status.length) {
      setState(() {
        //  Initialisation de tout les status à false
        status = List.generate(choix_exportation.length, (index) => false);

        //  Cocher le premier élément
        status[0] = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);

    return AlertDialog(
      title: Text('Mois d\' exportation des données',
          style: textTheme.titleLarge!),
      contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      content: Wrap(
        direction: Axis.horizontal,
        children: choix_exportation
            .map((c) => RadioListTile(
                  title: Text(c, style: textTheme.titleSmall!),
                  groupValue: selectedRingtone,
                  selected: c == selectedRingtone,
                  value: c,
                  onChanged: (dynamic val) {
                    setState(() {
                      selectedRingtone = val;
                      // Navigator.of(context).pop();
                    });
                  },
                ))
            .toList(),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Annuler', style: textTheme.labelLarge!),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('OK', style: textTheme.labelLarge!),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return PdfPreviewRapport(selectedRingtone);
                },
              ),
            );
          },
        )
      ],
    );
  }

  /* void getTypes() async {
    await DatabaseRepository.instance.getAllTypes().then((value) {
      setState(() {
        itemsType = value;

        // Initialise la liste des statuts avec la même longueur que itemsType
        status = List.generate(itemsType.length,
            (index) => index == 0); // Coche le premier élément
      });
    }).catchError((e) => debugPrint(e.toString()));
  } */
}

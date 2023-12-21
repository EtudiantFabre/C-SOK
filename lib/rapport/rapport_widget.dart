import 'package:c_sok/constante.dart';
import 'package:c_sok/models/model.dart';
import 'package:c_sok/service/database_repository.dart';
import 'package:flutter/material.dart';

import '../screens/add_rapport_screen.dart';

class RapportWidget extends StatefulWidget {
  final RapportModel rapport;
  final VoidCallback onDeletePressed;

  const RapportWidget({
    Key? key,
    required this.rapport,
    required this.onDeletePressed,
  }) : super(key: key);

  @override
  State<RapportWidget> createState() => _RapportWidgetState();
}

class _RapportWidgetState extends State<RapportWidget> {
  ProclamateurModel? proc;
  int colorIndex = 0;

  @override
  void initState() {
    getProclamateurById(widget.rapport.proclamateur);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return AddRapportScreen(
            rapport: widget.rapport,
          );
        }));
      },
      child: Container(
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                child: Text(capitalizeFirstLetter(proc?.nom[0] ?? "N/A")),
              ),
              title: Text(
                "${capitalizeFirstLetter(proc?.nom ?? "N/A")} ${capitalizeFirstLetter(proc?.prenom ?? "N/A")}",
              ),
              subtitle: Text(
                "H : ${widget.rapport.nbre_heure}, NV : ${widget.rapport.nvle_visite}, Cb : ${widget.rapport.cours_bibl}, Vidéo : ${widget.rapport.videos} \nDate : ${formatMonth(widget.rapport.created_at)}",
              ),
              trailing: IconButton(
                onPressed: widget.onDeletePressed,
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ),
            const Divider(
              height: 1.0,
            ),
          ],
        ),
      ),
    );
  }

  void getProclamateurById(int id) async {
    ProclamateurModel? proclamateur =
        await DatabaseRepository.instance.getProcById(id);

    setState(() {
      proc = proclamateur;
    });
  }
}

import 'package:c_sok/constante.dart';
import 'package:c_sok/models/model.dart';
import 'package:c_sok/screens/add_groupe_screen.dart';
import 'package:flutter/material.dart';

class GroupeWidget extends StatelessWidget {
  final GroupeModel groupe;
  final VoidCallback onDeletePressed;

  const GroupeWidget({
    Key? key,
    required this.groupe,
    required this.onDeletePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return AddGroupeScreen(
            groupe: groupe,
          );
        }));
      },
      child: Container(
        child: Column(
          children: [
            ListTile(
              iconColor: Colors.amber,
              leading: CircleAvatar(
                child: Text(
                  capitalizeFirstLetter(groupe.nom_gpe)[0] ?? "N/A",
                ),
              ),
              title: Text(
                capitalizeFirstLetter(groupe.nom_gpe),
                //style: const TextStyle(fontSize: 16),
              ),
              subtitle: Text(
                capitalizeFirstLetter(groupe.lieu),
                //style: const TextStyle(fontSize: 12),
              ),
              trailing: IconButton(
                onPressed: onDeletePressed,
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

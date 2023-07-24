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
        child: Card(
          elevation: 5,
          color: Colors.blueGrey.shade300,
          child: Column(
            children: [
              ListTile(
                iconColor: Colors.amber,
                leading: CircleAvatar(child: Text(groupe.nom_gpe[0])),
                title: Text(
                  groupe.nom_gpe,
                  //style: const TextStyle(fontSize: 16),
                ),
                subtitle: Text(
                  groupe.lieu,
                  //style: const TextStyle(fontSize: 12),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: onDeletePressed,
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:c_sok/constante.dart';
import 'package:c_sok/models/model.dart';
import 'package:flutter/material.dart';

import '../screens/add_rapport_screen.dart';

class RapportWidget extends StatelessWidget {
  final RapportModel rapport;
  final VoidCallback onDeletePressed;

  const RapportWidget({
    Key? key,
    required this.rapport,
    required this.onDeletePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return AddRapportScreen(
            rapport: rapport,
          );
        }));
      },
      child: Container(
        child: Card(
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  child: Text(rapport.proclamateur.toString() ?? "N/A"),
                ),
                title: Text(rapport.proclamateur.toString() ?? "N/A"
                    //style: const TextStyle(fontSize: 16),
                    ),
                subtitle: Text(
                  "H : ${rapport.nbre_heure}, NV : ${rapport.nvle_visite}",
                  //style: const TextStyle(fontSize: 12),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: onDeletePressed,
                    icon: const Icon(
                      Icons.delete,
                      //color: Colors.red,
                    ),
                    style: IconButton.styleFrom(
                        backgroundColor: Colors.red.shade600,
                        foregroundColor: Colors.white),
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

import 'package:c_sok/constante.dart';
import 'package:c_sok/models/model.dart';
import 'package:c_sok/screens/add_proclamateur_screen.dart';
import 'package:flutter/material.dart';

class ProclamateurWidget extends StatelessWidget {
  final ProclamateurModel proc;
  final VoidCallback onDeletePressed;

  const ProclamateurWidget({
    Key? key,
    required this.proc,
    required this.onDeletePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return AddProclamateurScreen(
            proc: proc,
          );
        }));
      },
      child: Container(
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                child: Text(
                  capitalizeFirstLetter(proc.nom)[0] ?? "N/A",
                ),
              ),
              title: Text(
                "${capitalizeFirstLetter(proc.nom)} ${capitalizeFirstLetter(proc.prenom)}" ??
                    "N/A",
              ),
              subtitle: Text(
                proc.email ?? "N/A",
                style: const TextStyle(fontSize: 12),
              ),
              trailing: IconButton(
                onPressed: onDeletePressed,
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.red.shade600,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:c_sok/models/model.dart';
import 'package:c_sok/type/build_bottomSheetType.dart';
import 'package:flutter/material.dart';
import '../constante.dart';

class TypeWidget extends StatelessWidget {
  final TypeModel type;
  final VoidCallback onDeletePressed;

  const TypeWidget({
    Key? key,
    required this.type,
    required this.onDeletePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) => SingleChildScrollView(
            padding:
                EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
            child: BuildBottomSheetType(
              context: context,
              updateTypeListCallback: () {},
              type: type,
            ),
          ),
        );
      },
      child: Container(
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                child: Text(
                  capitalizeFirstLetter(type.name)[0] ?? "N/A",
                ),
              ),
              title: Text(
                capitalizeFirstLetter(type.name),
                //style: const TextStyle(fontSize: 16),
              ),
              trailing: IconButton(
                onPressed: onDeletePressed,
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                style: IconButton.styleFrom(
                    backgroundColor: Colors.red.shade600,
                    foregroundColor: const Color.fromARGB(221, 222, 214, 214)),
              ),
            ),
            /* Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: onDeletePressed,
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    style: IconButton.styleFrom(
                        backgroundColor: Colors.red.shade600,
                        foregroundColor: Colors.white),
                  ),
                ],
              ) */
          ],
        ),
      ),
    );
  }
}

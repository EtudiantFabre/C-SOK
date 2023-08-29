import 'package:c_sok/models/model.dart';
import 'package:c_sok/service/database_repository.dart';
import 'package:c_sok/type/type_list.dart';
import 'package:flutter/material.dart';

class BuildBottomSheetType extends StatefulWidget {
  BuildBottomSheetType({
    super.key,
    required this.context,
    this.type,
    required this.updateTypeListCallback,
  });

  final BuildContext context;
  TypeModel? type;
  final VoidCallback updateTypeListCallback;

  @override
  State<BuildBottomSheetType> createState() => _BuildBottomSheetTypeState();
}

class _BuildBottomSheetTypeState extends State<BuildBottomSheetType> {
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    addTypeData();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void addTypeData() {
    if (widget.type != null) {
      if (mounted) {
        setState(() {
          nameController.text = widget.type!.name ?? '';
        });
      }
    }
  }

  void addType() async {
    TypeModel type = TypeModel(
      name: nameController.text,
    );
    if (widget.type == null) {
      if (type.name != "") {
        await DatabaseRepository.instance.insertType(type: type);
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Succès !"),
          ),
        );
        widget.updateTypeListCallback();

        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text("SVP, remplissez le !"),
          ),
        );
      }
    } else {
      print("Type : $type");
      await DatabaseRepository.instance.updateType(type);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Type modifié !!!"),
        ),
      );
      widget.updateTypeListCallback();

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      padding: const EdgeInsets.all(30.0),
      decoration: const BoxDecoration(
        //color: Colors.amber,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            20.0,
          ),
          topRight: Radius.circular(
            20.0,
          ),
        ),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            widget.type == null ? "Ajout de type" : "Modification du type",
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            controller: nameController,
            decoration: const InputDecoration(
              hintText: "Titre du type",
            ),
            validator: (val) {
              return (val != null && val.contains('@'))
                  ? 'Valeur incorect !!!'
                  : null;
            },
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
              ),
              onPressed: addType,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    widget.type == null ? Icons.add : Icons.update,
                    size: 15,
                    color: Colors.white70,
                  ),
                  const Text(
                    " Valider",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

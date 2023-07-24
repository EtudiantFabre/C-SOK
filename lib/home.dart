import 'package:c_sok/groupe/groupe_action.dart';
import 'package:c_sok/screens/add_groupe_screen.dart';
import 'package:c_sok/screens/add_proclamateur_screen.dart';
import 'package:c_sok/screens/add_rapport_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double? scrolledUnderElevation;
  bool shadowColor = false;

  @override
  Widget build(BuildContext context) {
    var heigth = MediaQuery.sizeOf(context).height;
    var widht = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Accueil"),
        ),
        automaticallyImplyLeading: false,
        scrolledUnderElevation: scrolledUnderElevation,
        shadowColor: shadowColor ? Theme.of(context).colorScheme.shadow : null,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 7.0),
        color: Colors.transparent,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text("Bienvenue dans l'applis C-SOK"),
              ),
              const Divider(
                color: Colors.blueGrey,
              ),
              const SizedBox(height: 10),
              const Text(
                "Tableau de bord",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 05),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Card(
                    elevation: 0,
                    color: Theme.of(context).indicatorColor,
                    child: SizedBox(
                      width: widht * 0.45,
                      height: heigth * 0.2,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "10",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          ),
                          Text(
                            "Groupes",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 0,
                    color: Theme.of(context).indicatorColor,
                    child: SizedBox(
                      width: widht * 0.45,
                      height: heigth * 0.2,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "10",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          ),
                          Text(
                            "Proclamateurs",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              const Divider(
                color: Colors.blueGrey,
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Actions d'ajout dans l'applis",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.add_circle_outline_sharp),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SwipeButton.expand(
                thumb: const Icon(
                  Icons.double_arrow_rounded,
                  color: Colors.white,
                ),
                activeThumbColor: Theme.of(context).indicatorColor,
                activeTrackColor: Colors.grey.shade300,
                onSwipe: () {
                  //Navigator.pushNamed(context, '/groupes');

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return AddGroupeScreen();
                      },
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Ajout de groupe"),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                child: const Text(
                  "Ajouter un groupe ...",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SwipeButton.expand(
                thumb: const Icon(
                  Icons.double_arrow_rounded,
                  color: Colors.white,
                ),
                activeThumbColor: Theme.of(context).indicatorColor,
                activeTrackColor: Colors.grey.shade300,
                onSwipe: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return AddProclamateurScreen();
                      },
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Ajout Proclamateur"),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                child: const Text(
                  "Ajouter un proclamateur ...",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SwipeButton.expand(
                thumb: const Icon(
                  Icons.double_arrow_rounded,
                  color: Colors.white,
                ),
                activeThumbColor: Theme.of(context).indicatorColor,
                activeTrackColor: Colors.grey.shade300,
                onSwipe: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return AddRapportScreen();
                      },
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Rapport"),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                child: const Text(
                  "Ajouter un rapport ...",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Divider(
                color: Colors.blueGrey,
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Information de l'applis",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.add_reaction_sharp,
                  ),
                ],
              ),
              Card(
                clipBehavior: Clip.hardEdge,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.background,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                child: InkWell(
                  splashColor: Colors.blue,
                  onTap: () {
                    debugPrint('Card tapped.');
                  },
                  child: SizedBox(
                    width: 430,
                    height: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            SizedBox(height: 30, width: 4),
                            Text(
                              "Date de la première version : ",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              "16/05/2023",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Row(
                          children: [
                            SizedBox(width: 5),
                            Text(
                              "Concue pour : ",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              "Assemblée de Sokodé",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const SizedBox(height: 4, width: 5),
                            const Card(
                              elevation: 7,
                              color: Colors.blueGrey,
                              child: SizedBox(
                                width: 271,
                                height: 90,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Développeur :",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    ),
                                    Text(
                                      "Fabrice TOYI",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              elevation: 7,
                              color: Colors.transparent,
                              child: SizedBox(
                                width: 90,
                                height: 90,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            15.0), // Définissez le rayon souhaité
                                        child: Image.asset(
                                          "lib/assets/fabre.jpeg",
                                          fit: BoxFit.cover,
                                          colorBlendMode: BlendMode.darken,
                                          semanticLabel: "Bienvenue !",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                clipBehavior: Clip.hardEdge,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.background,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                child: InkWell(
                  splashColor: Colors.blue,
                  onTap: () {
                    debugPrint('Card tapped.');
                  },
                  child: SizedBox(
                    width: 430,
                    height: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            SizedBox(height: 30, width: 4),
                            Text(
                              "Date de la première version : ",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              "16/05/2023",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Row(
                          children: [
                            SizedBox(width: 5),
                            Text(
                              "Concue pour : ",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              "Assemblée de Sokodé",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const SizedBox(height: 4, width: 5),
                            const Card(
                              elevation: 7,
                              color: Colors.blueGrey,
                              child: SizedBox(
                                width: 271,
                                height: 90,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Développeur :",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    ),
                                    Text(
                                      "Fabrice TOYI",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              elevation: 7,
                              color: Colors.transparent,
                              child: SizedBox(
                                width: 90,
                                height: 90,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            15.0), // Définissez le rayon souhaité
                                        child: Image.asset(
                                          "lib/assets/fabre.jpeg",
                                          fit: BoxFit.cover,
                                          colorBlendMode: BlendMode.darken,
                                          semanticLabel: "Bienvenue !",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                clipBehavior: Clip.hardEdge,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.background,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                child: InkWell(
                  splashColor: Colors.blue,
                  onTap: () {
                    debugPrint('Card tapped.');
                  },
                  child: SizedBox(
                    width: 430,
                    height: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            SizedBox(height: 30, width: 4),
                            Text(
                              "Date de la première version : ",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              "16/05/2023",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Row(
                          children: [
                            SizedBox(width: 5),
                            Text(
                              "Concue pour : ",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              "Assemblée de Sokodé",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const SizedBox(height: 4, width: 5),
                            const Card(
                              elevation: 7,
                              color: Colors.blueGrey,
                              child: SizedBox(
                                width: 271,
                                height: 90,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Développeur :",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    ),
                                    Text(
                                      "Fabrice TOYI",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              elevation: 7,
                              color: Colors.transparent,
                              child: SizedBox(
                                width: 90,
                                height: 90,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            15.0), // Définissez le rayon souhaité
                                        child: Image.asset(
                                          "lib/assets/fabre.jpeg",
                                          fit: BoxFit.cover,
                                          colorBlendMode: BlendMode.darken,
                                          semanticLabel: "Bienvenue !",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

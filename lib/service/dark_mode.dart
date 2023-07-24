import 'package:c_sok/Welcome.dart';
import 'package:c_sok/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void enableDarkMode() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: Colors.transparent, // Couleur de la barre de statut
    systemNavigationBarColor: Colors.black, // Couleur de la barre de navigation
    systemNavigationBarIconBrightness: Brightness.light, // Luminosité des icônes de la barre de navigation
  ));

  // Changer le thème de votre application en mode sombre
  runApp(
    MaterialApp(
      theme: ThemeData.dark(), // Thème sombre
      home: const MyApp(), // Remplacez MyApp() par votre widget racine
    ),
  );
}

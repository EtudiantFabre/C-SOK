import 'package:c_sok/service/dark_mode.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _darkModeEnabled = false;
  bool _showGridEnabled = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Paramètres"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
                "Apparence",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),
            /*ElevatedButton(
              onPressed: () {
                AdaptiveTheme.of(context).toggleThemeMode();
              },
              child: Text('Changer le thème'),
            ),*/
            SwitchListTile(
              title: const Text(
                "Mode sombre"
              ),
                activeColor: Colors.blue,
                value: _darkModeEnabled,
                onChanged: (value) {
                  print(value);
                  if (value == true) {
                    AdaptiveTheme.of(context).setDark();
                  } else {
                    AdaptiveTheme.of(context).setLight();
                  }
                  setState(() {
                    _darkModeEnabled = value;
                  });
                },
              secondary: const Icon(Icons.nightlight_round),
            ),
            const Text(
              "Compte",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),
            GestureDetector(
              child: const Text(
                "Modifier mon compte",
                style: TextStyle(

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

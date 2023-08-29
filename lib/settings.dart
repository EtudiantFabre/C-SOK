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
          child: Text(
            "Paramètres",
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: const Icon(Icons.nightlight_round, size: 50.0),
              title: const Text('Apparence'),
              subtitle: const Text("Sombre"),
              trailing: Switch(
                value: _darkModeEnabled,
                onChanged: (value) {
                  if (value == true) {
                    AdaptiveTheme.of(context).setDark();
                  } else {
                    AdaptiveTheme.of(context).setLight();
                  }
                  setState(() {
                    _darkModeEnabled = value;
                  });
                },
              ),
            ),
            const Divider(
              color: Colors.grey,
            ), 
            const SizedBox(
              height: 5,
            ),
            ListTile(
              leading: const Icon(
                Icons.people,
                size: 50.0,
              ),
              title: const Text('Type'),
              subtitle: const Text('Type de frère'),
              trailing: const Icon(Icons.person),
              onTap: () {
                Navigator.pushNamed(context, '/type_list');
              },
            ),
          ],
        ),
      ),
    );
  }
}

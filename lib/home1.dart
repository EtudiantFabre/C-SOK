import 'package:c_sok/groupe/groupe_action.dart';
import 'package:c_sok/screens/add_groupe_screen.dart';
import 'package:c_sok/screens/add_proclamateur_screen.dart';
import 'package:c_sok/screens/add_rapport_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';

class HomeScreenSecond extends StatefulWidget {
  const HomeScreenSecond({Key? key}) : super(key: key);

  @override
  State<HomeScreenSecond> createState() => _HomeScreenSecondState();
}

class _HomeScreenSecondState extends State<HomeScreenSecond> {
  double? scrolledUnderElevation;
  bool shadowColor = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        top: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                height: 500,
                child: Stack(
                  alignment: const AlignmentDirectional(0, -1),
                  children: [
                    Align(
                      alignment: const AlignmentDirectional(0.05, -1),
                      child: Image.asset(
                        'assets/img3.jpg',
                        width: double.infinity,
                        height: 500,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 500,
                      decoration: const BoxDecoration(
                        color: Color(0x8D090F13),
                      ),
                    ),
                    const Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                16,
                                24,
                                16,
                                24,
                              ),
                              child: Text(
                                'Bienvenue dans l\' application C-SoK. ',
                                style: TextStyle(
                                  fontFamily: 'Outfit',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

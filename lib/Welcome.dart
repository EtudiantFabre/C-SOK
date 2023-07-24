import 'package:c_sok/database/user.dart';
import 'package:c_sok/service/insert_into_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

enum FormData {
  Email,
  password,
}

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  bool select = false;
  Color enabled = const Color.fromARGB(255, 63, 56, 89);
  Color enabledtxt = Colors.white;
  Color desable = Colors.white;
  Color bgColor = const Color(0xFF4DB6AC);
  bool ispasswordev = true;
  FormData? selected;

  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  Future<bool> login(String username, String password) async {
    var exist = false;
    //_sqliteService = SqliteService();
    /* final users = await SqliteService().users();
    for (int i =0; i < users.length; i++) {
      User user = users[i];
      if (user.name == username || user.password == password) {
        exist = true;
      }
    } */
    return exist;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /* this._sqliteService = SqliteService();
    this._sqliteService.initializeDB();
    this._sqliteService.insertUser(user);
    this._sqliteService.insertUser(user1);
    this._sqliteService.insertUser(user2); */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE1F5FE).withOpacity(0.4),
              Color(0xFF03A9F4).withOpacity(0.8),
              Color(0xFF795543).withOpacity(0.4),
            ],
          ),
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Color(0xFFE1F5FE).withOpacity(0.4), BlendMode.dstATop),
            image: const AssetImage('lib/assets/img3.jpg'),
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 5,
                  color:
                      const Color.fromARGB(255, 172, 211, 250).withOpacity(0.5),
                  child: Container(
                    width: 400,
                    padding: const EdgeInsets.symmetric(vertical: 40.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              select = !select;
                            });
                          },
                          child: Center(
                            child: AnimatedContainer(
                              width: select ? 100.0 : 180.0,
                              height: select ? 100.0 : 100.0,
                              alignment: select
                                  ? Alignment.center
                                  : AlignmentDirectional.topCenter,
                              duration: const Duration(seconds: 2),
                              curve: Curves.fastOutSlowIn,
                              child: Image.asset(
                                'lib/assets/welcome.jpg',
                                fit: BoxFit.cover,
                                colorBlendMode: BlendMode.darken,
                                semanticLabel: "Bienvenue !",
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {});
                          },
                          child: Center(
                            child: Container(
                              //color: Colors.red,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: bgColor,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  TextFormField(
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                    keyboardType: TextInputType.text,
                                    controller: usernameController,
                                    onTap: () {
                                      selected = FormData.Email;
                                    },
                                    validator: (val) => val!.isEmpty
                                        ? 'Username invalide.'
                                        : null,
                                    decoration: const InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      border: InputBorder.none,
                                      prefixIcon: Icon(
                                        Icons.account_box,
                                        color: Colors.black,
                                      ),
                                      focusColor: Colors.red,
                                      hintText: "Username",
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {});
                          },
                          child: Center(
                            child: Container(
                              //color: Colors.red,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: bgColor,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  TextFormField(
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                    keyboardType: TextInputType.visiblePassword,
                                    controller: passwordController,
                                    onTap: () {
                                      selected = FormData.password;
                                    },
                                    validator: (val) => val!.isEmpty
                                        ? 'Mot de passe invalide.'
                                        : null,
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      border: InputBorder.none,
                                      prefixIcon: Icon(
                                        Icons.password,
                                        color: Colors.black,
                                      ),
                                      focusColor: Colors.red,
                                      hintText: "Password",
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextButton(
                          onPressed: () async {
                            if (usernameController.text.isEmpty ||
                                passwordController.text.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                      content: Text(
                                "Attention, les champs ne doivent pas être vide!",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.redAccent,
                                ),
                              )));
                            } else {
                              if (await login(usernameController.text,
                                  passwordController.text)) {
                                Navigator.pushNamed(context, '/dashboard');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Connexion réussit !",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.amber,
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                        content: Text(
                                  "Erreur, veuillez récommencer !",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.redAccent,
                                  ),
                                )));
                              }
                            }
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => bgColor)),
                          child: const Text(
                            "Connexion",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

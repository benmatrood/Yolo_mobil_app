// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:yolo/front/login.dart';
import 'package:yolo/pallette.dart';
import 'widgets/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

//
message(String msg) {
  return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}

// ignore: must_be_immutable
class Register extends StatelessWidget {
  TextEditingController username = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  final _key = GlobalKey<FormState>();
  Register({Key? key}) : super(key: key);

  get title => null;
  // fonction de vérification de validation
  void register(BuildContext context) async {
    //  message("Bonjour tout le monde ");
    if (_key.currentState!.validate()) {
      final response = await http.post(
          Uri.parse("https://projetyoyo.000webhostapp.com/file.php"),
          body: {
            'nom': username.text,
            'numero': number.text,
            'type': '1',
            'pass': password.text
          });

      if (response.statusCode == 200) {
        // If the server did return a 201 CREATED response,
        final data = jsonDecode(response.body);
        // on affiche le message de réussite
        if (data['val'] == 1) {
          message(data['statut']);
          // on redirige vers la page de login
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Login()),
          );
        } else {
          // Afficher ds un popup le message d'erreur
          message(data['statut']);
        }
      } else {
        throw Exception('Failed to create album.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BacgroundImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: SafeArea(
                child: Form(
              key: _key,
              child: Column(
                children: [
                  // ignore: sized_box_for_whitespace
                  Container(
                    height: 220,
                    child: const Center(
                      child: Text(
                        'YOYO',
                        style: tHeading,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // name container
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[600]?.withOpacity(.5),
                                borderRadius: BorderRadius.circular(18)),
                            child: TextFormField(
                              controller: username,
                              // vérification du remplisage du formulaire
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Le Nom ou Pseudo est obligatoire';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 10),
                                border: InputBorder.none,
                                prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                                hintText: 'Nom ou Pseudo',
                                hintStyle: tBodyText,
                              ),
                              style: tBodyText,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  // numéro container
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[600]?.withOpacity(.5),
                                borderRadius: BorderRadius.circular(18)),
                            child: TextFormField(
                              controller: number,
                              // vérification du remplisage du formulaire
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Le numéro est obligatoire';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 10),
                                border: InputBorder.none,
                                prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Icon(
                                    Icons.phone_iphone,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                                hintText: 'Numéro',
                                hintStyle: tBodyText,
                              ),
                              style: tBodyText,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  // password container

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[600]?.withOpacity(.5),
                                borderRadius: BorderRadius.circular(18)),
                            child: TextFormField(
                              controller: password,
                              // vérification du remplisage du formulaire
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Le mot de passe est obligatoire';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 10),
                                border: InputBorder.none,
                                prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                                hintText: 'Mot de passe',
                                hintStyle: tBodyText,
                              ),
                              obscureText: true, //pour chacher le mot de passe
                              style: tBodyText,
                              textInputAction: TextInputAction.done,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  // Confirm password container
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color:
                                            Colors.grey[600]?.withOpacity(.5),
                                        borderRadius:
                                            BorderRadius.circular(18)),
                                    child: TextFormField(
                                      controller: confirmPassword,
                                      // vérification du remplisage du formulaire
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Le mot de passe est obligatoire';
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        border: InputBorder.none,
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Icon(
                                            Icons.lock,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                        hintText: 'Confirmer mot de passe',
                                        hintStyle: tBodyText,
                                      ),
                                      obscureText:
                                          true, //pour chacher le mot de passe
                                      style: tBodyText,
                                      textInputAction: TextInputAction.done,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom:
                                      BorderSide(color: Colors.white, width: 1),
                                ),
                              ),
                              child: FlatButton(
                                onPressed: () {
                                  //  redirection vers la page de connexion
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Login()),
                                  );
                                },
                                child: const Text(
                                  "J'ai déjas un compte",
                                  style: tMdpText,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 90,
                            ),
                            Container(
                              width: 180,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(15, 105, 135, 1),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: FlatButton(
                                onPressed: () => register(context),
                                child: const Text(
                                  'Enregistrer',
                                  style: tBodyText,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
          ),
        ),
      ],
    );
  }
}

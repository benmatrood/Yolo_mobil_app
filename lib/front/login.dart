// ignore_for_file: deprecated_member_use

import 'dart:convert';
// import 'dart:html';
import 'package:flutter/material.dart';
import 'package:yolo/front/register.dart';
import 'package:yolo/pallette.dart';
import 'home.dart';
import 'widgets/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';



class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  // initiallisation des controllers des variables
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController number = TextEditingController();

  // Création des clés de validation
  final _key = GlobalKey<FormState>();

  // fonction de sauvegarde des données et session
  saveSession(Map user,int s) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    p.setString('user', json.encode(user));
    p.setInt('statut', s);
    p.commit();
  }

  int statut = 0;
  late Map user;

// Recupération des données de la session
  void getSession() async {
    SharedPreferences p = await SharedPreferences.getInstance();
    // Si la session existe
    if (p.get('statut')==1) {
      // On récupère les données de la session dans user
      setState(() {
        statut = 1;
        user = json.decode(p.getString('user').toString());
      });
    } else {
       setState(() {
        statut = 0;
      });
    }
  }

  // fonction de vérification de validation
  void login(BuildContext context) async {
    
 if (_key.currentState!.validate()) {
     final response = await http.post(Uri.parse("https://projetyoyo.000webhostapp.com/file.php"),
     body: {
      'nom': username.text,
      'numero': number.text,
      'type': '2',
      'pass':password.text
    }
     );

  //Vérifier si la connection est bonne
  if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // on vérifie si l'utilisateur est connecté
      if (data['val']== 1) {
        // on affiche le message de succès
        message(data['statut']);
        // on redirige vers la page d'accueil
         Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Login()));

        // on sauvegarde les données de la session
        saveSession(data['info'],1);

      }
      else{
        // Afficher ds un popup le message d'erreur
        message(data['statut']);
         // rediriger vers la page de login
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Login()),
          );
      }
    }
     else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Erreur d\'Authenticatoin');
    }
 }
  }
  // Fonction de déconnexion
  logout() async {
    // on récupère les données de la session
    SharedPreferences p = await SharedPreferences.getInstance();
    // on supprime la session
    setState(() {
     p.setString('user',(null).toString() );
     p.setInt('statut', 0);
     statut = 0;
     p.commit();
    });

    // on redirige vers la page de login
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
  }

// donction qui s'execute lors du changement de l'application
  @override
  void initState() {
    super.initState();
    getSession();
  }

  @override
  Widget build(BuildContext context) {
    if (statut==1) {
      return HomePage(user:user, singOut:logout);
    } else {
      
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
                    height: 200,
                    child: const Center(
                      child: Text(
                        'YOYO',
                        style: tHeading,
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
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
                    // password container
                  ),
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
                                      controller: password,
                                      // vérification du remplisage du formulaire  
                                      validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Le mot de est aubligatoire';
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
                                        hintText: 'Mot de passe',
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
                              decoration:const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.white,
                                    width: 1
                                  ),
                                ),
                              ),
                               child: FlatButton(onPressed:()=> getSession(),
                             child: const Text(
                              "Mot de passe oublier ?",
                              style: tMdpText,
                            ),
                             ),
                            ),
                           
                          ],
                        ),
                        Column(
                          children: [
                            // ignore: avoid_unnecessary_containers
                            const SizedBox(
                              height: 60,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(15, 105, 135, 1),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: FlatButton(
                                onPressed: ()=>login(context),
                                child: const Text(
                                  'Connexion',
                                  style: tBodyText,
                                ),
                              ),
                            ),
                             const SizedBox(
                              height: 100,
                            ),
                            // ignore: avoid_unnecessary_containers
                            Container(
                              decoration:const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.white,
                                    width: 1
                                  ),
                                ),
                              ),
                               child: FlatButton(onPressed: () { 
                                //  Redirection vers la page de création de compte
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Register()),
                                    );
                                },
                             child: const Text(
                              "Créer un compte",
                              style: tMdpText,
                            ),
                             ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),)
            ),
          ),
        ),
      ],
    );
    }
  }
}

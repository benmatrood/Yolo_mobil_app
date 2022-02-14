// ignore_for_file: deprecated_member_use, avoid_unnecessary_containers, unused_local_variable, prefer_adjacent_string_concatenation, avoid_print
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yolo/front/login.dart';
import 'package:yolo/pallette.dart';

// ignore: must_be_immutable
class ProfileView extends StatefulWidget {
  late Map user;
  final VoidCallback singOut;
  ProfileView({Key? key, required this.user, required this.singOut})
      : super(key: key);
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

//  Recupération des données de la session
void logOut(context) async {
  SharedPreferences p = await SharedPreferences.getInstance();
  p.clear();
  p.setString('user', (null).toString());
  p.setInt('statut', 0);
  p.commit();
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => const Login()));
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profil',
          style: balcktBodyText,
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
        centerTitle: true,
        // elevation: 10,
        backgroundColor: Colors.white,
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    ListTile(
                      title: Center(
                          child: Text(
                        '${widget.user['nom']}',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                    ),
                    ListTile(
                      title: Text(
                        'Mon numéro de téléphone',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        '${widget.user['numero']}',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Mon profil MTN',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'MTN Chic',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      height: 55,
                      width: double.infinity,
                      child: RaisedButton(
                        onPressed: () {
                          logOut(context);
                        },
                        color: Color(0xffFFCC00),
                        child: Center(
                          child: Text(
                            "Déconnexion",
                            style: TextStyle(
                              fontSize: 23,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          CustomPaint(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            painter: HeaderCurvedContainer(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // ignore: prefer_const_constructors
                padding: EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 5),
                  shape: BoxShape.circle,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 320, left: 180),
            child: CircleAvatar(
              backgroundColor: Colors.black54,
              child: IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ),
          )
        ],
      ),
      backgroundColor: Colors.grey[50],
    );
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Color(0xFFFAFAFA);
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 225, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

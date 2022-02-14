// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:yolo/front/widgets/blog_card.dart';
import 'package:yolo/pallette.dart';

// ignore: must_be_immutable
class HomeView extends StatefulWidget {
  // pour recevoir les données de user
  Map user;
  final VoidCallback singOut;
  HomeView({Key? key, required this.user, required this.singOut}) : super(key: key);
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // const HomeView({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accueil',
          style:balcktBodyText,
        ),actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings,color: Colors.black,),
            onPressed: (){},
          ),
        ],
        centerTitle: true,
        // elevation: 10,
        backgroundColor: Colors.white,
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: const BlogCard(
          title: ' Services mobiles',
          rating: 'MTN C’CHIC',
          cookTime: 'En savoir plus',
          thumbnailUrl: 'https://img-19.ccm2.net/WNCe54PoGxObY8PCXUxMGQ0Gwss=/480x270/smart/d8c10e7fd21a485c909a5b4c5d99e611/ccmcms-commentcamarche/20456790.jpg',
        ));
  }
}
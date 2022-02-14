// import 'package:flutter/cupertino.dart';
// ignore_for_file: unused_label, prefer_adjacent_string_concatenation, unused_local_variable, avoid_print, unnecessary_string_interpolations

import 'dart:convert';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:yolo/pallette.dart';
import 'package:http/http.dart' as http;
import 'package:speech_to_text/speech_to_text.dart' as stts;

class IaView extends StatefulWidget {
  const IaView({ Key? key }) : super(key: key);
  @override
  State<IaView> createState() => _IaViewState();
}

class _IaViewState extends State<IaView> {
  var _speechToText = stts.SpeechToText();
  bool islistening = false;
  String text = "Appuyez sur le bouton pour démarrer";
  void listen() async {
    if(!islistening){
      bool avalable =await _speechToText.initialize(
        onStatus: (statut)=> print("$statut"),
        onError: (errorNotification)=> print("$errorNotification"),
      );
      if(avalable){
        setState(() {
          islistening = true;
        });   
        _speechToText.listen(
          onResult: (result)=> setState(() {
            listenFor: const Duration(seconds: 10);
            text = result.recognizedWords;
             setState(() {
                 islistening = false;
                PostData();
              });
          }),
        );
      }
    }else{
        setState(() {
          islistening = false;
        });
        _speechToText.stop();
    }
  }

  // execute syntaxe function
  void executSyntaxe(number) async {
  await FlutterPhoneDirectCaller.callNumber(number);
  }

// ignore: non_constant_identifier_names
void PostData() async {
  var url = 'https://mamasy.herokuapp.com/yoyo/';
  var request= text;
  var stt= "?sentence=";
  try {
     final response = await http.get(Uri.parse("$url"+"$stt"+"$request")
    ).then((response) {
        var data = response.body;
        Map valueMap = json.decode(data);
        if (valueMap['syntaxe']==null) {
        } else {
          executSyntaxe(valueMap['syntaxe']);
        }
      });
  } catch (e) {
    print(e);
  }
 }


// fonction d'initialisation
  @override
  void initState() {
    super.initState();
     _speechToText = stts.SpeechToText();
    
  }

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Scaffold(
       appBar: AppBar(
        title: const Text('Assistant vocal',
          style:balcktBodyText,
        ),actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings,color: Colors.black,),
            onPressed: (){}
          ),
        ],
        centerTitle: true,
        // elevation: 10,
        backgroundColor: Colors.white,
        leading: const BackButton(
          color: Colors.black,
        ),
    ),
    // ignore: avoid_unnecessary_containers
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        // ignore: avoid_unnecessary_containers
        child: Container(
          child: Text(text,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w900,
              color: Colors.black,
              
            ),
          ),
        ),
      ),
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    floatingActionButton: AvatarGlow(
      animate: islistening,
      repeat: true,
      endRadius: 80,
      duration: const Duration(seconds: 1),
      glowColor: Colors.red,
      child: FloatingActionButton(
        onPressed: (){
          listen();
        },
        child: Icon(islistening ? Icons.mic : Icons.mic_none ),
        backgroundColor: const Color.fromRGBO(255, 204, 0, 1),
      ),
    ),
    // );
    );
}
}
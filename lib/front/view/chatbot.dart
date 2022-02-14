// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:yolo/pallette.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class ChatBotView extends StatefulWidget {
  const ChatBotView({Key? key}) : super(key: key);
  static const String BOT_URL = 'https://yoyo-flask-api.herokuapp.com/toto';

  @override
  State<ChatBotView> createState() => _ChatBotViewState();
}

class _ChatBotViewState extends State<ChatBotView> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  final List<String> _daata = [];

  TextEditingController queryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ChatBot',
          style: balcktBodyText,
        ),
        centerTitle: true,
        // elevation: 10,
        backgroundColor: Colors.white,
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: Stack(
        children: [
          AnimatedList(
            key: _listKey,
            initialItemCount: _daata.length,
            itemBuilder:
                (BuildContext context, int index, Animation<double> animation) {
              return buildItem(_daata[index], animation, index);
            },
          ),
          // TextField to enter message
          Align(
            alignment: Alignment.bottomCenter,
            child: ColorFiltered(
              colorFilter: const ColorFilter.linearToSrgbGamma(),
              child: Container(
                padding: const EdgeInsets.all(8),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextField(
                    // controller: queryController,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.message,
                        size: 40,
                        color: Color(0xffFFCC00),
                      ),
                      hintText: 'Message',
                      fillColor: Colors.white,
                    ),
                    controller: queryController,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (msg) {
                      getResponse(msg);
                      queryController.clear();
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.grey[200],
    );
  }
  // execute syntaxe function

  void executSyntaxe(number) async {
    await FlutterPhoneDirectCaller.callNumber(number);
  }

  // create Response
  void getResponse(String msg) async {
    if (queryController.text.isNotEmpty) {
      insertSingleItem(queryController.text);
      var client = getClient();
      try {
        // ignore: avoid_single_cascade_in_expression_statements
        client.post(Uri.parse(ChatBotView.BOT_URL),
            body: {'query': queryController.text})
          ..then((response) {
            Map<String, dynamic> data = json.decode(response.body);
            // executSyntaxe(data['reponse']);
            // print(data['reponse']);
            insertSingleItem(data['reponse'] + "<bot>");
          });
      } finally {
        client.close();
        queryController.clear();
      }
    }
  }

// inset single item
  void insertSingleItem(String message) {
    _daata.add(message);
    _listKey.currentState!.insertItem(_daata.length - 1);
  }

  //get client
  http.Client getClient() {
    return http.Client();
  }
}

Widget buildItem(String item, Animation<double> animation, int index) {
  bool mine = item.endsWith('<bot>');
  return SizeTransition(
    sizeFactor: animation,
    child: Padding(
      // padding: const EdgeInsets.only(top:10),
      padding: const EdgeInsets.all(10),
      child: Container(
        alignment: mine ? Alignment.topLeft : Alignment.topRight,
        child: Bubble(
          child: Text(
            item.replaceAll('<bot>', ""),
            style: TextStyle(
              color: mine ? Colors.black : Colors.black,
              fontSize: 20,
            ),
          ),
          color: mine ? Colors.yellow : Colors.white,
          padding: const BubbleEdges.all(10),
        ),
      ),
    ),
  );
}


// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class User extends StatelessWidget {
  const User({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: RaisedButton(
        onPressed: _callNumber,
        child: Text('Call Number'),
      ),
    ),
  );
  }
}

_callNumber() async{
  const number = '08592119'; //set the number here
  await FlutterPhoneDirectCaller.callNumber(number);
}
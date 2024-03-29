import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String baseURL = 'http://fast-coast-41741.herokuapp.com/api/';
const String baseURLnoAPI = 'www.fast-coast-41741.herokuapp.com';
const Map<String, String> headers = {"Content-Type": "application/json"};

errorSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.red,
    content: Text(text),
    duration: const Duration(seconds: 1),
  ));
}

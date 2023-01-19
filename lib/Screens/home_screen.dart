import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:students/Services/auth_services.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _text = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Text(_text),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // setState(() {
      //   _text = prefs.getString('token')!;
      // });
      http.Response response = await AuthServices.details();
      Map responseMap = jsonDecode(response.body);
      if (responseMap['user_type_id'] == 2) {
        setState(() {
          // ignore: prefer_interpolation_to_compose_strings
          _text = "Helo " + responseMap['name'];
        });
      }
    });
  }
}

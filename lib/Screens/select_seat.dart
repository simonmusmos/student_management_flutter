import 'dart:developer';
import 'dart:io';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:students/Screens/select_seat.dart';

// void main() => runApp(const MaterialApp(home: MyHome()));

class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Demo Home Page')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const SelectSeat(),
            ));
          },
          child: const Text('qrView'),
        ),
      ),
    );
  }
}

class SelectSeat extends StatefulWidget {
  const SelectSeat({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SelectSeatState();
}

class _SelectSeatState extends State<SelectSeat> {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
    );
  }
}

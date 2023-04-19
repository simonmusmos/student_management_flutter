import 'dart:developer';
import 'dart:io';
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:students/Services/auth_services.dart';
import 'package:students/Screens/teacher/widgets/navbar.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Services/global.dart';

class t_main_screen extends StatefulWidget {
  const t_main_screen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<t_main_screen> {
  bool _isLoading = false;
  int ctr = 0;
  List seat_list = [];
  List occupied = [];
  String selected_seat = "";
  String selected_row = "";
  String owner_info = "";
  String _selected = "";
  String _selected_seat = "";
  Color button_color = Colors.black;
  Color seat_color = Colors.green;
  List dummyList = [];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
            ),
            drawer: navbar(),
            body: ListView.builder(
              itemExtent: 80,
              itemBuilder: (context, index) {
                return ListTile(
                    title: Text(
                  dummyList[index],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ));
              },
              itemCount: dummyList.length,
            )
            // SafeArea(
            //     child: Center(
            //         child: Column(
            //   // ignore: prefer_const_constructors
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   children: [
            //     SizedBox(height: 20),
            //     Text(
            //       'Hello! please select a section to continue ',
            //       style: TextStyle(fontSize: 21, fontFamily: 'BebasNeue'),
            // style: GoogleFonts.bebasNeue(
            //   fontSize: 54,
            // ),
            // ),
            // SizedBox(height: 5),
            // ListView.builder(
            //     itemExtent: 80,
            //     itemBuilder: (context, index) {
            //       return ListTile(title: Text(dummyList[index]));
            //     },
            //     itemCount: dummyList.length,)
            // ListView.builder(
            //   itemCount: _pairList.length,
            //   itemBuilder: (BuildContext context, int index) {
            //     print(123);
            //     // TODO: Display the list items and load more when needed
            //     return ListTile(
            //       leading: Text(index.toString(),
            //           style: TextStyle(fontWeight: FontWeight.bold)),
            //       title: Text(_pairList[index].toString(),
            //           style: TextStyle(fontWeight: FontWeight.bold)),
            //     );
            //   },
            // )
            // ],
            // ))),
            ),
        if (_isLoading)
          const Opacity(
            opacity: 0.8,
            child: ModalBarrier(dismissible: false, color: Colors.black),
          ),
        if (_isLoading)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }

  CheckSeat(seat) async {
    setState(() {
      _isLoading = true;
    });

    http.Response response = await AuthServices.getSeatInfo(seat, '1');
    bool status = jsonDecode(response.body)['status'];
    setState(() {
      if (jsonDecode(response.body)['status'] == true) {
        _selected_seat = seat;
        owner_info = "";
      } else {
        _selected_seat = "";
        owner_info = "Owner: " + jsonDecode(response.body)['owner'];
      }

      print(owner_info);

      _isLoading = false;
    });
  }

  UpdateSeats() async {
    setState(() {
      _isLoading = true;
    });

    http.Response response = await AuthServices.getSeats();
    List responseMap = jsonDecode(response.body)['seats'];
    List occupiedMap = jsonDecode(response.body)['occupied'];
    setState(() {
      _isLoading = false;
      seat_list = responseMap;
      occupied = occupiedMap;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      print(123);
      dummyList = List.generate(7, (index) => "Item : ${index + 1}");
      print(dummyList);
      // UpdateSeats();
    });
  }
}

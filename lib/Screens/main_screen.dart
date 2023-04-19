import 'dart:developer';
import 'dart:io';
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:students/Services/auth_services.dart';
import 'package:students/widgets/navbar.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Services/global.dart';

class main_screen extends StatefulWidget {
  const main_screen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<main_screen> {
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
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
          ),
          drawer: navbar(),
          body: SafeArea(
              child: Center(
                  child: Column(
            // ignore: prefer_const_constructors
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              Text(
                'Hello! Welcome to section ',
                style: TextStyle(fontSize: 21, fontFamily: 'BebasNeue'),
                // style: GoogleFonts.bebasNeue(
                //   fontSize: 54,
                // ),
              ),
              SizedBox(height: 5),
              Text(
                "Select a seat to check it's information",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                // style: GoogleFonts.bebasNeue(
                //   fontSize: 54,
                // ),
              ),
              SizedBox(height: 50),
              ...List.generate(6, (row) {
                return Wrap(
                  alignment: WrapAlignment.spaceEvenly,
                  children: List.generate(10, (col) {
                    ctr += 1;
                    String _seat = "";
                    if (col < 5) {
                      _seat = "a-" +
                          (row + 1).toString() +
                          "-" +
                          (col + 1).toString();
                    } else {
                      _seat = "b-" +
                          (row + 1).toString() +
                          "-" +
                          ((col + 1) - 5).toString();
                    }
                    // if (seat_list.contains(_seat)) {
                    // if (_selected == _seat) {
                    //   return Padding(
                    //     padding: const EdgeInsets.all(3),
                    //     child: InkWell(
                    //       onTap: () {
                    //         String seat = "";
                    //         if (col < 5) {
                    //           seat = "a-" +
                    //                (row + 1).toString() +
                    //               "-" +
                    //               (col + 1).toString();
                    //         } else {
                    //           seat = "b-" +
                    //               (row + 1).toString() +
                    //               "-" +
                    //               ((col + 1) - 5).toString();
                    //         }
                    //         // UpdateSeats();
                    //         // CheckSeat(seat);
                    //         setState(() {
                    //           _selected = seat;
                    //           selected_row = "Row: " + (row + 1).toString();
                    //           selected_seat =
                    //               "Seat Number: " + (col + 1).toString();
                    //         });
                    //       }, // Handle your callback
                    //       child: Ink(
                    //         height: 30,
                    //         width: 30,
                    //         color: Colors.blue,
                    //       ),
                    //     ),
                    //   );
                    // }
                    //  else {
                    // return Padding(
                    //   padding: const EdgeInsets.all(3),
                    //   child: InkWell(
                    //     onTap: () {
                    //       String seat = "";
                    //       if (col < 5) {
                    //         seat = "a-" +
                    //             (row + 1).toString() +
                    //             "-" +
                    //             (col + 1).toString();
                    //       } else {
                    //         seat = "b-" +
                    //             (row + 1).toString() +
                    //             "-" +
                    //             ((col + 1) - 5).toString();
                    //       }
                    //       // UpdateSeats();
                    //       // CheckSeat(seat);
                    //       setState(() {
                    //         _selected = seat;
                    //         selected_row = "Row: " + (row + 1).toString();
                    //         selected_seat =
                    //             "Seat Number: " + (col + 1).toString();
                    //       });
                    //     }, // Handle your callback
                    //     child: Ink(
                    //       height: 30,
                    //       width: 30,
                    //       color: Colors.green,
                    //     ),
                    //   ),
                    // );
                    // }
                    // } else
                    if (occupied.contains(_seat)) {
                      if (_selected == _seat) {
                        return Padding(
                          padding: const EdgeInsets.all(3),
                          child: InkWell(
                            onTap: () {
                              String seat = "";
                              if (col < 5) {
                                seat = "a-" +
                                    (row + 1).toString() +
                                    "-" +
                                    (col + 1).toString();
                              } else {
                                seat = "b-" +
                                    (row + 1).toString() +
                                    "-" +
                                    ((col + 1) - 5).toString();
                              }
                              // UpdateSeats();
                              // CheckSeat(seat);
                              setState(() {
                                _selected = seat;
                                selected_row = "Row: " + (row + 1).toString();
                                selected_seat =
                                    "Seat Number: " + (col + 1).toString();
                              });
                            }, // Handle your callback
                            child: Ink(
                              height: 30,
                              width: 30,
                              color: Colors.blue,
                            ),
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(3),
                          child: InkWell(
                            onTap: () {
                              String seat = "";
                              if (col < 5) {
                                seat = "a-" +
                                    (row + 1).toString() +
                                    "-" +
                                    (col + 1).toString();
                              } else {
                                seat = "b-" +
                                    (row + 1).toString() +
                                    "-" +
                                    ((col + 1) - 5).toString();
                              }
                              CheckSeat(seat);
                              setState(() {
                                _selected = seat;
                                selected_row = "Row: " + (row + 1).toString();
                                selected_seat =
                                    "Seat Number: " + (col + 1).toString();
                              });
                            }, // Handle your callback
                            child: Ink(
                              height: 30,
                              width: 30,
                              color: Colors.green,
                            ),
                          ),
                        );
                      }
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(3),
                        child: InkWell(
                          onTap: () {}, // Handle your callback
                          child: Ink(
                            height: 30,
                            width: 30,
                            color: Colors.white12,
                          ),
                        ),
                      );
                    }
                  }),
                );
              }),
              SizedBox(height: 20),
              Text(
                selected_row,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                selected_seat,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                owner_info,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 50),
            ],
          ))),
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
      UpdateSeats();
    });
  }
}

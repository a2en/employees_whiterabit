import 'dart:convert';

import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final Map<String, Object?>? employee;

  const DetailPage({Key? key, required this.employee}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:Center(
        child: Column(
          children: [
          SizedBox(height: 30.0,),
          CircleAvatar(
            backgroundColor: Colors.white,
            child: ClipRect(
              child: Image.network(
                widget.employee!['profile_image'].toString()??"",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Name : ${widget.employee!['name']}"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Username : ${widget.employee!["username"]}"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Email : ${widget.employee!["email"]}"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Phone : ${widget.employee!["phone"]}"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("website : ${widget.employee!["website"]}"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Address : ${jsonDecode(widget.employee!["address"].toString())['city']}"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Company name : ${jsonDecode(widget.employee!["company"].toString())['name']}"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Catch phrase : ${jsonDecode(widget.employee!["company"].toString())['catchPhrase']}"),
          ),
        ],),
      ),
    );
  }
}

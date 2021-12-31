import 'dart:convert';

import 'package:employees_app/api/api.dart';
import 'package:employees_app/constants/app_constants.dart';
import 'package:employees_app/db/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:no_context_navigation/no_context_navigation.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var isLoading = false;
  List<Map<String, Object?>>? items = [];
  List<Map<String, Object?>>? duplicateItems = [];

  @override
  void initState() {
    super.initState();
    _loadFromApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employees'),
        centerTitle: true,
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon: Icon(Icons.settings_input_antenna),
              onPressed: () async {
                await _loadFromApi();
              },
            ),
          ),
        ],
      ),
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : _buildEmployeeListView(),
    );
  }

  _loadFromApi() async {
    setState(() {
      isLoading = true;
    });

    var apiProvider = Api();
    await apiProvider.getAllEmployees();

    // wait for 2 seconds to simulate loading of data
    await Future.delayed(const Duration(seconds: 2));


    var values = await DBProvider.db.getAllEmployees();
    items!.addAll(values!);
    duplicateItems!.addAll(items!);
    setState(() {
      isLoading = false;
    });
  }

  void filterSearchResults(String query) {
    List<Map<String, Object?>> dummySearchList =[];
    dummySearchList.addAll(items!);
    if (query.isNotEmpty) {
      List<Map<String, Object?>> dummyListData = [];
      dummySearchList.forEach((item) {
        if (item['name'].toString().toLowerCase().startsWith(query.toLowerCase())) {
          dummyListData.add(item);
        }
        if (item['email'].toString().toLowerCase().startsWith(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items?.clear();
        items?.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items?.clear();
        items?.addAll(duplicateItems!);
      });
    }
  }

  _buildEmployeeListView() {
    TextEditingController editingController = TextEditingController();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) {
              filterSearchResults(value);
            },
            decoration: InputDecoration(
                labelText: "Search",
                hintText: "Search",
                fillColor: Colors.blueGrey,
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)))),
          ),
        ),
        Expanded(
          child: ListView.separated(
            separatorBuilder: (context, index) =>
                Divider(
                  color: Colors.black12,
                ),
            itemCount: items?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              print(items![index]);
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: ClipRect(
                    child: Image.network(
                      items![index]['profile_image'].toString() ?? "",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                onTap: () {
                  navService.pushNamed(RoutePaths.Detail,
                      args: items![index]);
                },
                title: Text('Name: ${items![index]['name']}'),
                subtitle: Text(
                    'COMPANY: ${jsonDecode(items![index]["company"]?.toString() ??
                        "{\"name\" : \"nil\" }")['name']} '),
              );
            },
          ),
        ),
      ],
    );
  }
}

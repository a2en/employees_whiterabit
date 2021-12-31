

import 'package:dio/dio.dart';
import 'package:employees_app/db/db_provider.dart';
import 'package:employees_app/models/employee.dart';

class Api{
  Future<List<Null>> getAllEmployees() async {
    var url = "http://www.mocky.io/v2/5d565297300000680030a986";
    Response response = await Dio().get(url);

    var employees = response.data as List;
    return employees.map((employee){
      print('Inserting $employee');
      DBProvider.db.createEmployee(Employee.fromJson(employee));
    }).toList();
  }
}
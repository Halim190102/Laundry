import 'package:dio/dio.dart';

class DataAPI {
  final url = 'https://my-app-97dac-default-rtdb.firebaseio.com/';
  Future<List> getData() async {
    final response = await Dio().get(url);
    List data = (response.data as List);
    return data;
  }
}

import 'package:flutter/cupertino.dart';
import 'package:mini_project/Api/api.dart';
import 'package:mini_project/Model/model_data.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class DataManager with ChangeNotifier {
  final _allData = <IsiData>[];
  final urls = DataAPI().url;

  List<IsiData> get allData => _allData;

  int get jumlahData => _allData.length;

  addData(
      String baju, String celana, String harga, String uid, String icon) async {
    DateTime dateTimeNow = DateTime.now();
    try {
      final response = await Dio().post(
        urls + '$uid.json',
        data: {
          'baju': baju,
          'celana': celana,
          'harga': harga,
          'icon': icon,
          'createdAt': DateFormat("d MMM, hh:mm:ss").format(dateTimeNow),
        },
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        _allData.add(
          IsiData(
            id: response.data['name'].toString(),
            baju: baju,
            celana: celana,
            harga: harga,
            icon: icon,
            createdAt: DateFormat("d MMM, hh:mm:ss").format(dateTimeNow),
          ),
        );
        notifyListeners();
      } else {
        throw ('${response.statusCode}');
      }
    } catch (error) {
      rethrow;
    }
  }

  deleteData(String id, String uid) async {
    try {
      final response = await Dio().delete(urls + '$uid/$id.json');
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        _allData.removeWhere((element) => element.id == id);
        notifyListeners();
      } else {
        throw ('${response.statusCode}');
      }
    } catch (error) {
      rethrow;
    }
  }

  Future initialData(String uid) async {
    final dataRes = await Dio().get(urls + '$uid.json');
    final dataResponse = dataRes.data;
    if (dataResponse != null) {
      dataResponse.forEach(
        (key, value) {
          _allData.add(
            IsiData(
              createdAt: value['createdAt'],
              id: key,
              baju: value['baju'],
              celana: value['celana'],
              harga: value['harga'],
              icon: value['icon'],
            ),
          );
        },
      );
      notifyListeners();
    }
  }
}

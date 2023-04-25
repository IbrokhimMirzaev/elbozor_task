import 'package:dio/dio.dart';
import 'package:elbozor_task/data/models/data_model.dart';
import 'package:elbozor_task/utils/constants/constants.dart';

class MyRepo {
  Future<List<DataModel>> fetchData({required int page}) async {
    try {
      final response = await Dio().get("$BASE_URL?page=$page");

      if (response.statusCode == 200) {
        List<DataModel> allData = (response.data['data'] as List).map((data) => DataModel.fromJson(data)).toList();
        return allData;
      } else {
        throw Exception();
      }
    }
    catch (e) {
      print("EXCEPTION: $e");
      throw Exception(e);
    }
  }
}

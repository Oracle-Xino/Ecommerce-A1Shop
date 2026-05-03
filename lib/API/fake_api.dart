import 'dart:convert';

import 'package:a1shop/MODEL/model_cafe.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod/riverpod.dart';

class FakeApi {
  Future<CafeBody> fetchApi() async {
    var url = Uri.parse('https://dummyjson.com/products');

    var resposes = await http.get(url);
    if (resposes.statusCode == 200) {
      var data = jsonDecode(resposes.body);
      return CafeBody.fromJson(data);
    }
    throw Exception('Failed Error ${resposes.statusCode}');
  }

  Future<CafeBody> fetchApiCategory(String category) async {
    var url = Uri.parse(
      'https://dummyjson.com/products/products/category/$category',
    );

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return CafeBody.fromJson(data);
    }
    throw Exception('Error detected ${response.statusCode}');
  }
}

final dataProvider = FutureProvider((ref) async => await FakeApi().fetchApi());
final categoryProvider = FutureProvider.family<CafeBody, String>(
  (ref, category) async => await FakeApi().fetchApiCategory(category),
);

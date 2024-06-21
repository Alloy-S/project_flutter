import 'dart:convert';
import 'package:admins/models/rajaongkir_kota_model.dart';
import 'package:admins/models/rajaongkir_province_model.dart';
import 'package:http/http.dart' as http;

class RajaOngkirService {
  static const keyAPI = '148b168028316310f623f0d0b06750e3';

  static Future<List<dynamic>> fetchProvince() async {
    const url = "https://api.rajaongkir.com/starter/province";
    final uri = Uri.parse(url);
    final response = await http.get(uri, headers: {'key': keyAPI});
    final body = response.body;
    final json = jsonDecode(body);

    final result = json as Map<String, dynamic>;
    // final transformed = result.map((e) {
    // }.;

    final hasil = result['rajaongkir']['results'].map((e) {
      return Result(
        provinceId: e['province_id'],
        province: e['province'],
      );
    }).toList();
    
    // for (Result item in hasil) {
    //   print('${item.provinceId}, ${item.province}');
    // }

    return hasil;
  }

  static Future<List<dynamic>> fetchKota(provinceId) async {
    var url = "https://api.rajaongkir.com/starter/city?province=$provinceId";
    final uri = Uri.parse(url);
    final response = await http.get(uri, headers: {'key': keyAPI});
    final body = response.body;
    final json = jsonDecode(body);

    final result = json as Map<String, dynamic>;
    final hasil = result['rajaongkir']['results'].map((e) {
      return ResultKota(
        cityId: e['city_id'],
        provinceId: e['province_id'],
        province: e['province'],
        type: e['type'],
        cityName: e['city_name'],
        postalCode: e['postal_code']
      );
    }).toList();

    // for (ResultKota item in hasil) {
    //   print('${item.type}, ${item.cityName}');
    // }

    return hasil;
  }
}

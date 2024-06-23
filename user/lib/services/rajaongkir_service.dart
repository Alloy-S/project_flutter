import 'dart:convert';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/models/rajaongkir_kota_model.dart';
import 'package:emart_app/models/rajaongkir_province_model.dart';
import 'package:emart_app/models/rajaongkir_cost_model.dart';
import 'package:http/http.dart' as http;

class RajaOngkirService {
  // static const keyAPI = '148b168028316310f623f0d0b06750e3'; // alloy-s
  static const keyAPI = 'b60c428282f35a54007014075c833da0'; // alloy-stv

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
          postalCode: e['postal_code']);
    }).toList();

    // for (ResultKota item in hasil) {
    //   print('${item.type}, ${item.cityName}');
    // }

    return hasil;
  }

  static checkAllCost({origin, destination, weight}) async {
    const url = 'https://api.rajaongkir.com/starter/cost';
    final uri = Uri.parse(url);
    var allCost = [];
    for (var item in courierAvailable) {
      
      var response = await http.post(uri, headers: {
        'key': keyAPI
      }, body: {
        'origin': origin,
        'destination': destination,
        'weight': weight,
        'courier': item,
      });
      final body = response.body;
      final json = jsonDecode(body);
      
      // final result = json as Map<String, dynamic>;
      final hasil = RajaongkirCost.fromJson(json);
      // print(hasil.rajaongkir.results);
      for (Result2 item in hasil.rajaongkir!.results) {
        allCost.add(item);
        // for (ResultCost cost in item.costs) {
        //   print(cost.description);
        // }
          
      }
      // final hasil = result['rajaongkir']['results'].map((e) {
      //   // return Raja
      // }).toList();
    }

    return allCost;
  }
}

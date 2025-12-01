import 'package:http/http.dart' as http;
import 'package:sqlitedemo/stockModel.dart';
import 'constants.dart';
import 'dart:developer';

class ApiService {
  Future<StockModel?> getStocks(String symbol) async {
    try {
      var url = Uri.parse('${ApiConstants.baseURL}?symbol=$symbol&apikey=${ApiConstants.apiKey}');
      print(" Calling API: $url");
      var response = await http.get(url);

      print("Response Code: ${response.statusCode}");
      print("Body: ${response.body}");

      if (response.statusCode == 200) {
        final list = stockModelFromJson(response.body);
        print("Decoded List Length: ${list.length}");

        if (list.isNotEmpty) {
          print("Returning stock: ${list.first.symbol}");
          return list.first;
        }
        print('not working');
      }
      return null;
    } catch (e) {
      log(e.toString());
    }
  }
}

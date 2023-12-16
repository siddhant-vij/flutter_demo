import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:logger/logger.dart';

class NetworkHelper {
  final String url;
  var logger = Logger();

  NetworkHelper(this.url);

  Future<dynamic> getData() async {
    try {
      final response = await http.get(
        Uri.parse(url),
      );
      if (response.statusCode == 200) {
        String data = response.body;
        logger.i('Data fetched from network');
        return jsonDecode(data);
      } else {
        logger.e('Request failed with status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      logger.e('Failed to get data', error: e);
      return null;
    }
  }
}

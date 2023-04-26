import 'dart:convert';

import 'package:http/http.dart' as http;

Future<List<dynamic>> apiGetPhotos() async {
  var response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
  if (response.statusCode == 200) {
    var list = jsonDecode(response.body) as List<dynamic>;
    var listRange = list.getRange(0, 14).toList();

    return listRange;
  } else {
    throw Exception('Error');
  }
}

Future<Map<String, dynamic>> apiGetPhotoById(int id) async {
  var response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/photos/$id'));
  if (response.statusCode == 200) {
    var map = jsonDecode(response.body) as Map<String, dynamic>;
    return map;
  } else {
    throw Exception('Error');
  }
}

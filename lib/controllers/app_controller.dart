import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:app_flutter/models/model_image.dart';

class FetchImageList {
  var data = [];
  List<Imagelist> results = [];
  String urlList =
      'https://api.unsplash.com/photos/?per_page=3&order_by=popular&client_id=3FJiDFfSIQ0qqmw9ZszABVFBWmzwLPAD60o5qGtEXtU';

  Future<List<Imagelist>> getImagelist({String? query}) async {
    var url = Uri.parse(urlList);
    try {
      var response = await http.get(url);
      data = json.decode(response.body);

      if (response.statusCode == 200) {
        data = json.decode(response.body);
        results = data.map((e) => Imagelist.fromJson(e)).toList();
        if (query != null) {
          results = results
              .where((element) => element.alt_description!
                  .toLowerCase()
                  .contains((query.toLowerCase())))
              .toList();
        }
      } else {
        print("fetch error");
      }
    } on Exception catch (e) {
      print('error: $e');
    }
    return results;
  }
}

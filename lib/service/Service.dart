import 'dart:convert';

import '../model/NewsApp.dart';
import 'package:http/http.dart' as http;

class Services {

  static Future<List<NewsModel>?> getnew() async {
    final url = Uri.parse(
      'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=4cd5cc16c7564f7c9aaf3e306f770b8e',
    );

    final respone = await http.get(url);
    final json = jsonDecode(respone.body);
    if (json['status'] == 'ok') {

      var articles = json['articles'] as List;

      return articles.map((NewApp) => NewsModel.fromJson(NewApp)).toList();
    } else {
      print(respone.body);
    }
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:newsapp/model/news_model.dart';
import 'package:newsapp/util/failure.dart';
import 'package:http/http.dart' as http;

class ApiCallClass {

  Future<List<Articles>> getNews() async {
    try {
      final news = await http.get(
      Uri.parse(
          "https://newsapi.org/v2/everything?q=tesla&from=2021-05-12&sortBy=publishedAt&apiKey=ac3ca8d9f1f44815879eec21c51efadf" ),
  );
      if (news.statusCode == 200) {
        final Iterable rawJson = jsonDecode(news.body)["articles"];
        return rawJson.map((article) => Article.fromJson{article}).toList();
      } else {
        throw Failure(message: error.toString());
  }
    }on SocketException {
      throw Failure(message: "You don't have internet access");
    } catch (error) {
      throw Failure(message: error.toString());
    }
}
}
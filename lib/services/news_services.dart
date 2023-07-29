import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:maos/models/news_model.dart';
import 'package:maos/theme.dart';

class NewsService {
  Future<List<NewsModel>> getNews(String category) async {
    try {
      final randomKey = apikey[Random().nextInt(apikey.length)];
      final res = await http.get(
        Uri.parse(
          'https://newsdata.io/api/1/news?country=id&category=$category&apikey=$randomKey',
        ),
      );
      if (res.statusCode == 200) {
        return List<NewsModel>.from(jsonDecode(res.body)['results']
            .map((news) => NewsModel.fromJson(news))).toList();
      } else {
        throw jsonDecode(res.body)['results']['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<NewsModel>> hotNews() async {
    try {
      final randomKey = apikey[Random().nextInt(apikey.length)];
      final res = await http.get(
        Uri.parse(
          'https://newsdata.io/api/1/news?country=id&apikey=$randomKey',
        ),
      );
      if (res.statusCode == 200) {
        return List<NewsModel>.from(jsonDecode(res.body)['results']
            .map((news) => NewsModel.fromJson(news))).toList();
      } else {
        throw jsonDecode(res.body)['results']['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<NewsModel>> searchNews(String search) async {
    try {
      final randomKey = apikey[Random().nextInt(apikey.length)];
      final res = await http.get(
        Uri.parse(
          'https://newsdata.io/api/1/news?apikey=$randomKey&qInTitle=$search',
        ),
      );
      if (res.statusCode == 200) {
        return List<NewsModel>.from(jsonDecode(res.body)['results']
            .map((news) => NewsModel.fromJson(news))).toList();
      } else {
        throw jsonDecode(res.body)['results']['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<NewsModel>> recommendNews() async {
    try {
      final randomKey = apikey[Random().nextInt(apikey.length)];
      final randomCategory =
          newsCategory[Random().nextInt(newsCategory.length)];
      final res = await http.get(
        Uri.parse(
          'https://newsdata.io/api/1/news?country=id&category=$randomCategory&apikey=$randomKey',
        ),
      );
      if (res.statusCode == 200) {
        return List<NewsModel>.from(jsonDecode(res.body)['results']
            .map((news) => NewsModel.fromJson(news))).toList();
      } else {
        throw jsonDecode(res.body)['results']['message'];
      }
    } catch (e) {
      rethrow;
    }
  }
}

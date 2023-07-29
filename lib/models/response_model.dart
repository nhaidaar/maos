import 'package:maos/models/news_model.dart';

class ResponseModel {
  final int? totalResults;
  final NewsModel? results;
  final String? nextPage;

  ResponseModel({
    this.totalResults,
    this.results,
    this.nextPage,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        totalResults: json['totalResults'],
        results: json['results'] == null
            ? null
            : NewsModel.fromJson(json['results']),
        nextPage: json['nextPage'],
      );
}

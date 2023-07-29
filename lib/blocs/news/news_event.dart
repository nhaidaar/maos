part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

class NewsGet extends NewsEvent {
  final String category;
  const NewsGet(this.category);

  @override
  List<Object> get props => [category];
}

class NewsSearch extends NewsEvent {
  final String search;
  const NewsSearch(this.search);

  @override
  List<Object> get props => [search];
}

class NewsRecommend extends NewsEvent {}

class NewsHot extends NewsEvent {}

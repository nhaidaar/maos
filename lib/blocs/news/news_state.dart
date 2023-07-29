part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsFailed extends NewsState {
  final String e;
  const NewsFailed(this.e);

  @override
  List<Object> get props => [e];
}

class NewsSuccess extends NewsState {
  final List<NewsModel> data;
  const NewsSuccess(this.data);

  @override
  List<Object> get props => [data];
}

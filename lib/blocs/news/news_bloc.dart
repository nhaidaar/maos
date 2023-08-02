import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:maos/models/news_model.dart';
import 'package:maos/services/news_services.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsInitial()) {
    on<NewsEvent>((event, emit) async {
      if (event is NewsGet) {
        try {
          emit(NewsLoading());
          final data = await NewsService().getNews(event.category);
          emit(NewsSuccess(data));
        } catch (e) {
          emit(NewsFailed(e.toString()));
        }
      }
      if (event is NewsSearch) {
        try {
          emit(NewsLoading());
          final data = await NewsService().searchNews(event.search);
          emit(NewsSuccess(data));
        } catch (e) {
          emit(NewsFailed(e.toString()));
        }
      }
      if (event is NewsRecommend) {
        try {
          emit(NewsLoading());
          final data = await NewsService().recommendNews();
          emit(NewsSuccess(data));
        } catch (e) {
          emit(NewsFailed(e.toString()));
        }
      }
      if (event is NewsHot) {
        try {
          emit(NewsLoading());
          final data = await NewsService().hotNews();
          emit(NewsSuccess(data));
        } catch (e) {
          emit(NewsFailed(e.toString()));
        }
      }
      if (event is NewsPublisher) {
        try {
          emit(NewsLoading());
          final data = await NewsService().publisherNews(event.publisher);
          emit(NewsSuccess(data));
        } catch (e) {
          emit(NewsFailed(e.toString()));
        }
      }
    });
  }
}

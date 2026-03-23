import 'package:news/model/news_response.dart';

abstract class NewsState {}

final class NewsInitial extends NewsState {}

final class NewsLoading extends NewsState {}

final class NewsSuccess extends NewsState {
  final List<News> news;
  NewsSuccess(this.news);
}


final class NewsError extends NewsState {
  final String errorMessage;
  NewsError(this.errorMessage);
}

final class MessageState extends NewsState {}
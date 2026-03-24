import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:news/data/repository/news/repo/news_repo.dart';
import 'news_state.dart';

@injectable
class NewsCubit extends Cubit<NewsState> {
  final NewsRepository newsRepository;
  

  NewsCubit({required this.newsRepository}) : super(NewsInitial()) ;
  void getNewsBySourceId(String sourceId) async {
    emit(MessageState());
    emit(NewsLoading());
    try {
      var response = await newsRepository.getNewsBySourceId(sourceId);
      if (response.status == 'ok') {
        emit(NewsSuccess(response.news!));
      }
      if (response.status == 'error') {
        log('Error fetching news: ${response.message}');
        emit(NewsError(response.message!));
      }
    } catch (e) {
      log('Catch Error fetching news: ${e.toString()}');
      emit(NewsError(e.toString()));
      return;
    }
  }
}

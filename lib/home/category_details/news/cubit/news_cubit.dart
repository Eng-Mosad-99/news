import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/api/api_manager.dart';
import 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial());

  void getNewsBySourceId(String sourceId) async {
    emit(MessageState());
    emit(NewsLoading());
    try {
      var response = await ApiManager.getNewsBySourceId(sourceId);
      if (response?.status == 'ok') {
        emit(NewsSuccess(response!.news!));
      }
      if (response?.status == 'error') {
        log('Error fetching news: ${response?.message}');
        emit(NewsError(response!.message!));
      }
    } catch (e) {
      log('Catch Error fetching news: ${e.toString()}');
      emit(NewsError(e.toString()));
      return;
    }
  }
}

import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/api/api_manager.dart';
import 'package:news/home/category_details/cubit/category_states.dart';
import 'package:news/model/source_response.dart';

class CategoryCubit extends Cubit<CategoryState>{
  CategoryCubit() : super(CategoryInitial());

  List<Source>? sources ;
  String? errorMessage ;

  void getSources({required String categoryId}) async {
    emit(CategoryLoading());
    try {
      var response = await ApiManager.getSources(categoryId: categoryId);
      if (response?.status == 'ok') {
        sources = response?.sources;
        emit(CategorySuccess());
      } 
      if (response?.status == 'error') {
        errorMessage = response?.message;
        log('Error fetching sources: ${response?.message}');
        emit(CategoryError());
      }
    }catch (e) {
      errorMessage = e.toString();
      log('Catch Error fetching sources: $errorMessage');
      emit(CategoryError());
    }
}
}
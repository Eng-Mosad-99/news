import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:news/data/repository/sources/repo/source_repository.dart';
import 'package:news/home/category_details/cubit/category_states.dart';
import 'package:news/model/source_response.dart';
@injectable
class CategoryCubit extends Cubit<CategoryState>{
 final SourceRepository sourceRepository;
  CategoryCubit({required this.sourceRepository}) : super(CategoryInitial());

  List<Source>? sources ;
  String? errorMessage ;

  void getSources({required String categoryId}) async {
    emit(CategoryLoading());
    try {
      var response = await sourceRepository.getSources(categoryId: categoryId);
      if (response.status == 'ok') {
        sources = response.sources;
        emit(CategorySuccess());
      } 
      if (response.status == 'error') {
        errorMessage = response.message;
        log('Error fetching sources: ${response.message}');
        emit(CategoryError());
      }
    }catch (e) {
      errorMessage = e.toString();
      log('Catch Error fetching sources: $errorMessage');
      emit(CategoryError());
    }
}
}
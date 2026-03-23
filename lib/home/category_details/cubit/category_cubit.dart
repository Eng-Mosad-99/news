import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/api/api_manager.dart';
import 'package:news/data/repository/sources/data_source/remote/impl/source_remote_data_source_impl.dart';
import 'package:news/data/repository/sources/data_source/remote/source_remote_data_source.dart';
import 'package:news/data/repository/sources/repo/impl/source_repo_impl.dart';
import 'package:news/data/repository/sources/repo/source_repository.dart';
import 'package:news/home/category_details/cubit/category_states.dart';
import 'package:news/model/source_response.dart';

class CategoryCubit extends Cubit<CategoryState>{
 late SourceRepository sourceRepository;
  late ApiManager apiManager;
  late SourceRemoteDataSource sourceRemoteDataSource;
  CategoryCubit() : super(CategoryInitial()){
    apiManager = ApiManager();
    sourceRemoteDataSource = SourceRemoteDataSourceImpl(apiManager: apiManager);
    sourceRepository = SourceRepoImpl(sourceRemoteDataSource: sourceRemoteDataSource);
  }

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
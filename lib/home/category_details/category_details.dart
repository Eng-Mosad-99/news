import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news/api/app_exception.dart';
import 'package:news/api/dio_api_manager.dart';
import 'package:news/home/category_details/sources/source_tab_widget.dart';
import 'package:news/model/category.dart';
import 'package:news/model/source_response.dart';
import 'package:news/utils/app_colors.dart';

class CategoryDetails extends StatelessWidget {
  const CategoryDetails({super.key, required this.category});
  final Category category;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SourceResponse?>(
      future: DioApiManager().getSources(categoryId: category.id),
      builder: (context, snapshot) {
        //todo: loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.greyColor),
          );
        }
        //todo: error => client
        else if (snapshot.hasError) {
          String errorMessage;
          if (snapshot.error is DioException &&
              (snapshot.error as DioException).error is AppException) {
            errorMessage =
                ((snapshot.error as DioException).error as AppException)
                    .message;
          }else{
            errorMessage = snapshot.error.toString();
          }
          return Column(
            children: [
              Text(
                errorMessage,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.greyColor,
                ),
                onPressed: () {
                  DioApiManager().getSources(categoryId: category.id);
                },
                child: Text(
                  'Try Again',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ],
          );
        }
        //todo: server => response => success , error
        //todo: server => error
        // if (snapshot.data?.status != 'ok') {
        //   return Column(
        //     children: [
        //       Text(
        //         snapshot.data!.message!,
        //         style: Theme.of(context).textTheme.labelMedium,
        //       ),
        //       ElevatedButton(
        //         style: ElevatedButton.styleFrom(
        //           backgroundColor: AppColors.greyColor,
        //         ),
        //         onPressed: () {
        //           DioApiManager().getSources(categoryId: category.id);
        //         },
        //         child: Text(
        //           'Try Again',
        //           style: Theme.of(context).textTheme.labelMedium,
        //         ),
        //       ),
        //     ],
        //   );
        // }
        //todo: server => success
        else if(snapshot.hasData){
        var sourcesList = snapshot.data?.sources ;
        if (sourcesList == null || sourcesList.isEmpty) {
          return  Center(
            child: Text('No sources found',style: Theme.of( context).textTheme.headlineMedium,),
          );
        }else{
          return SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SourceTabWidget(sourcesList: sourcesList),
        );
        }
        }else{
         return  Center(
            child: Text('Starting Fetching Sources',style: Theme.of( context).textTheme.headlineMedium,),
          );
        }
      
      },
    );
  }
}

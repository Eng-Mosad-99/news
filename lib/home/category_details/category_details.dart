import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/di/di.dart';
import 'package:news/di/di_injectable.dart';
import 'package:news/home/category_details/cubit/category_cubit.dart';
import 'package:news/home/category_details/cubit/category_states.dart';
import 'package:news/home/category_details/sources/source_tab_widget.dart';
import 'package:news/model/category.dart';
import 'package:news/utils/app_colors.dart';

class CategoryDetails extends StatelessWidget {
  const CategoryDetails({super.key, required this.category});
  final Category category;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<CategoryCubit>()
            ..getSources(categoryId: category.id),
      child: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          CategoryCubit cubit = context.read<CategoryCubit>();
          if (state is CategoryError) {
            return Column(
              children: [
                Text(
                  cubit.errorMessage ?? 'An error occurred',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.greyColor,
                  ),
                  onPressed: () {
                    cubit.getSources(categoryId: category.id);
                  },
                  child: Text(
                    'Try Again',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              ],
            );
          } else if (state is CategorySuccess) {
            var sourcesList = cubit.sources;
            if (sourcesList == null || sourcesList.isEmpty) {
              return Center(
                child: Text(
                  'No sources found',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              );
            } else {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: SourceTabWidget(sourcesList: sourcesList),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.greyColor),
            );
          }
        },
      ),
    );
    // FutureBuilder<SourceResponse?>(
    //   future: DioApiManager().getSources(categoryId: category.id),
    //   builder: (context, snapshot) {
    //     //todo: loading
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return const Center(
    //         child: CircularProgressIndicator(color: AppColors.greyColor),
    //       );
    //     }
    //     //todo: error => client
    //     else if (snapshot.hasError) {
    //       String errorMessage;
    //       if (snapshot.error is DioException &&
    //           (snapshot.error as DioException).error is AppException) {
    //         errorMessage =
    //             ((snapshot.error as DioException).error as AppException)
    //                 .message;
    //       }else{
    //         errorMessage = snapshot.error.toString();
    //       }
    //       return Column(
    //         children: [
    //           Text(
    //             errorMessage,
    //             style: Theme.of(context).textTheme.labelMedium,
    //           ),
    //           ElevatedButton(
    //             style: ElevatedButton.styleFrom(
    //               backgroundColor: AppColors.greyColor,
    //             ),
    //             onPressed: () {
    //               DioApiManager().getSources(categoryId: category.id);
    //             },
    //             child: Text(
    //               'Try Again',
    //               style: Theme.of(context).textTheme.labelMedium,
    //             ),
    //           ),
    //         ],
    //       );
    //     }
    //     //todo: server => response => success , error
    //     //todo: server => error
    //     // if (snapshot.data?.status != 'ok') {
    //     //   return Column(
    //     //     children: [
    //     //       Text(
    //     //         snapshot.data!.message!,
    //     //         style: Theme.of(context).textTheme.labelMedium,
    //     //       ),
    //     //       ElevatedButton(
    //     //         style: ElevatedButton.styleFrom(
    //     //           backgroundColor: AppColors.greyColor,
    //     //         ),
    //     //         onPressed: () {
    //     //           DioApiManager().getSources(categoryId: category.id);
    //     //         },
    //     //         child: Text(
    //     //           'Try Again',
    //     //           style: Theme.of(context).textTheme.labelMedium,
    //     //         ),
    //     //       ),
    //     //     ],
    //     //   );
    //     // }
    //     //todo: server => success
    //     else if(snapshot.hasData){
    //     var sourcesList = snapshot.data?.sources ;
    //     if (sourcesList == null || sourcesList.isEmpty) {
    //       return  Center(
    //         child: Text('No sources found',style: Theme.of( context).textTheme.headlineMedium,),
    //       );
    //     }else{
    //       return SizedBox(
    //       height: MediaQuery.of(context).size.height,
    //       child: SourceTabWidget(sourcesList: sourcesList),
    //     );
    //     }
    //     }else{
    //      return  Center(
    //         child: Text('Starting Fetching Sources',style: Theme.of( context).textTheme.headlineMedium,),
    //       );
    //     }
    //   },
    // );
  }
}

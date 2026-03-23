import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/api/dio_api_manager.dart';
import 'package:news/home/category_details/news/cubit/news_cubit.dart';
import 'package:news/home/category_details/news/cubit/news_state.dart';
import 'package:news/home/category_details/news/news_item.dart';
import 'package:news/model/news_response.dart';
import 'package:news/model/source_response.dart';
import 'package:news/utils/app_colors.dart';

class NewsWidget extends StatelessWidget {
  final Source source;

  const NewsWidget({super.key, required this.source});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      bloc: NewsCubit()..getNewsBySourceId(source.id ?? ''),
      listener: (context, state) {
        if (state is MessageState) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text('Error In Loading News...'),
                actions: [
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
        }
      },
      listenWhen: (previous, current) {
        if(current is MessageState) {
          return true;
        }
        return false;
      },
      buildWhen: (previous, current) {
        if(current is MessageState) {
          return false;
        }
        return true;
        
      },
      builder: (context, state) {
        if (state is NewsError) {
          return Column(
            children: [
              Text(
                state.errorMessage,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.greyColor,
                ),
                onPressed: () {
                  context.read<NewsCubit>().getNewsBySourceId(source.id ?? '');
                },
                child: Text(
                  'Try Again',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ],
          );
        } else if (state is NewsSuccess) {
          var newsList = state.news;
          if (newsList.isEmpty) {
            return Center(
              child: Text(
                'No news found',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            );
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              return NewsItem(news: newsList[index]);
            },
            itemCount: newsList.length,
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.greyColor),
          );
        }
      },
    );
    // FutureBuilder<NewsResponse?>(
    //   future: DioApiManager().getNewsBySourceId(source.id ?? ''),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return const Center(
    //         child: CircularProgressIndicator(color: AppColors.greyColor),
    //       );
    //     } else if (snapshot.hasError) {
    //       return Column(
    //         children: [
    //           Text(
    //             'Something went wrong',
    //             style: Theme.of(context).textTheme.labelMedium,
    //           ),
    //           ElevatedButton(
    //             style: ElevatedButton.styleFrom(
    //               backgroundColor: AppColors.greyColor,
    //             ),
    //             onPressed: () {
    //               DioApiManager().getNewsBySourceId(source.id ?? '');
    //             },
    //             child: Text(
    //               'Try Again',
    //               style: Theme.of(context).textTheme.labelMedium,
    //             ),
    //           ),
    //         ],
    //       );
    //     }
    //     if (snapshot.data?.status != 'ok') {
    //       return Column(
    //         children: [
    //           Text(
    //             snapshot.data!.message!,
    //             style: Theme.of(context).textTheme.labelMedium,
    //           ),
    //           ElevatedButton(
    //             style: ElevatedButton.styleFrom(
    //               backgroundColor: AppColors.greyColor,
    //             ),
    //             onPressed: () {
    //               DioApiManager().getNewsBySourceId(source.id ?? '');
    //             },
    //             child: Text(
    //               'Try Again',
    //               style: Theme.of(context).textTheme.labelMedium,
    //             ),
    //           ),
    //         ],
    //       );
    //     }
    //     var newsList = snapshot.data?.news ?? [];
    //     return ListView.builder(
    //       itemBuilder: (context, index) {
    //         return NewsItem(news: newsList[index]);
    //       },
    //       itemCount: newsList.length,
    //     );
    //   },
    // );
  }
}

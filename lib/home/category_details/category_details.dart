import 'package:flutter/material.dart';
import 'package:news/api/api_manager.dart';
import 'package:news/home/category_details/sources/source_tab_widget.dart';
import 'package:news/model/source_response.dart';
import 'package:news/utils/app_colors.dart';

class CategoryDetails extends StatelessWidget {
  const CategoryDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return     FutureBuilder<SourceResponse?>(
      future: ApiManager.getSources(),
      builder: (context, snapshot) {
        //todo: loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.greyColor,
            ),
          );
        }
        //todo: error => client
        else if (snapshot.hasError) {
          return Column(
            children: [
              Text(
                'Something went wrong',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.greyColor),
                  onPressed: () {
                    ApiManager.getSources();
                  },
                  child: Text(
                    'Try Again',
                    style: Theme.of(context).textTheme.labelMedium,
                  ))
            ],
          );
        }
        //todo: server => response => success , error
        //todo: server => error
        if (snapshot.data?.status != 'ok') {
          return Column(
            children: [
              Text(
                snapshot.data!.message!,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.greyColor),
                  onPressed: () {
                    ApiManager.getSources();
                   
                  },
                  child: Text(
                    'Try Again',
                    style: Theme.of(context).textTheme.labelMedium,
                  ))
            ],
          );
        }
        //todo: server => success
        var sourcesList = snapshot.data?.sources ?? [];
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SourceTabWidget(sourcesList: sourcesList),
        );
      },
    );
    }
}

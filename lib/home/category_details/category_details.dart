import 'package:flutter/material.dart';
import 'package:news/api/api_manager.dart';
import 'package:news/home/category_details/sources/source_tab_widget.dart';
import 'package:news/model/source_response.dart';
import 'package:news/utils/app_colors.dart';

class CategoryDetails extends StatelessWidget {
  const CategoryDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SourceResponse?>(
      future: ApiManager.getSources(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.greyColor),
          );
        } else if (snapshot.hasError) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Error: ${snapshot.error}'),
              ElevatedButton(
                onPressed: () {
                  // Trigger a rebuild to retry fetching data
                  ApiManager.getSources();
                },
                child: const Text('Retry'),
              ),
            ],
          );
        }
        if (snapshot.data?.status != 'ok') {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Error: ${snapshot.data!.message}'),
              ElevatedButton(
                onPressed: () {
                  // Trigger a rebuild to retry fetching data
                  ApiManager.getSources();
                },
                child: const Text('Retry'),
              ),
            ],
          );
        } else {
          SourceResponse sourceResponse = snapshot.data!;
          return SizedBox(
            height: 30,
            child: ListView.builder(
              itemCount: sourceResponse.sources?.length,
              itemBuilder: (context, index) {
                return SourceTabWidget(sourcesList: sourceResponse.sources!);
              },
            ),
          );
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:news/utils/app_colors.dart';
import 'package:news/utils/app_styles.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    return Container(
      color: AppColors.blackColor,
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: height * 0.20,
            color: AppColors.whiteColor,
            child: Text('News App', style: AppStyles.bold24Black),
          ),
          SizedBox(height: height * 0.02),
        ],
      ),
    );
  }
}

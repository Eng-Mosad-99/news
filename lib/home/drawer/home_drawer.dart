import 'package:flutter/material.dart';
import 'package:news/home/drawer/widget/app_config_bottom_sheet.dart';
import 'package:news/home/drawer/widget/drawer_item.dart';
import 'package:news/utils/app_colors.dart';
import 'package:news/utils/app_styles.dart';
import 'package:news/utils/assets_manager.dart';

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
           SizedBox(
            height: height * 0.02,
          ),
          InkWell(
              onTap: () {
                //todo: go to home
                
              },
              child:
                  DrawerItem(icon: AssetsManager.homeIcon, text: 'Go To Home')),
          Divider(
            color: AppColors.whiteColor,
            thickness: 2,
            indent: width * 0.04,
            endIndent: width * 0.04,
          ),
          DrawerItem(icon: AssetsManager.themeIcon, text: 'Theme'),
          AppConfigBottomSheet(text: 'Dark'),
          SizedBox(
            height: height * 0.02,
          ),
          Divider(
            color: AppColors.whiteColor,
            thickness: 2,
            indent: width * 0.04,
            endIndent: width * 0.04,
          ),
          DrawerItem(icon: AssetsManager.languageIcon, text: 'Language'),
          AppConfigBottomSheet(text: 'English'),
        ],
      ),
    );
  }
}
